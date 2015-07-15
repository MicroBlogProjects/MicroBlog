//
//  ProfileStasusController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/10.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileStasusController.h"
#import "StatusDetailViewController.h"
#import "LoadMoreFootView.h"

@interface ProfileStasusController ()
@property (nonatomic , strong) NSMutableArray *statusFrameModels;

@end

@implementation ProfileStasusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部微博";
    
    //加载第一次数据
    [self setupDownRefresh];
    //集成上拉刷新控件
    [self setupUpRefresh];
}
//集成上拉刷新控件
-(void)setupUpRefresh{
    
    LoadMoreFootView *footer = [LoadMoreFootView footer];
    footer.hidden =YES;
    self.tableView.tableFooterView =footer;
    
}
- (void)setupDownRefresh{
    UIRefreshControl * fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
    
    //进入刷新状态;
    [fresh beginRefreshing];
    [self loadNewStatus:fresh];
}

/**
 *  下啦刷新
 *
 *  @param control 控件
 */
-(void)loadNewStatus:(UIRefreshControl *)control{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
    StatusFrameModel *firstStatus = [self.statusFrameModels firstObject];
    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
        
        params[@"since_id"] = firstStatus.statusModel.idstr;
    }
    [manager GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将StatusModel数组 转换成 StatusFrameModel数组
        NSMutableArray *newsFrames = [NSMutableArray array];
        for(StatusModel *statusModel in newStatuses){
            StatusFrameModel *f = [[StatusFrameModel alloc]init];
            f.statusModel = statusModel ;
            [newsFrames addObject:f];
        }
        
        
        //把最新的微博数组，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrameModels insertObjects:newsFrames atIndexes:indexSet];
//        NSLog(@"%ld",self.statusFrameModels.count);
        
        //刷新表格
        [self.tableView reloadData];
        
        //菊花停止转动
        [control endRefreshing];
        
        //显示最新微博的数量
        //        [self showNewStatusCount:(int)newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //菊花停止转动
        [control endRefreshing];
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrameModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *ID = @"ProfileCell" ;
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.baseFrameModel =  self.statusFrameModels[indexPath.row];
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrameModel * frame = self.statusFrameModels[indexPath.row];
    
    return frame.cellHeight ;
}
/**
 *  statuses懒加载
 */
-(NSMutableArray *)statusFrameModels{
    if(_statusFrameModels == nil){
        _statusFrameModels = [NSMutableArray array];
    }
    return _statusFrameModels ;
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailViewController *statusDetail = [[StatusDetailViewController alloc]init];
    StatusFrameModel *frameModel = _statusFrameModels[indexPath.row];
    statusDetail.statusModel = frameModel.statusModel;
    
    [self.navigationController pushViewController:statusDetail animated:YES] ;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // scrollView = self.tableView = self.view
    //如果tableView还没有数据，就直接返回
    if(self.statusFrameModels.count==0 || self.tableView.tableFooterView.isHidden == NO)return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
    
}
-(void)loadMoreStatus{
    
    
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account= [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出scrollView中最后一条微博
    StatusFrameModel *lastStatus = [self.statusFrameModels lastObject];
    if(lastStatus){
        //若指定此参数，则返回ID小于或等于max_id的微博。默认为0
        //id这种数据一般比较大，转化成整数最好用long long
        long long maxID = lastStatus.statusModel.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxID);
    }
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        //将“微博字典”数组 转为 “微博模型”数组
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将StatusModel数组 转换成 StatusFrameModel数组
        NSMutableArray *newsFrames = [NSMutableArray array];
        for(StatusModel *statusModel in newStatuses){
            StatusFrameModel *f = [[StatusFrameModel alloc]init];
            f.statusModel = statusModel ;
            [newsFrames addObject:f];
        }
        
        //将微博添加到微博数组最后面
        [self.statusFrameModels addObjectsFromArray:newsFrames];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新后，隐藏Footer
        self.tableView.tableFooterView.hidden = YES;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 - %@",error);
        //结束刷新
        self.tableView.tableFooterView.hidden =YES ;
    }];
}
@end

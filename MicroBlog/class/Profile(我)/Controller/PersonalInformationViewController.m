//
//  PersonalInformationViewController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonInformationViewCell.h"
#import "ProfileUserModel.h"
#import "ProfileToolButtonCell.h"
#import "DIYSegmentViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "MJExtension.h"
#import "StatusCell.h"
#import "DIYSegmentViewController.h"
#import "StatusDetailViewController.h"
#import "LoadMoreFootView.h"
#import "PhotoCollectionViewCell.h"

static NSString * const DIY = @"DIYcell";

@interface PersonalInformationViewController ()<UITableViewDataSource,UITableViewDelegate,DIYSegmentDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) NSMutableArray *statusFrameModels;
//个人用户信息;
@property (nonatomic,strong) ProfileUserModel* userModel;
@property (nonatomic,assign) NSInteger buttonTag;
@property (nonatomic,strong) DIYSegmentViewController * DIYSegment;
@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = myColor(239, 239, 239);
    //代理传值 从上个界面将需要的值传递到这个界面
    self.userModel = [self.personInfoDelegate passValue];
//    NSLog(@"%ld",self.userModel.uid);
    //  设置个人信息页面的默认页面（微博页面）
    self.buttonTag = 2;
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
//集成上啦刷新
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
    //           @"https://api.weibo.com/2/statuses/user_timeline.json"
    [manager GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    }
    else
    {
        if (self.buttonTag == 2) {
            return self.statusFrameModels.count;
        }
        else if(self.buttonTag == 1)
        {
            return 4;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        static NSString * ID = @"PersonInfoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[PersonInformationViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andPersonInfo:self.userModel];
            UIView *tempView = [[UIView alloc] init] ;
            [cell setBackgroundView:tempView];
            cell.backgroundColor = [UIColor clearColor];
            tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else if (indexPath.section ==1)
    {
        static NSString * ID = @"ProfileToolButtonCell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            self.DIYSegment = [[DIYSegmentViewController alloc]init];
            self.DIYSegment.personInfoController = self;
            cell = [[ProfileToolButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andDIYsegment:self.DIYSegment];
        }
        
    }
    else{
        
        //微博页面的cell
        if (self.buttonTag == 2) {
            //获得cell
            static NSString *ID = @"profileInformationCell" ;
            StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if(cell ==nil){
                cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            //    //取出这行cell对应的微博字典
            StatusFrameModel *statusFrameModel = self.statusFrameModels[indexPath.row];
            cell.baseFrameModel = statusFrameModel;
            return  cell;
        }
        //主页页面的cell
        else if (self.buttonTag == 1){
            static NSString * ID = @"homaPageCell";
            cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.textLabel.textColor = [UIColor grayColor];
            if (indexPath.row == 1) {
                cell.textLabel.text = @"就职于   无";
            }
            else if(indexPath.row == 2)
                cell.textLabel.text = @"毕业于   无";
            else if (indexPath.row == 3)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"所在地   %@",self.userModel.location];
            }
            else {
                cell.textLabel.text = @"基本信息";
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
//        //照片界面
//        else if (self.buttonTag == 3){
//             NSLog(@"111");
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celllll"];
//            CGFloat  width = [[UIScreen mainScreen]bounds].size.width;
//            CGFloat  hight = [[UIScreen mainScreen]bounds].size.height;
//            CGRect fram = CGRectMake(0, self.userModel.cellHight + kStatusCellBorderWidth, width, hight - self.userModel.cellHight - kStatusCellBorderWidth);
//            UICollectionViewLayout * layout = [[UICollectionViewLayout alloc]init];
//            UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:fram collectionViewLayout:layout];
//            collectionView.delegate = self;
//            collectionView.dataSource = self;
//            [collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:DIY];
//            [cell addSubview:collectionView];
//        }
    }
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.userModel.cellHight;
    }
    else if (indexPath.section ==1){
        return [[UIScreen mainScreen]bounds].size.height / 12;
    }
    else{
        if (self.buttonTag == 2) {
            StatusFrameModel * frame = self.statusFrameModels[indexPath.row];
            return frame.cellHeight ;
        }
        else return 44.0;
    }
}
//懒加载
-(NSMutableArray *)statusFrameModels{
    if(_statusFrameModels == nil){
        _statusFrameModels = [NSMutableArray array];
    }
    return _statusFrameModels ;
}

//由DIY界面穿回来的页面交换信号
-(void)exchangeView:(NSInteger)tag;
{
    self.buttonTag = tag;
//    NSLog(@"%ld",self.buttonTag);
    [self.tableView reloadData];
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 1) return;
    if (self.buttonTag != 2) {
        return;
    }
    StatusDetailViewController *statusDetail = [[StatusDetailViewController alloc]init];
    StatusFrameModel *frameModel = _statusFrameModels[indexPath.row];
    statusDetail.statusModel = frameModel.statusModel;
    
    [self.navigationController pushViewController:statusDetail animated:YES] ;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //不是微博界面不加载
    if(self.buttonTag != 2)
        return;
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


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 20;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:DIY forIndexPath:indexPath];
//    [cell sizeToFit];
//    return cell;
//}
////每个collectionView就是一个cell
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat width = ([[UIScreen mainScreen]bounds].size.width - 4 *kStatusCellBorderWidth)/3;
//    return CGSizeMake(width, width);
//}
////定义每个UICollectionView 的间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5,5,5,5);
//}
////是否可以点击
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
@end

//
//  CommentTableViewController.m
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentTableViewController.h"
#import "TitleButton.h"
#import "DropDownMenu.h"
#import "MessageMenuTableViewController.h"
#import "AccountModel.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "StatusModel.h"
#import "StatusFrameModel.h"
#import "MJExtension.h"
#import "LoadMoreFootView.h"
#import "StatusCell.h"
#import "DelayUITableview.h"
#import "ToolBar.h"
#import "CommentViewController.h"
#import "NavigationController.h"
#import "StatusDetailViewController.h"
#import "CommentCellModel.h"
#import "CommentTableViewCell.h"
#import "CommentStatusModel.h"
#import "CommentTableViewController.h"
#define CommentURL @"https://api.weibo.com/2/comments/timeline.json"
@interface CommentTableViewController ()<DropDownMenuDelegate>
@property (nonatomic,strong)NSMutableArray *atmeFramwModels;
@end

@implementation CommentTableViewController
-(NSMutableArray *)atmeFramwModels {
    if(!_atmeFramwModels){
        _atmeFramwModels=[NSMutableArray array];
    }
    return _atmeFramwModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DelayUITableview *tableView=[[DelayUITableview alloc]init];
    self.tableView=tableView;
    self.tableView.backgroundColor=myColor(239, 239, 239);
    [self setupNavigationBar];
    //下拉刷新数据 现显示现在的数据
    
    [self setupDownRefresh];
    //集成上拉刷新控件
    [self setupUpRefresh];
    
}
/**
 *  集成上拉刷新控件
 */
-(void)setupUpRefresh{
    
    LoadMoreFootView *footer = [LoadMoreFootView footer];
    footer.hidden =YES;
    self.tableView.tableFooterView =footer;
    
}
/**
 *  集成下拉刷新控件
 */
-(void)setupDownRefresh{
    
    UIRefreshControl *fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
    
    //马上进入刷新状态
    [fresh beginRefreshing];
    [self loadNewStatus:fresh];
}

/**
 *  下拉刷新
 */
-(void)loadNewStatus:(UIRefreshControl *)control{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
    CommentStatusModel *firstStatus = [self.atmeFramwModels firstObject];
    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
        params[@"since_id"] = firstStatus.commentCellModel.idstr;
    }
    params[@"count"] = @20;
    
    //3.发送请求
    [manager GET:CommentURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        
        
        NSArray *newStatuses = [CommentCellModel objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        
        //将StatusModel数组 转换成 StatusFrameModel数组
        NSMutableArray *newsFrames = [NSMutableArray array];
        for( CommentCellModel *commentCellModel in newStatuses){
           
            CommentStatusModel *f = [[CommentStatusModel alloc]init];
         
            f.commentCellModel  = commentCellModel ;
          
            [newsFrames addObject:f];
        }
        NSRange range=NSMakeRange(0, newsFrames.count);
        NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.atmeFramwModels insertObjects:newsFrames atIndexes:indexSet];
        //刷新表格
        [self.tableView reloadData];
        //菊花停止转动
        [control endRefreshing];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //菊花停止转动
        [control endRefreshing];
        NSLog(@"%@",error);
    }];
    
}


/**
 *   上拉加载更多微博
 */
-(void)loadMoreStatus{
    
    
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account= [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出scrollView中最后一条微博
    CommentStatusModel *lastStatus = [self.atmeFramwModels lastObject];
    if(lastStatus){
        //若指定此参数，则返回ID小于或等于max_id的微博。默认为0
        //id这种数据一般比较大，转化成整数最好用long long
        long long maxID = lastStatus.commentCellModel.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxID);
    }
    params[@"count"] = @20;
    //3.发送请求
    [manager GET:CommentURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将“微博字典”数组 转为 “微博模型”数组
        NSArray *newStatuses = [CommentCellModel objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        
        //将StatusModel数组 转换成 StatusFrameModel数组
        NSMutableArray *newsFrames = [NSMutableArray array];
        for(CommentCellModel *commentcellModel in newStatuses){
            CommentStatusModel *f = [[CommentStatusModel alloc]init];
            f.commentCellModel = commentcellModel ;
            [newsFrames addObject:f];
        }
        
        //将微博添加到微博数组最后面
        [self.atmeFramwModels addObjectsFromArray:newsFrames];
        
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















-(void)setupNavigationBar{
    TitleButton *titleButton=[[TitleButton alloc] init];
    [titleButton setTitle:@"所有微博" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=titleButton;
}
-(void)titleClick:(UIButton *)titleButton
{
    DropDownMenu *menu=[DropDownMenu menu];
    MessageMenuTableViewController *menuTable=[[MessageMenuTableViewController alloc]init];
    menuTable.menuarray=@[@"所有微博",@"关注人的微博",@"原创微博",@"所有评论",@"所有关注人的评论"];
    menuTable.view.height=44*3;
    menuTable.view.width=217;
    menu.contentController=menuTable;
    menu.delegate=self;
    [menu showFrom:titleButton];
    titleButton.selected =YES;
}
#pragma mark - dropDownMenuDelegate代理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu {
    UIButton *titleButton=(UIButton *)self.navigationItem.titleView;
    titleButton.selected=NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.atmeFramwModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentStatusModel *f=self.atmeFramwModels[indexPath.row];
    return f.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"CommentTableViewCell" ;
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.commentBaseFramModel= self.atmeFramwModels[indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    return  cell;
}

/**
 *  当视图滚动时调用该方法
 *  目的：当滚动到可以看到最后一个cell的时候，获取更多的微博信息
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // scrollView = self.tableView = self.view
    //如果tableView还没有数据，就直接返回
    if(self.atmeFramwModels.count==0 || self.tableView.tableFooterView.isHidden == NO)return;
    
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

@end

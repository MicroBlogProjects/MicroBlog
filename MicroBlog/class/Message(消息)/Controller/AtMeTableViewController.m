//
//  AtMeTableViewController.m
//  MicroBlog
//
//  Created by opas on 15/7/12.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "AtMeTableViewController.h"
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
@interface AtMeTableViewController ()<DropDownMenuDelegate>
@property (nonatomic,strong)NSMutableArray *atmeFramwModels;
@end

@implementation AtMeTableViewController
-(NSMutableArray *)atmeFramwModels {
    if(_atmeFramwModels){
        _atmeFramwModels=[NSMutableArray array];
    }
    return _atmeFramwModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSLog(@"hahaha");
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
    StatusFrameModel *firstStatus = [self.atmeFramwModels firstObject];
    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
        params[@"since_id"] = firstStatus.statusModel.idstr;
    }
    params[@"count"] = @2;
    /*
     赖伟煌的迷你微博
     access_token=2.004nnkxBNS6mBB72a37612fdviOKvD
     uid=1799091161
     App Key：304647707
     App Secret：533cfea336e04f236c469931f5d40a7c
     
     
     迷你微博应用
     access_token=2.004nnkxB0hmQc1ca9521a831L5MZsB
     uid=1799091161
     App key : 942446141
     App Secret : 387ea016d0c2baa3fb73ca00ac3ec049
     
     */
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
  
    return self.atmeFramwModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrameModel *frame=self.atmeFramwModels[indexPath.row];
    return frame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"StatusCell" ;
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.baseFrameModel = self.atmeFramwModels[indexPath.row];
    
    return  cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

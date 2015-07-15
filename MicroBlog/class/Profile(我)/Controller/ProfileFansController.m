//
//  ProfileFansController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileFansController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "ProfileFansModelList.h"
#import "ProfileUserModel.h"
#import "ProfileFansCell.h"
#import "PersonalInformationViewController.h"

@interface ProfileFansController ()
@property (nonatomic , strong)ProfileFansModelList * fansList;
@property (nonatomic , strong)NSMutableArray * uidArray;
//@property (nonatomic , strong)ProfileUserModel *delegateValue;
@end

@implementation ProfileFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"粉丝";
    //加载第一次数据
    [self setupDownRefresh];
}
- (void)setupDownRefresh{

    UIRefreshControl * fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(loadUID:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
    
    //进入刷新状态;
    [fresh beginRefreshing];
    [self loadUID:fresh];
}
//下再用户信息
-(void)loadNewFans:(UIRefreshControl *)control{
//    NSLog(@"%@",self.uidArray);
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    params[@"cursor"] =  [NSString stringWithFormat:@"%ld",self.fansList.next_cursor];
    [manager GET:@"https://api.weibo.com/2/friendships/followers.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self setProfileFansModelList:responseObject];
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
//下载用户uid
- (void)loadUID:(UIRefreshControl *)control
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    params[@"cursor"] =  [NSString stringWithFormat:@"%ld",self.fansList.next_cursor];
    [manager GET:@"https://api.weibo.com/2/friendships/followers/ids.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.uidArray = [responseObject objectForKey:@"ids"];
        [self loadNewFans:control];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//懒加载
- (ProfileFansModelList *)fansList
{
    if (_fansList == nil) {
        _fansList = [[ProfileFansModelList alloc]init];
        _fansList.profileFansList = [[NSMutableArray alloc]init];
    }
    return _fansList;
}

-(void) setProfileFansModelList:(id)responseObject
{
    self.fansList.display_total_number = [[responseObject objectForKey:@"display_total_number"]integerValue];
    self.fansList.next_cursor = [[responseObject objectForKey:@"next_cursor"]integerValue];
    self.fansList.previous_cursor = [[responseObject objectForKey:@"previous_cursor"]integerValue];
    NSArray * fansModelArray = [responseObject objectForKey:@"users"];
    //倒序插入
    for (NSInteger i = 0; i < fansModelArray.count ; i++) {
        NSDictionary * fansModel = [fansModelArray objectAtIndex:i];
        ProfileUserModel * userModel = [[ProfileUserModel alloc]init];
        //uid
        userModel.uid = [[self.uidArray objectAtIndex:i]integerValue];
        //图片地址
        userModel.avatar_large = [fansModel objectForKey:@"avatar_large"];
        //昵称
        userModel.screen_name = [fansModel objectForKey:@"screen_name"];
        //个人简介
        userModel.descrip = [fansModel objectForKey:@"description"];
        //地址
        userModel.location = [fansModel objectForKey:@"location"];
        //vip等级
        userModel.mbtype = [[fansModel objectForKey:@"mbtype"]integerValue];
        userModel.mbrank = [[fansModel objectForKey:@"mbrank"]integerValue];
        [self.fansList.profileFansList insertObject:userModel atIndex:0];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.fansList.profileFansList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell *cell = [[ProfileFansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andPersonInfo:[self.fansList.profileFansList objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileUserModel * model = [self.fansList.profileFansList objectAtIndex:indexPath.row];
    return model.cellHight;
}

/** 以下两个函数功能：使Cell中添加图片不会导致分割线被裁减一部分 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end

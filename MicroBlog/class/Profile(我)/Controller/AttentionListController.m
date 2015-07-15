//
//  AttentionListController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "AttentionListController.h"
#import "ProfileFansModelList.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "ProfileUserModel.h"
#import "ProfileFansCell.h"
#import "ProfileFansCell.h"

@interface AttentionListController ()
@property (nonatomic , strong) ProfileFansModelList * attentionModel;
@end

@implementation AttentionListController

/**
 *  懒加载
 */
- (ProfileFansModelList *)attentionModel
{
    if (_attentionModel == nil) {
        _attentionModel = [[ProfileFansModelList alloc]init];
        _attentionModel.profileFansList = [[NSMutableArray alloc]init];
    }
    return _attentionModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部关注";
    //加载第一次数据
    [self setupDownRefresh];
    
}

- (void)setupDownRefresh{
    
    UIRefreshControl * fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(loadNewAttention:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
    
    //进入刷新状态;
    [fresh beginRefreshing];
    [self loadNewAttention:fresh];
}


//下再用户信息
-(void)loadNewAttention:(UIRefreshControl *)control{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    params[@"cursor"] =  [NSString stringWithFormat:@"%ld",self.attentionModel.next_cursor];
    [manager GET:@"https://api.weibo.com/2/friendships/friends.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
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

-(void) setProfileFansModelList:(id)responseObject
{
    self.attentionModel.display_total_number = [[responseObject objectForKey:@"display_total_number"]integerValue];
    self.attentionModel.next_cursor = [[responseObject objectForKey:@"next_cursor"]integerValue];
    self.attentionModel.previous_cursor = [[responseObject objectForKey:@"previous_cursor"]integerValue];
    NSArray * fansModelArray = [responseObject objectForKey:@"users"];
    //倒序插入
    for (NSInteger i = 0; i < fansModelArray.count ; i++) {
        NSDictionary * fansModel = [fansModelArray objectAtIndex:i];
        ProfileUserModel * userModel = [[ProfileUserModel alloc]init];
        //图片地址
        userModel.avatar_large = [fansModel objectForKey:@"avatar_large"];
        //昵称
        userModel.screen_name = [fansModel objectForKey:@"screen_name"];
        //个人简介
        userModel.descrip = [fansModel objectForKey:@"description"];
        //vip等级
        userModel.mbtype = [[fansModel objectForKey:@"mbtype"]integerValue];
        userModel.mbrank = [[fansModel objectForKey:@"mbrank"]integerValue];
        [self.attentionModel.profileFansList insertObject:userModel atIndex:0];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else{
        return self.attentionModel.profileFansList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        static NSString * ID = @"cell";
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"我的群";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.imageView.image = [UIImage imageNamed:@"draft"];
            cell.textLabel.text = @"兴趣主页";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else
    {
        static NSString * ID = @"attentioncell";
        ProfileUserModel * userModel = self.attentionModel.profileFansList[indexPath.row];
        cell = [[ProfileFansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andPersonInfo:userModel];
    }
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1 ) {
        return @"全部关注";
    }
    return @"";
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ProfileUserModel * model = [self.attentionModel.profileFansList objectAtIndex:indexPath.row];
        return model.cellHight;
    }
    else return 44.0f;
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

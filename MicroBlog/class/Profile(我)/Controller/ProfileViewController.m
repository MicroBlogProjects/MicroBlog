//
//  ProfileViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileViewController.h"
#import "AFNetworking.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "ProfileUserModel.h"
#import "profileTableViewCell.h"
#import "EditingTableViewController.h"
#import "AddFriendTableViewController.h"
#import "ToolBarCell.h"
#import "PersonalInformationViewController.h"
#import "NavigationController.h"
#import "PhotoController.h"
#import "NewFriendController.h"


@interface ProfileViewController ()<UITableViewDelegate,PersonInfoDelegate>


@property (nonatomic , strong)ProfileUserModel * userModel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = myColor(235, 235, 241);
    self.tableView.backgroundColor =myColor(235, 235, 241);
    //设置代理
    //设置navigationBar
    [self setupNavigationBar];
    //获取用户信息
    [self setUpUserInfo];

}
/**
 *  获取用户信息
 */

-(void)setUpUserInfo
{
    /** 1请求管理者*/
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    /** 2 拼接参数*/
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //创建一个
    //3发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
//        NSLog(@"%@",responseObject);
        //设置得到的数据
        [self setUser:responseObject];
        [self.tableView reloadData];
        
    }failure:^(AFHTTPRequestOperation * operation, NSError * error){
        NSLog(@"%@",error);
     }];
}

/**
 *  设置userModel
 */
-(void)setUser:(id)responseObject
{
    self.userModel = [[ProfileUserModel alloc]init];
    //昵称
    self.userModel.screen_name = [responseObject objectForKey:@"screen_name"];
    //简介
    self.userModel.descrip = [responseObject objectForKey:@"description"];
    //粉丝数量
    self.userModel.followers_count = [[responseObject objectForKey:@"followers_count"] integerValue];
    //关注数
    self.userModel.friends_count = [[responseObject objectForKey:@"friends_count"] integerValue];
    //微博数
    self.userModel.statuses_count = [[responseObject objectForKey:@"statuses_count"] integerValue];
    //图片url
    self.userModel.avatar_large = [responseObject objectForKey:@"avatar_large"];
    //是否为vip
    self.userModel.mbtype = [[responseObject objectForKey:@"mbtype"] integerValue];
    //vip登记
    self.userModel.mbrank = [[responseObject objectForKey:@"mbrank"] integerValue];
    //是否为加V用户
    self.userModel.verified = [[responseObject objectForKey:@"verified"] boolValue];
    self.userModel.location = [responseObject objectForKey:@"location"];
}
/**
 *  设置navigationBar的2个按钮
 */
-(void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(editing)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
}
/**
 *  点击设置键
 */
-(void)editing
{
    EditingTableViewController * editingTableViewController = [[EditingTableViewController alloc]init];
    //设置头tableview高度
    UIView * headerView = [[UIView alloc]initWithFrame:self.view.frame];
    CGRect headerViewFram = headerView.frame;
    headerViewFram.size.height = 10.0f;
    headerView.frame = headerViewFram;
    [editingTableViewController.tableView setTableHeaderView:headerView];
    [self.navigationController pushViewController:editingTableViewController animated:YES];
    
}
/**
 *  点击添加好友键
 */
- (void)addFriend
{
    AddFriendTableViewController * addFriendTableViewConTroller = [[AddFriendTableViewController alloc]init];
    UIView * headerView = [[UIView alloc]initWithFrame:self.view.frame];
    CGRect headerViewFram = headerView.frame;
    headerViewFram.size.height = 55.0f;
    headerView.frame = headerViewFram;
    [addFriendTableViewConTroller.tableView setTableHeaderView:headerView];
    [self.navigationController pushViewController:addFriendTableViewConTroller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//有几节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
//每节多少块
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 2;
            break;
        case 5:
            return 1;
        default:
            return 1;
            break;
    }
    return 0;
}
//每块到cell怎么摆放
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section ==0) {
        static NSString * ID = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[profileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        //下载图片
        [(profileTableViewCell * )cell setProfileUserModel:self.userModel];
    }
    else if (indexPath.section == 1){
        static NSString * ID = @"toolCell";

        cell = [[ToolBarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andProfileUserModel:self.userModel];
    }
    else
    {
        static NSString * ID = @"Celll";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]init];
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"new_friend"];
                cell.textLabel.text = @"新的好友";
            }
            else{
                cell.imageView.image = [UIImage imageNamed:@"collect"];
                cell.textLabel.text = @"微博等级";
            }
        }
        else if (indexPath.section == 3){
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"album"];
                cell.textLabel.text = @"我的相册";
            }
            else if (indexPath.row == 1){
                cell.imageView.image = [UIImage imageNamed:@"collect"];
                cell.textLabel.text = @"我的点评";
            }
            else{
                cell.imageView.image = [UIImage imageNamed:@"like"];
                cell.textLabel.text = @"我的赞";
            }
        }
        else if (indexPath.section == 4){
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"pay"];
                cell.textLabel.text = @"微博支付";
            }
            else if (indexPath.row == 1){
                cell.imageView.image = [UIImage imageNamed:@"vip"];
                cell.textLabel.text = @"微博会员";
            }
            
        }
        else if(indexPath.section == 5)
        {
            cell.textLabel.text = @"草稿箱";
        }
        else{
            cell.textLabel.text = @"更多";
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section != 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
//header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0.0f;
    }
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.userModel.cellHight == 0) {
            return 90;
        }
        else return self.userModel.cellHight;
    }
    else if (indexPath.section ==1)
    {
        if (self.userModel.cellHight == 0) {
            return 50;
        }
        else return self.userModel.cellHight;
    }
    return 44.0f;
}
//代理传值
-(ProfileUserModel *)passValue
{
    return self.userModel;
}
//点击cell函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一个cell
    if (indexPath.section == 0) {
        PersonalInformationViewController * personalInfoView = [[PersonalInformationViewController alloc]init];
        personalInfoView.personInfoDelegate = self;
        [self.navigationController pushViewController:personalInfoView animated:YES];
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
            PhotoController * photoController = [[PhotoController alloc]initWithCollectionViewLayout:flowLayout];
            [self.navigationController pushViewController:photoController animated:YES];
        }
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NewFriendController * newFriendController = [[NewFriendController alloc]init];
            [self.navigationController pushViewController:newFriendController animated:YES];
        }
    }
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

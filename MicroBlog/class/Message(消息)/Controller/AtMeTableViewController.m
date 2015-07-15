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
#import "ProvinceTableViewController.h"
@interface AtMeTableViewController ()
@property (nonatomic,strong)NSMutableArray *countryModels;
@end

@implementation AtMeTableViewController
-(NSMutableArray *)countryModels {
    if(!_countryModels ){
        _countryModels=[NSMutableArray array];
    }
    return _countryModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    //下拉刷新数据 现显示现在的数据
    [self setupDownRefresh];
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
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/common/get_country.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        NSMutableArray *ddd=[NSMutableArray array];
        for (NSDictionary *p in responseObject) {
            [ddd addObject:p];
        }
        self.countryModels=ddd;
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
    [titleButton setTitle:@"地区" forState:UIControlStateNormal];
    self.navigationItem.titleView=titleButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.countryModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"aCell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *from=[NSString stringWithFormat:@"%03ld",indexPath.row+1];
    NSDictionary *dic=self.countryModels[indexPath.row];
    cell.textLabel.text=dic[from];
    return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProvinceTableViewController *pro=[[ProvinceTableViewController alloc] init];
    pro.country=[NSString stringWithFormat:@"%03ld",indexPath.row+1];
    pro.dic=self.countryModels[indexPath.row];
    [self.navigationController pushViewController:pro animated:YES];
}
@end

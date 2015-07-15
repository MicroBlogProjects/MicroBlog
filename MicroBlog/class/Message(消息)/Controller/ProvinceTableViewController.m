//
//  ProvinceTableViewController.m
//  MicroBlog
//
//  Created by administrator on 15/7/15.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProvinceTableViewController.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "TitleButton.h"
@interface ProvinceTableViewController ()
@property (nonatomic,copy)NSMutableArray *provinceArray;
@end

@implementation ProvinceTableViewController
-(NSMutableArray *)provinceArray {
    if(_provinceArray) {
        _provinceArray=[NSMutableArray alloc];
    }
    return _provinceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupDownRefresh];
    
//    NSLog(@"%@ %@",self.country,self.dic);
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
        self.provinceArray=ddd;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

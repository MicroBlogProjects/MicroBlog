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
#import "ProfileFansModel.h"

@interface ProfileFansController ()
@property (nonatomic,strong) NSMutableArray * fansArray;
@end

@implementation ProfileFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载第一次数据
    [self setupDownRefresh];
}
- (void)setupDownRefresh{
    UIRefreshControl * fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
    
    //进入刷新状态;
    [fresh beginRefreshing];
    [self loadNewStatus:fresh];
}

-(void)loadNewStatus:(UIRefreshControl *)control{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
    ProfileFansModel * firstFansModel = [self.fansArray firstObject];
    if(firstFansModel){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
    }
    [manager GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

//        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
//        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        //将StatusModel数组 转换成 StatusFrameModel数组
//        NSMutableArray *newsFrames = [NSMutableArray array];
//        for(StatusModel *statusModel in newStatuses){
//            StatusFrameModel *f = [[StatusFrameModel alloc]init];
//            f.statusModel = statusModel ;
//            [newsFrames addObject:f];
//        }
        
        
//        //把最新的微博数组，添加到总数组的最前面
//        NSRange range = NSMakeRange(0, newStatuses.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrameModels insertObjects:newsFrames atIndexes:indexSet];
     
        //刷新表格
//        [self.tableView reloadData];
     
        //菊花停止转动
//        [control endRefreshing];
     
        //显示最新微博的数量
        //        [self showNewStatusCount:(int)newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //菊花停止转动
        [control endRefreshing];
        NSLog(@"%@",error);
    }];
}

-(NSMutableArray *)fansArray
{
    if (_fansArray == nil) {
        _fansArray = [[NSMutableArray alloc]init];
    }
    return _fansArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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

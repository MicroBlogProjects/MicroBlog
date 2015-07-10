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

@interface PersonalInformationViewController ()<UITableViewDataSource,UITableViewDelegate,DIYSegmentDelegate>
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
    //  设置个人信息页面的默认页面（微博页面）
    self.buttonTag = 2;
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
//            UIView *tempView = [[UIView alloc] init] ;
//            [cell setBackgroundView:tempView];
//            cell.backgroundColor = [UIColor clearColor];
//            tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
            StatusCell *cell = [StatusCell cellWithTablView:tableView];
            //    //取出这行cell对应的微博字典
            StatusFrameModel *statusFrameModel = self.statusFrameModels[indexPath.row];
            cell.statusFrameModel = statusFrameModel;
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
    }
    return cell;
}
//头文件高度
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
    [self.tableView reloadData];
}
@end

//
//  HomeViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  测试使用Git----1

#import "HomeViewController.h"
#import "UIBarButtonItem+DIYButton.h"
#import "MBProgressHUD+MJ.h"
#import "DropDownMenu.h"
#import "MenuTableViewController.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "TitleButton.h"
#import "UIImageView+WebCache.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "LoadMoreFootView.h"
#import "StatusCell.h"
#import "StatusFrameModel.h"
#import "StatusDetailViewController.h"
#import "DelayUITableview.h"


@interface HomeViewController () <DropDownMenuDelegate >

/**
 *  微博数组（里面放的都是StatusModelFrame模型，一个StatusModelFrame就代表一条微博信息）
 */
@property (nonatomic , strong) NSMutableArray *statusFrameModels;

@end
@implementation HomeViewController

- (void)viewDidLoad {
     
    [super viewDidLoad];
    
    // 解决在UITableView的Cell中  按钮快速点击没有高亮的问题
    DelayUITableview *tableView = [[DelayUITableview alloc]init];
    self.tableView  = tableView ; 
    
    self.tableView.backgroundColor =myColor(239, 239, 239);
    
     //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息（昵称）
    [self setupUserInfo];
 
    //集成下拉刷新控件 (刚打开APP的时候 模拟下拉一次来获取数据)
    [self setupDownRefresh];
 
    
    //集成上拉刷新控件
    [self setupUpRefresh];
    
    //定时获取未读消息数目，显示在badge上
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnReadCount) userInfo:nil repeats:YES];
    //主线程也会抽出时间处理一下timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获取未读消息数目  (没有访问次数限制)
 */

-(void)setupUnReadCount {
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    
    AccountModel *account = [AccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //3.发送请求
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int unReadStatusCount = [responseObject[@"status"] intValue];
        if(unReadStatusCount ==0){ //如果未读消息数目为0，清除badgeValue , 并将应用图片数字清零
            self.tabBarItem.badgeValue = nil ;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        }else{
         
                self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unReadStatusCount];
            [UIApplication sharedApplication].applicationIconBadgeNumber = unReadStatusCount;
        }
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
    }];
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
    StatusFrameModel *firstStatus = [self.statusFrameModels firstObject];
    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
        params[@"since_id"] = firstStatus.statusModel.idstr;
    }
    params[@"count"] = @2;
  
    
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
        [self.statusFrameModels insertObjects:newsFrames atIndexes:indexSet];
        
        
        
        //刷新表格
        [self.tableView reloadData];
        
        //菊花停止转动
        [control endRefreshing];
        
        //显示最新微博的数量
        [self showNewStatusCount:(int)newStatuses.count];
        
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
    StatusFrameModel *lastStatus = [self.statusFrameModels lastObject];
    if(lastStatus){
        //若指定此参数，则返回ID小于或等于max_id的微博。默认为0
        //id这种数据一般比较大，转化成整数最好用long long
        long long maxID = lastStatus.statusModel.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxID);
    }
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
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


/**
 *  刷新微博后-》动画效果
 */
-(void)showNewStatusCount:(int)count{
    
    //将未读消息数清零
    self.tabBarItem.badgeValue = nil;
    //应用图标数字清零
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;
    
    /*这个Label是用来显示：当刷新微博后，提示有多少条新微博*/
    UILabel *label = [[UILabel alloc]init] ;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height =35 ;
    
    if(count == 0){
        label.text = @"没有新的微博数据，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.y = 64-35;
    
    //将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view  insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画效果
    CGFloat duration = 1.0 ;
    [UIView animateWithDuration:duration animations:^{
        //label.y+=label.height; //这句话实现效果跟下面的一样，不过推荐使用下面的语句 label.transform来实现
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 2.0;
         [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{ 
             //label.y  -=label.height ;
             label.transform = CGAffineTransformIdentity; //回到动画的原点
         } completion:^(BOOL finished) {
             [label removeFromSuperview];
         }];
    }];
    
}


/**
 *  获取用户信息
 */
-(void)setupUserInfo{
    //https://api.weibo.com/2/users/show.json
    /*
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID
     */
    
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //设置首页用户名字
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView ;
        [titleButton setTitle:responseObject[@"name"] forState:UIControlStateNormal];

        //存储昵称到沙盒中
        account.name = responseObject[@"name"];
        [AccountTool saveAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
}


/**
 *  设置导航栏内容
 */
-(void)setupNavigationBar{
    
    //左上角按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" highLightImageName:@"navigationbar_friendsearch_highlighted"];
    
    //右上角按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) imageName:@"navigationbar_pop" highLightImageName:@"navigationbar_pop_highlighted"];
    
    //中间的标题栏按钮
    TitleButton *titleButton = [[TitleButton alloc]init];
    NSString *name = [AccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    //点击导航微博名跳出下拉菜单
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton ;
}


/**
 *  点击标题(微博名)，会出现下拉菜单
 */
-(void)titleClick:(UIButton *)titleButton{
    
    //创建下拉菜单
    DropDownMenu *menu = [DropDownMenu menu];
    //设置下拉菜单的内容
    MenuTableViewController *menuTable = [[MenuTableViewController alloc]init];
    menuTable.view.height =44*3 ;
    menuTable.view.width =217 ;
    menu.contentController =  menuTable ;
    menu.delegate = self ;
    //显示
    [menu showFrom:titleButton];
    //让箭头向上
    titleButton.selected = YES;
}


/**
 *  点击右上角按钮
 */
-(void)pop{
    
    
}


/**
 *  点击左上角按钮
 */
-(void) friendSearch{
    [MBProgressHUD showMessage:@"添加好友，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    
 
}


/**
 *  statuses懒加载
 */
-(NSMutableArray *)statusFrameModels{
    if(_statusFrameModels == nil){
        _statusFrameModels = [NSMutableArray array];
    }
    return _statusFrameModels ;
}



#pragma mark - dropDownMenuDelegate代理
/**
 *  下拉菜单被销毁时触发，箭头方向向下
 */
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu{
    UIButton *titleButton  = (UIButton*)self.navigationItem.titleView ;
    titleButton.selected = NO;
}




#pragma mark - UITableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrameModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrameModel * frame = self.statusFrameModels[indexPath.row];
    
    return frame.cellHeight ;
}

/** 点击微博 跳转到 微博详情页 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailViewController *statusDetail = [[StatusDetailViewController alloc]init];
    StatusFrameModel *frameModel = _statusFrameModels[indexPath.row];
    statusDetail.statusModel = frameModel.statusModel;
    
    [self.navigationController pushViewController:statusDetail animated:YES] ;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

 
    
    static NSString *ID = @"StatusCell" ;
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.baseFrameModel = _statusFrameModels[indexPath.row];
    
    
//    for (id obj in cell.subviews)
//    {
//        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
//        {
//            UIScrollView *scroll = (UIScrollView *) obj;
//            scroll.delaysContentTouches = NO;
//            break;
//        }
//    }
  
    
    return  cell;
}

/**
 *  当视图滚动时调用该方法
 *  目的：当滚动到可以看到最后一个cell的时候，获取更多的微博信息
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
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

 

@end















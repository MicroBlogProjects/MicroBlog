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
@interface HomeViewController () <DropDownMenuDelegate >
/**
 *  微博数组（里面放的都是StatusModel模型，一个StatusModel就代表一条微博）
 */
@property (nonatomic , strong) NSMutableArray *statuses;

@end
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息（昵称）
    [self setupUserInfo];
#warning 暂时不用，节省时间
//    //加载最新的微博数据
//    [self loadNewStatus];
    
    //集成刷新控件
    [self setupRefresh];

}
/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    UIRefreshControl *fresh = [[UIRefreshControl alloc]init];
    [fresh addTarget:self action:@selector(refreshStatChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:fresh];
}

/**
 *  下拉刷新加载最新微博数据
 */
-(void)refreshStatChange:(UIRefreshControl *)control{

    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
    StatusModel *firstStatus = [self.statuses firstObject];
    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
       params[@"since_id"] = firstStatus.idstr;
    }
    params[@"count"] = @20;
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //把最新的微博数组，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
        
        //菊花停止转动
        [control endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //菊花停止转动
        [control endRefreshing];
    }];
    NSLog(@"请求刷新");
}

/**
 *  启动时候加载的微博数据
 */
-(void)loadNewStatus{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    
    
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @20;
 
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //把最新的微博数组，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
    menuTable.view.heigt =44*3 ;
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
    
    NSLog(@"friendSearch");
}





/**
 *  statuses懒加载
 
 */
-(NSMutableArray *)statuses{
    if(_statuses == nil){
        _statuses = [NSMutableArray array];
    }
    return _statuses ;
}


#pragma mark - dropDownMenuDelegate代理实现
/**
 *  下拉菜单被销毁时触发，箭头方向向下
 */
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu{
    UIButton *titleButton  = (UIButton*)self.navigationItem.titleView ;
    titleButton.selected = NO;
    
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //取出这行cell对应的微博字典
    StatusModel *status = self.statuses[indexPath.row];
    UserModel *user = status.user;
    //取出这条微博的作者（用户）
//    NSDictionary *user = status[@"user"];
    cell.textLabel.text = user.name;
    
    //设置微博具体内容
    cell.detailTextLabel.text = status.text;
    
    //设置微博博主头像
    UIImage *placeHolderImage = [UIImage imageNamed:@"avatar_default_small"];
    NSString *imageURL = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeHolderImage];

    return  cell;
}







@end















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
@interface HomeViewController () <DropDownMenuDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息（昵称）
    [self setupUserInfo];
    
    //加载最新的微博数据
    [self loadNewStatus];

}


/**
 *  加载最新的微博数据
 */
-(void)loadNewStatus{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    
    
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @2;
 
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
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
 *  点击左上角按钮
 */
-(void)pop{
    [MBProgressHUD showMessage:@"扫码功能，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    NSLog(@"pop");
    
}


/**
 *  点击右上角按钮
 */
-(void) friendSearch{
    [MBProgressHUD showMessage:@"添加好友，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    
    NSLog(@"friendSearch");
}


#pragma mark - dropDownMenuDelegate代理实现
/**
 *  下拉菜单被销毁时触发，箭头方向向下
 *
 *  @param menu 下拉菜单
 */
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu{
    UIButton *titleButton  = (UIButton*)self.navigationItem.titleView ;
    titleButton.selected = NO;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}








@end

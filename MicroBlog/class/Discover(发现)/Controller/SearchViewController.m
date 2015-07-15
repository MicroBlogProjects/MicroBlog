//
//  SearchViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/11.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBar.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "UserModel.h"

@interface SearchViewController () <UITextFieldDelegate>
@property (nonatomic , strong) SearchBar *searchBar;
@property (nonatomic , strong) NSMutableArray *searchResults;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSearBar];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
    
    
    
    
}


/**  创建搜索框 */
-(void)addSearBar{
    /* 创建搜索框 */
    //创建搜索框对象(这是我自定义的工具)
    
    CGSize size  = [UIScreen mainScreen].bounds.size;
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = size.width*0.95;
    searchBar.height = 35 ;
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.clearButtonMode = UITextFieldViewModeWhileEditing ;
    self.searchBar = searchBar ;
    searchBar.delegate  =self ;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = searchBar;
    
    /** 监听搜索框内容的改变 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:
     UITextFieldTextDidChangeNotification object:nil];
}


/**  搜索框内容改变就会触发这个方法 */
-(void)textChange:(NSNotification *)notification {
    NSString *searchString = [notification.object text];
    
    [self getUserMessageWithSearchString:searchString];
}


/**  想网络请求搜索信息 */
-(void)getUserMessageWithSearchString:(NSString *)searchString {
    
    
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account];

    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token ;
    params[@"q"] = searchString ;
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/search/suggestions/users.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        [self.searchResults removeAllObjects];
         for(NSDictionary *dict in responseObject){
             [self.searchResults addObject:dict];
        }
//        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"接收到%lu条数据",[responseObject count] ] ];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
     
    }];
    
    
}


/** 点击取消按钮 ， 退出当前搜索页面*/

-(void)cancelClick{
    [self.searchBar resignFirstResponder];

    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}



#pragma mark- UITableView 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchResults.count?_searchResults.count:0;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return   1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    NSDictionary *dict = self.searchResults[indexPath.row];
    NSString *name = dict[@"screen_name"];
    cell.textLabel.text = name;
    return cell;
}
 



#pragma mark- 懒加载
-(NSMutableArray *)searchResults{
    if(_searchResults == nil ){
        _searchResults = [NSMutableArray array];
    }
    return _searchResults ;
}
@end

//
//  DiscoverViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#define kSectionHeight 10;

#import "DiscoverViewController.h"
#import "SearchBar.h" 
#import "MBProgressHUD+MJ.h"
#import "HotTopCell.h"
#import "AccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SearchViewController.h"
#import "NavigationController.h"

@interface DiscoverViewController () <UITextFieldDelegate>

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame: self.view.bounds  style:UITableViewStyleGrouped] ;
    self.automaticallyAdjustsScrollViewInsets = NO;   //不会自动调节，这样第一个Section的头部就不会留出一片空白
    self.tableView.sectionFooterHeight =0 ;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine ;
    
   

    [self addSearBar];
    
    
}

-(void)getMessage{
    
    /* 项目要导入AFNetworking框架，并import头文件AFNetworking.h */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    //2.拼接请求参数
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"q"] = @"bi";
    //3.发送请求
    [manager POST:@"https://api.weibo.com/2/search/suggestions/users.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}




/**  创建搜索框 */
-(void)addSearBar{
    /* 创建搜索框 */
    //创建搜索框对象(这是我自定义的工具)
    
    CGSize size  = [UIScreen mainScreen].bounds.size;
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = size.width*0.95;
    searchBar.height = 35 ;
    searchBar.delegate = self ;
    self.navigationItem.titleView = searchBar;
} 



#pragma mark - TableView代理

/**  块数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
/**  行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

/**  Cell高度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return  88 ;
    return 44;
}
/** Section高度 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0)
        return 64+kSectionHeight;
    return kSectionHeight;
}
/** Footer 高度 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 3)
        return 50;
    return 0 ;
}

/** Header View */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if(section!=0){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)] ;
        return  view;
    }
    return nil;
   
    
}
/** Footer View */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 3){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        return view ;
    }
    return nil ;
}


/** Cell */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0){
        static NSString *ID = @"HotTopCell" ;
        HotTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell ==nil){
            cell = [[HotTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }

        return cell;
    }
    
    
    if(indexPath.section == 1){
        if(indexPath.row ==0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"hot_status"];
            cell.textLabel.text  =@"热门微博";
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"find_people"];
            cell.textLabel.text = @"找人";
            return cell;
        }
    }
    
    if(indexPath.section == 2){
        if(indexPath.row ==0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"game_center"];
            cell.textLabel.text  =@"游戏中心";
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"near"];
            cell.textLabel.text = @"周边";
            return cell;
        }
    }
    
    
    if(indexPath.section == 3){
        if(indexPath.row ==0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"music"];
            cell.textLabel.text  =@"听歌";
            return cell;
        }
        
        if(indexPath.row == 1){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"movie"];
            cell.textLabel.text = @"电影";
            return cell;
        }
        if(indexPath.row == 2){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.imageView.image = [UIImage imageNamed:@"more"];
            cell.textLabel.text = @"更多频道";
            return cell;
        }
    }
    
    
    
    
    
    static NSString *ID = @"DiscoverCell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text  = [NSString stringWithFormat:@"cell-%lu",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return  cell ;
}


/** 点击Cell进行页面跳转 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==1 && indexPath.row == 0){ //点击热门微博
       
        [MBProgressHUD showMessage:@"接口限制，无法实现"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
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


#pragma  mark- UITextField代理方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
#warning todo 点击之后切换到新的页面
    
    SearchViewController *searchView = [[SearchViewController alloc]init ] ;
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:searchView];
    
    [self presentViewController:nav animated:NO completion:^{
        
        
    }];
    
    
    return  YES;
    
}


@end

//
//  StatusDetailViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  微博详情页面

#define kOptionHeight 44
#define kTitleViewHeiht 50

#import "StatusDetailViewController.h"
#import "StatusDetailFrameModel.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "StatusModel.h"
#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "MJExtension.h"
#import "StatusDetailTitleView.h"
#import "StatusDetailCell.h"
#import "CommentCell.h"
#import "CommentFrameModel.h"
#import "StatusDetailToolBar.h"
#import "MainTabbarViewController.h"
#import "CommentViewController.h"
#import "NavigationController.h"
#import "RetweetViewController.h"



@interface StatusDetailViewController () <StatusDetailToolBarDelegate>
@property (nonatomic , strong) StatusDetailFrameModel *statusFrameModel;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) StatusDetailTitleView *titleView;
@property (nonatomic , strong) NSString  *statusID ;
 

@property (nonatomic , strong) NSMutableArray *commentFrameModels;

@end

@implementation StatusDetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"微博正文";
    
    // 去掉多余格式的线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
    
    //2.添加View的子控制器
    [self createSubViews];
    
    [self loadNewComment];


    
}

/**
 * 重写目的： 如果是点击评论按钮跳转到此页面，页面就进行偏移，偏移到评论部分
 */
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_isClickComent){
     [self.tableView setContentOffset:CGPointMake(0, self.statusFrameModel.cellHeight-59) animated:YES];
        _isClickComent = 0 ;
    }
}

/**
 * 重写的目的：进入评论页面评论完后，重新回到微博详情页，能够加载最新评论信息
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_commentFrameModels.count){

            [self loadNewComment];
        }
    });
    

    
}


/**
 *  初始化内容
 */
-(void)createSubViews{
    
    //初始化frameModel
    CGSize size = self.view.frame.size;
    _statusFrameModel.statusModel =_statusModel;
    
    //1.添加tableView
    self.tableView = [[UITableView alloc]init];
    self.tableView.allowsSelection = NO ;
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBg ;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.frame = CGRectMake(0, 0, size.width, size.height - kOptionHeight);
    [self.view addSubview:self.tableView];
   
    //2.评论条
    StatusDetailToolBar *toolBar = [[StatusDetailToolBar alloc]init] ;
    toolBar.frame = CGRectMake(0, size.height-kOptionHeight, size.width, kOptionHeight);
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}

/**
 *  加载评论
 */
-(void)loadNewComment {
    [self.commentFrameModels removeAllObjects];
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"id"] = _statusModel.idstr ;

    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/comments/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        
        //将StatusModel数组 转换成 StatusFrameModel数组
        NSMutableArray *newsFrames = [NSMutableArray array];
        for(StatusModel *statusModel in newStatuses){
            CommentFrameModel *f = [[CommentFrameModel alloc]init];
            f.statusModel = statusModel ;
            [newsFrames addObject:f];
        }
        
        //把最新的微博数组，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.commentFrameModels insertObjects:newsFrames atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 *   从外面输入微博数据
 */
-(void)setStatusModel:(StatusModel *)statusModel{
    _statusModel =statusModel ;
    
    self.statusFrameModel.statusModel = statusModel ;
    [self.tableView reloadData];
    
    
}


#pragma mark - TabelView代理

/** 块  */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/** 行 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    //当没有评论时候，只显示一行cell (显示内容是“没有评论内容”)
    if(_commentFrameModels.count == 0 )
        return  1;

    return _commentFrameModels.count;
}

/** Header (评论头部的工具条) */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section ==1 ){
        if(_titleView == nil){
            CGRect frame = CGRectMake(0, 0,tableView.frame.size.width, kTitleViewHeiht );
            _titleView = [[StatusDetailTitleView alloc]initWithFrame:frame];
            _titleView.statusModel = _statusModel ;
        }
        return _titleView ;
    }

    return nil;
}

/**  Cell的高度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return  _statusFrameModel.cellHeight;
    }
     //当没有评论时候 ， 高度为100;
    if(_commentFrameModels.count == 0)
        return  120 ;
    
    CommentFrameModel *commentFrameModel = _commentFrameModels [indexPath.row];
    return commentFrameModel.cellHeight;
}

/** Header的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return kTitleViewHeiht;
    }
    return 0;
}

/**  Cell  */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 ){
        static NSString *ID = @"StatusDetailCell" ;
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell ==nil){
            cell = [[StatusDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.baseFrameModel  = _statusFrameModel ;
        
        return cell ;

    }
    //如果评论为0，显示一个空白的cell
    if(_commentFrameModels.count ==0 ){
        static NSString *ID = @"SpaceCell" ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell ==nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = @"                    还没有人评论";
        cell.textLabel.x =200;
        return cell;
    }

        CommentCell *cell =  [CommentCell cellWithTablView:tableView];
        cell.commentFrameModel = _commentFrameModels[indexPath.row];
        return cell;
    
}



#pragma mark - StatusDetailToolBarDelegate（工具条按钮点击事件代理）
-(void)toolBar:(StatusDetailToolBar *)toolBar clickButton:(UIButton *)button type:(ToolBarButtonType)type{
    //转发
    if(type == ToolBarButtonTypeRetweet ){
        MainTabbarViewController *mainView = [MainTabbarViewController sharedMainTabbarViewController];
        RetweetViewController *retweet = [[RetweetViewController alloc]init ] ;
        retweet.idstr = self.statusModel.idstr ;
        NavigationController *nav = [[NavigationController alloc]initWithRootViewController:retweet ] ;
        
        [mainView presentViewController:nav animated:YES completion:^{
            
        }];
        
        
        
    }
    
    //评论
    if(type == ToolBarButtonTypeComment){
        MainTabbarViewController *mainView = [MainTabbarViewController sharedMainTabbarViewController];
        CommentViewController *comment = [[CommentViewController alloc]init ] ;
        comment.idstr = self.statusModel.idstr ;
        NavigationController *nav = [[NavigationController alloc]initWithRootViewController:comment ] ;
        
        [mainView presentViewController:nav animated:YES completion:^{
            
        }];
    }
    //点赞
    if(type == ToolBarButtonTypeAgree){
        
    }
    
}

#pragma mark- 懒加载

-(StatusDetailFrameModel *)statusFrameModel {
    if(!_statusFrameModel){
        _statusFrameModel = [[StatusDetailFrameModel alloc]init];
    }
    return _statusFrameModel;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init] ;
    }
    return  _tableView;
}

-(NSMutableArray *)commentFrameModels{
    if(!_commentFrameModels){
        _commentFrameModels = [NSMutableArray array];
    }
    return _commentFrameModels ;
}


@end

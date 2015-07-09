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



@interface StatusDetailViewController ()
@property (nonatomic , strong) StatusDetailFrameModel *statusFrameModel;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) StatusDetailTitleView *titleView;
@property (nonatomic , strong) NSString  *statusID ;

@property (nonatomic , strong) NSMutableArray *commentFrameModels;

@end

@implementation StatusDetailViewController


-(NSMutableArray *)commentFrameModels{
    if(!_commentFrameModels){
        _commentFrameModels = [NSMutableArray array];
    }
    return _commentFrameModels ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"微博正文";
    
    //2.添加View的子控制器
    [self createSubViews];
    
    [self loadNewComment];
    
}


-(void)createSubViews{
    
    //初始化frameModel
    CGSize size = self.view.frame.size;
    _statusFrameModel.statusModel =_statusModel;
    
    //1.添加tableView
    _tableView = [[UITableView alloc]init];
    _tableView.allowsSelection = NO ;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kGlobalBg ;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.frame = CGRectMake(0, 0, size.width, size.height - kOptionHeight);
    [self.view addSubview:_tableView];
   
    
    
    //2.评论条
    UIImageView *option = [[UIImageView alloc]init] ;
    option.image = [UIImage stretchImageWithName:@"toolbar_background.png"];
    option.frame = CGRectMake(0, size.height-kOptionHeight, size.width, kOptionHeight);
    option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:option];
    
    
    
}

-(void)loadNewComment {
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    

    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博（当前缓存数组中最新的微博，我们下拉只需要获取比缓存中更新的微博数据）
//    StatusFrameModel *firstStatus = [self.commentFrameModels firstObject];
//    if(firstStatus){  //如果之前存在数据，才会请求since_id之后的微博; 如果没此参数，默认请求20条
//        params[@"since_id"] = firstStatus.statusModel.idstr;
//    }
    params[@"id"] = _statusModel.idstr ;
//    NSLog(@"%@",_statusModel.idstr);
    
    /*
     赖伟煌的迷你微博
     access_token=2.004nnkxBNS6mBB72a37612fdviOKvD
     uid=1799091161
     App Key：304647707
     App Secret：533cfea336e04f236c469931f5d40a7c
     
     
     迷你微博应用
     access_token=2.004nnkxB0hmQc1ca9521a831L5MZsB
     uid=1799091161
     App key : 942446141
     App Secret : 387ea016d0c2baa3fb73ca00ac3ec049
     
     */
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/comments/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  将“微博字典”数组 转成  “微博模型”数组 ， 这个是MJExtention框架的方法
        
//        NSLog(@"%@",responseObject);
        NSArray *newStatuses = [StatusModel objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        
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
        [self.commentFrameModels insertObjects:newsFrames atIndexes:indexSet];
        
        
        
        //刷新表格
        [self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //菊花停止转动
        NSLog(@"%@",error);
    }];

    
}


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
    NSLog(@"%d",_commentFrameModels.count);
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
    return ;
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

    }else{

        static NSString *Id = @"UITableViewCell" ;
        CommentCell *cell =  [CommentCell cellWithTablView:tableView];
        cell.statusFrameModel = _commentFrameModels[indexPath.row];
        return cell;
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




@end

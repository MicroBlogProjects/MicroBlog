//
//  StatusDetailViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
// 查看微博详情页面

#import "StatusDetailViewController.h"
#import "DetailToolBar.h"
#import "StatusCell.h"
#import "StatusFrameModel.h"
#import "StatusDetailBarView.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "StatusModel.h"
#import "StatusFrameModel.h"
#import "MJExtension.h"
#import "CommentCell.h"
@interface StatusDetailViewController ()
@property (nonatomic ,weak) DetailToolBar *detailToolBar;
@property (nonatomic , strong) NSMutableArray *commentFrameModel ;
@end

@implementation StatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"微博正文";
    
    //2.添加View的子控制器
    [self createSubViews];
    
    
 
    
}

-(void)createSubViews{
    CGSize size = self.view.frame.size;
    
}



#pragma mark- tableView代理

/** 块数 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/** 行数 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1)
    {
        return self.commentFrameModel.count;
    }
    return 1;
}

/**  cell的高度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
      return _statesFrameModel.cellHeightForDetailStatus;
    return 44;
}

///** 头部Head （只显示评论部分的头部）*/
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIWindow *window  = [UIApplication sharedApplication].keyWindow ;
//    StatusDetailBarView *view = [[StatusDetailBarView alloc]initWithFrame:CGRectMake(0, 0,window.width-100  , 36)];
//
//    
//    view.statsModel = _statesFrameModel.statusModel;
//
//    
//    if(section == 1 ){
//        return view;
//    }
//    return nil;
//}
//
///** 尾部Foot （微博内容Section尾部）*/
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if(section == 0){
//        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20 )];
//        view.backgroundColor = myColor(239, 239, 239);
//        return view;
//    }
//    return  nil;
//}
//
///** section头部高度 （如果不设置,就不会显示头部View） */
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}

/////** 评论条的头部，能固定在顶部 */
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    if(section==1)
//       return 36 ;
//    return 0;
//}


/** 创建Cell */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0 &&indexPath.row==0){
        StatusCell *cell = [StatusCell cellWithTablView:tableView Type:1];
        cell.statusFrameModel = _statesFrameModel;
        return cell;
    }
 
    CommentCell *cell = [CommentCell cellWithTablView:tableView];
    cell.statusFrameModel = _commentFrameModel[indexPath.row];
    
    return  cell;
}
 


@end

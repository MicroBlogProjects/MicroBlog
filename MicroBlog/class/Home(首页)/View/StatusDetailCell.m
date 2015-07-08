//
//  StatusDetailCell.m
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusDetailRetweetToolBar.h"
#import "MainTabbarViewController.h"
#import "StatusDetailViewController.h"
#import "BaseFrameModel.h"
#import "StatusModel.h"
#import "NavigationController.h"

@interface StatusDetailCell  ()
@property (nonatomic , strong) StatusDetailRetweetToolBar *toolBar;
@end

@implementation StatusDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addToolBar];
        
        self.retweetView.userInteractionEnabled = YES ;
        [self.retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retweetClick) ]];
    }
    return  self;
}

-(void)retweetClick{
    NSLog(@"121212");
#warning  todo 这里转换还有点不清楚
    NavigationController *nav = (NavigationController *)[MainTabbarViewController sharedMainTabbarViewController].selectedViewController;
    StatusDetailViewController *detail = [[StatusDetailViewController alloc]init ] ;
    detail.statusModel = self.baseFrameModel.statusModel.retweeted_status;
    [nav pushViewController:detail  animated:YES];
}

/**  添加工具条  （转发、评论、赞） */
-(void)addToolBar{
    
    
    CGFloat retweetWidth = [UIScreen mainScreen].bounds.size.width - 2 * (kTableBorderWidth + kTableViewCellMargin);
    
    // 添加操作条
    CGFloat toolBarHeight = kStatusOptionBarHeight;
    CGFloat toolBarWidth = 200;
    CGFloat toolBarY = self.retweetView.frame.size.height - toolBarHeight;
    CGFloat toolBarX = retweetWidth - toolBarWidth - 20;
    CGRect frame = CGRectMake(toolBarX , toolBarY, toolBarWidth, toolBarHeight);
    _toolBar = [[StatusDetailRetweetToolBar alloc] initWithFrame:frame];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.retweetView addSubview:_toolBar];
    
}



-(void)setBaseFrameModel:(BaseFrameModel *)baseFrameModel{
    [super setBaseFrameModel:baseFrameModel];
    
    _toolBar.statusModel = baseFrameModel.statusModel ;
}





@end

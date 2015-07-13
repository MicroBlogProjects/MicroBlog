//
//  ToolBar.h
//  MicroBlog
//
//  Created by lai on 15/7/3.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  首页中工具条（转发、评论、点赞）

#import <UIKit/UIKit.h>
//
@class StatusModel ;
@class ToolBar;
/** 按钮类型*/
typedef enum{
    ToolBarButtonTypeRetweet,
    ToolBarButtonTypeComment,
    ToolBarButtonTypeAgree
}ToolBarButtonType;

@protocol ToolBarDelegate <NSObject>

@optional
-(void)toolBar:(ToolBar*)tooBar clickButton:(UIButton *)button type:(ToolBarButtonType)type;

@end

@interface ToolBar : UIView
//获取微博数据，取出其中的 转发 评论 点赞个数
@property (nonatomic , strong) StatusModel *statusModel ;
@property (nonatomic , weak) id<ToolBarDelegate> delegate;
+(instancetype)toobar ;
@end

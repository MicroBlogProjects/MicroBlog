//
//  detailToolBar.h
//  MicroBlog
//
//  Created by lai on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  查看微博详情页面的下方工具栏

#import <UIKit/UIKit.h>

@class StatusModel ;
@class DetailToolBar;
/** 按钮类型*/
typedef enum{
    DetailToolBarButtonTypeRetweet,
    DetailToolBarButtonTypeComment,
    DetailToolBarButtonTypeAgree
}DetailToolBarButtonType;

@protocol DetailToolBarDelegate <NSObject>

@optional
-(void)toolBar:(DetailToolBar*)tooBar clickButton:(UIButton *)button ;
@end

@interface DetailToolBar : UIView
//获取微博数据，取出其中的 转发 评论 点赞个数
@property (nonatomic , strong) StatusModel *statusModel ;
@property (nonatomic , weak) id<DetailToolBarDelegate> delegate;
+(instancetype)toobar ;
@end
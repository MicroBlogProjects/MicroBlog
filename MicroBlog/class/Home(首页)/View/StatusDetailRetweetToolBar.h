//
//  StatusDetailRetweetToolBar.h
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  在微博详情页中  转发微博下方的工具条 （转发 评论 赞）

#import <UIKit/UIKit.h>
@class  StatusModel;
@interface StatusDetailRetweetToolBar : UIView

@property (nonatomic , strong) StatusModel *statusModel ;
@end

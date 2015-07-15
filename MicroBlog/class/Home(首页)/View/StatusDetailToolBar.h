//
//  StatusDetailToolBar.h
//  MicroBlog
//
//  Created by lai on 15/7/12.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
// 微博详情页中底部工具条（转发、评论、点赞）

#import <UIKit/UIKit.h>
@class StatusDetailToolBar ;
/** 按钮类型*/
typedef enum{
    ToolBarButtonTypeRetweet,
    ToolBarButtonTypeComment,
    ToolBarButtonTypeAgree
}ToolBarButtonType;

@protocol StatusDetailToolBarDelegate <NSObject>

@optional
-(void)toolBar:(StatusDetailToolBar*)toolBar clickButton:(UIButton *)button type:(ToolBarButtonType)type;

@end

@interface StatusDetailToolBar : UIView
@property (nonatomic , weak) id<StatusDetailToolBarDelegate> delegate ;
@end

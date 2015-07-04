//
//  ToolBar.h
//  MicroBlog
//
//  Created by lai on 15/7/3.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusModel ;

@interface ToolBar : UIView
//获取微博数据，取出其中的 转发 评论 点赞个数
@property (nonatomic , strong) StatusModel *statusModel ;
+(instancetype)toobar ;
@end

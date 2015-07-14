//
//  CommentCellModel.h
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "StatusModel.h"
@interface CommentCellModel : NSObject
/** 字符串型的微博ID*/
@property (nonatomic , copy)  NSString  *idstr;
/** 微博信息内容*/
@property (nonatomic , copy)  NSString  *text;
/**  微博作者的用户信息字段*/
@property (nonatomic , strong) UserModel *user;
/** 微博创建时间*/
@property (nonatomic , copy)  NSString  *created_at;
/** 微博来源*/
@property (nonatomic , copy)  NSString  *source;
/** 被转发的原微博信息字段，当该微博为转发微博时返回*/
@property (nonatomic , strong) StatusModel *status;
/**更多的评论*/
@property (nonatomic,strong)CommentCellModel *reply_comment;
@end

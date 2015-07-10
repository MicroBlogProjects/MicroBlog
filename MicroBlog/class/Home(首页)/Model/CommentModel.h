//
//  CommentModel.h
//  MicroBlog
//
//  Created by lai on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface CommentModel : NSObject

/** 微博信息内容*/
@property (nonatomic , copy)  NSString  *text;
/**  微博作者的用户信息字段*/
@property (nonatomic , strong) UserModel *user;
/** 微博创建时间*/
@property (nonatomic , copy)  NSString  *created_at;


@end

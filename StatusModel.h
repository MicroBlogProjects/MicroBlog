//
//  StatusModel.h
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface StatusModel : NSObject
/**
 *  字符串型的微博ID
 */
@property (nonatomic , copy)  NSString  *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic , copy)  NSString  *text;
/**
 *  微博作者的用户信息字段
 */
@property (nonatomic , strong) UserModel *user;

//+(instancetype)statusWithDict:(NSDictionary *)dict ; 
//+(NSArray *)statusWithArray:(NSArray *)array;
@end

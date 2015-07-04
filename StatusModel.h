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
@property (nonatomic , strong) StatusModel *retweeted_status;
/**微博配图地址，多图时返回多图连接，无配图时返回“[]” */
@property (nonatomic , strong) NSArray *pic_urls ;

/** 转发数*/
@property (nonatomic , assign)  int reposts_count ;
/** 评论数*/
@property (nonatomic , assign)  int comments_count;
/** 点赞数*/
@property (nonatomic , assign)  int attitudes_count ;



//+(instancetype)statusWithDict:(NSDictionary *)dict ; 
//+(NSArray *)statusWithArray:(NSArray *)array;
@end

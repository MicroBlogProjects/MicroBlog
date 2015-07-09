//
//  ProfileUserModel.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileUserModel : NSObject
/* 个人描述*/
@property (nonatomic , retain) NSString * descrip;
/** 粉丝数*/
@property (nonatomic , assign) NSInteger followers_count;
/** 关注数*/
@property (nonatomic , assign) NSInteger friends_count;
//** 微博数*/
@property (nonatomic , assign) NSInteger statuses_count;
/** 用户昵称*/
@property (nonatomic , retain) NSString * screen_name;
/** 用户头像缩略图的URL地址 180X180像素*/
@property (nonatomic , retain)  NSString  *avatar_large ;
/** 是否加v用户*/
/** 会员类型    值>2 才代表是会员 */
@property (nonatomic , assign)  NSInteger mbtype;
/** 会员等级*/
@property (nonatomic , assign)  NSInteger mbrank;
//是否为加V用户;
@property (nonatomic , assign)  BOOL verified;
//cell的高度
@property (nonatomic , assign) double cellHight;


@end

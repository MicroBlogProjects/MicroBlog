//
//  UserModel.h
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/** 字符串型的用户UID*/
@property (nonatomic , copy)  NSString  *idstr;
/** 用户显示名称*/
@property (nonatomic , copy)  NSString  *name;
/** 用户头像缩略图的URL地址 50X50像素*/
@property (nonatomic , copy)  NSString  *profile_image_url ;
/** 会员类型    值>2 才代表是会员 */
@property (nonatomic , assign)  int mbtype;
/** 会员等级*/
@property (nonatomic , assign)  int mbrank;

@property (nonatomic , assign , getter=isVip)  BOOL vip;


//+(instancetype) UserWithDict: (NSDictionary *)dict ;

@end

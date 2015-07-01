//
//  UserModel.h
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/**
 *  字符串型的用户UID
 */
@property (nonatomic , copy)  NSString  *idstr;
/**
 *  用户显示名称
 */
@property (nonatomic , copy)  NSString  *name;
/**
 *  用户头像缩略图的URL地址
 */
@property (nonatomic , copy)  NSString  *profile_image_url ;

//+(instancetype) UserWithDict: (NSDictionary *)dict ;

@end

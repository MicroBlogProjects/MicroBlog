//
//  UserModel.m
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


+(instancetype)UserWithDict:(NSDictionary *)dict{
    
    UserModel *user = [[self alloc]init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}





@end

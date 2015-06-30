//
//  Account.h
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject <NSCoding>

//用于调用access_token，接口获取授权后的access token。
@property (nonatomic , copy) NSString *access_token ;
//access_token的生命周期，单位是秒数。
@property (nonatomic , copy) NSString *expires_in ;
//当前授权用户的UID。
@property (nonatomic , copy) NSString *uid;
//access_token 创建时间 (这个不是新浪返回的数据，这是我自己创建的)
@property (nonatomic ,strong)NSDate *create_time;

+(instancetype)accountWitDict:(NSDictionary *)dict ;

@end

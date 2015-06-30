//
//  AccountTool.m
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  处理账号相关的所有操作：存储账号、取出账号、验证账号

//账号信息的存储路径
#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "AccountTool.h"
#import "AccountModel.h"

@implementation AccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+(void)saveAccount:(AccountModel *)account{
    
    //获得账号存储的时间（accessToken的产生时间）
    account.create_time = [NSDate date];
    //自定义对象存储到沙盒中
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
    
}

/**
 *  返回账号信息
 *
 *  @return 账号数据模型(如果账号授权过期，则返回nil)
 */
+(AccountModel *)account{

    //加载模型
    AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    //accessToken过期秒数
    long long expires_in  = [account.expires_in longLongValue];
    //accessToken创建时间+过期秒数 ==  accesstoken过期时间
    NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    //获取当前时间
    NSDate *now = [NSDate date];
    //比较当前时间和accessToken过期时间来判断是否过期;
    
    if([expiresTime compare:now] != NSOrderedDescending){
        return  nil ;
    }
    NSLog(@"%@ , %@",expiresTime ,now);
   return account;
}

@end

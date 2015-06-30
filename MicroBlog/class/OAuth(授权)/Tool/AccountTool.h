//
//  AccountTool.h
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  处理账号相关的所有操作：存储账号、取出账号、验证账号

#import <Foundation/Foundation.h>
@class AccountModel ;
@interface AccountTool : NSObject

+(void)saveAccount:(AccountModel *)account; 

+(AccountModel*) account ;

@end

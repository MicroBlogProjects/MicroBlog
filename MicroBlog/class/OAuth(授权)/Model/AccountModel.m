//
//  Account.m
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel


+(instancetype)accountWitDict:(NSDictionary *)dict{
 
    AccountModel *account = [[AccountModel alloc]init] ;
    account.access_token = dict[@"access_token"];
    account.uid = dict [@"uid"];
    account.expires_in = dict[@"expires_in"];
    
    return  account ;
}

/**
 *  当一个对象要归档进沙盒时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的那些属性存入沙盒
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"created_time"];
    
}


/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"created_time"];
        
    }
    return  self;
}

@end

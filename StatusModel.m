//
//  StatusModel.m
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusModel.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "photoModel.h"
@implementation StatusModel

-(NSDictionary *)objectClassInArray{
    
    // 告诉框架EJExtension , NSArray *pic_urls 这个数组属性里面存的类型是photoModel
    return @{@"pic_urls" : [photoModel class]};
    
}




/** 
 使用 MJExtension框架，会自动帮我们实现以下方法的功能
 */

//+(instancetype)statusWithDict:(NSDictionary *)dict{
//    
//    StatusModel *status = [[self alloc]init] ;
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [UserModel UserWithDict:dict[@"user"]] ;
//    
//    return status ;
//}
//
//+(NSArray *)statusWithArray:(NSArray *)array{
//    
//    NSMutableArray * arrayM = [NSMutableArray array];
//    for (NSDictionary *dict in array) {
//        [arrayM addObject:[self statusWithDict:dict]];
//    }
//    return arrayM ;
//}

@end

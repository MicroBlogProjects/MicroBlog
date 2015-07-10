//
//  MessageModel.m
//  MicroBlog
//
//  Created by administrator on 15/7/10.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
-(void)initWithDiction:(NSDictionary *)dic
{
        [self setValuesForKeysWithDictionary:dic];
}
+(instancetype)messageModelbuild:(NSDictionary *)dic {
    MessageModel *message=[[MessageModel alloc] init];
    [message initWithDiction:dic];
    return message;
}
@end

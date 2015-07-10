//
//  MessageModel.h
//  MicroBlog
//
//  Created by administrator on 15/7/10.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic,strong) NSString *png;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSString *date;
+(instancetype)messageModelbuild:(NSDictionary *)dic;
@end

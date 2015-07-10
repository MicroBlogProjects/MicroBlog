//
//  EmotionModel.h
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionModel : NSObject<NSCoding>
/**
 *  表情的文字描述
 */
@property (nonatomic,copy)NSString *chs;
/**
 *  表情的png图片名
 */
@property (nonatomic,copy)NSString *png;
/**
 *  emoji表情的16进制编码
 */
@property (nonatomic,copy)NSString *code;

@end

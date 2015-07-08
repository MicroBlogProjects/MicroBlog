//
//  NSString+Extention.h
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//     给定字体大小，计算size
#import <Foundation/Foundation.h>

@interface NSString (Extention)

/**
 *   给定字体和指定每行最大宽度 计算出字符串的 CGSize
 */
-(CGSize)sizeWithFont:(UIFont* )font maxWidth:(CGFloat )maxWidth;
/**
 *   给定字体 计算出字符串的 CGSize
 */
-(CGSize)sizeWithFont:(UIFont* )font ;
@end

//
//  NSString+Extention.m
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//        给定字体大小，计算size

#import "NSString+Extention.h"


@implementation NSString (Extention)

/**
 *   给定字体和指定每行最大宽度 计算出字符串的 CGSize
 */
-(CGSize)sizeWithFont:(UIFont* )font maxWidth:(CGFloat )maxWidth{
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = font ;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size ;
}
/**
 *   给定字体 计算出字符串的 CGSize
 */
-(CGSize)sizeWithFont:(UIFont* )font {
    
    return   [self sizeWithFont:font maxWidth:MAXFLOAT];
}



@end

//
//  UIImage+image.m
//  weibo
//
//  Created by apple on 13-8-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
#pragma mark 根据屏幕尺寸返回全屏的图片
+ (UIImage *)fullscreenImageWithName:(NSString *)name
{
    if (iPhone5) {
//        // 1.获取没有拓展名的文件名
//        NSString *filename = [name stringByDeletingPathExtension];
//        
//        // 2.拼接-568h@2x
//        filename = [filename stringByAppendingString:@"-568h@2x"];
//        
//        // 3.拼接拓展名
//        NSString *extension = [name pathExtension];
        name = [name filenameAppend:@"-568h@2x"];
    }
    return [UIImage imageNamed:name];
}

+ (UIImage *)stretchImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end

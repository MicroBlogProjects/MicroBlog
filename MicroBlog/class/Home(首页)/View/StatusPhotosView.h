//
//  StatusPhotosView.h
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//   cell上面的配图相册  （里面会显示1-9张图片 ）
#import <UIKit/UIKit.h>

@interface StatusPhotosView : UIView

@property (nonatomic , strong) NSArray *photos;


/**
 *  根据图片的个数计算9宫格相册的尺寸
 */
 + (CGSize) sizeWithCount:(int)count;

@end

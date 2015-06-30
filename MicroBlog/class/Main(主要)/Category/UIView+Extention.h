//
//  UIView+Extention.h
//  MicroBlog
//  可以直接对frame中的size,origin,width,heigh,x,y等直接进行赋值
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extention)

@property (nonatomic , assign) CGFloat x ;
@property (nonatomic , assign) CGFloat y ;
@property (nonatomic , assign) CGFloat centerX ;
@property (nonatomic , assign) CGFloat centerY ;
@property (nonatomic , assign) CGFloat width ;
@property (nonatomic , assign) CGFloat heigt ;
@property (nonatomic , assign) CGSize size;
@property (nonatomic , assign) CGPoint origin;

@end

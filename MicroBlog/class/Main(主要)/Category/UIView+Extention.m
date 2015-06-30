 //
//  UIView+Extention.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "UIView+Extention.h"

@implementation UIView (Extention)

-(void)setX:(CGFloat)x{
    CGRect frame  = self.frame;
    frame.origin.x  = x;
    self.frame = frame ;
}
-(void)setY:(CGFloat)y{
    CGRect frame =  self.frame;
    frame.origin.y = y ;
    self.frame = frame ;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame ;
    frame.size.width = width ;
    self.frame = frame;
}

-(void)setHeigt:(CGFloat)heigt {
    CGRect frame = self.frame ;
    frame.size.height = heigt;
    self.frame = frame ;
}

-(void)setSize:(CGSize)size{
    CGRect frame =self.frame ;
    frame.size = size;
    self.frame = frame ;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame ;
    frame.origin = origin  ;
    self.frame = frame ;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x  = centerX ;
    self.center = center ;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center ;
    center.y = centerY ;
    self.center = center;
}

-(CGFloat)centerY{
    return  self.center.y;
}
-(CGFloat)centerX{
    return self.center.x;
}

-(CGFloat)x{
    return self.frame.origin.x ;
}
-(CGFloat)y{
    return self.frame.origin.y ;
}
-(CGFloat)heigt{
    return  self.frame.size.height;
}
-(CGFloat)width{
    return  self.frame.size.width;
}
-(CGSize)size{
    return  self.frame.size;
}
-(CGPoint)origin{
    return self.frame.origin;
}





@end

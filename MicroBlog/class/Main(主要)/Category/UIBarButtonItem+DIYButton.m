//
//  UIBarButtonItem+DIYButton.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "UIBarButtonItem+DIYButton.h"

@implementation UIBarButtonItem (DIYButton)


/**
 *  创建一个DIY按钮item （比如屏幕左上方的返回按钮，右上角的设置按钮）
 *
 *  @param target         点击按钮后，调用该对象的action
 *  @param action         点击按钮后，调用的action
 *  @param image          按钮图片
 *  @param highLightImage 按钮高亮图片
 *
 *  @return 返回DIY好的按钮item
 */

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)image highLightImageName:(NSString*)highLightImage{
    
    UIButton *btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
     btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn] ;
}

@end

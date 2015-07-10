//
//  UIBarButtonItem+DIYButton.h
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DIYButton)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)image highLightImageName:(NSString*)highLightImage;

@end

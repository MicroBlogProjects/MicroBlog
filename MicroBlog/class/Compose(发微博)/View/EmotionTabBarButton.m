//
//  EmotionTabBarButton.m
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionTabBarButton.h"

@implementation EmotionTabBarButton
-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font=[UIFont systemFontOfSize:13];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted {
    //高亮所做的一切操作
}

@end

//
//  TabBar.m
//  MicroBlog
// 自定义的TabBar，DIY下方的按钮，为的是添加“+”按钮
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TabBar.h"
#import "MBProgressHUD+MJ.h"
@interface TabBar ()
// 下方中间的“+”按钮
@property (nonatomic , weak) UIButton *plusBtn ;
@end
@implementation TabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //添加屏幕下方的“+”按钮
        UIButton *plusBtn = [[UIButton alloc]init ] ;
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
         plusBtn.size = plusBtn.currentBackgroundImage.size ;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn ;
    }
    return self ;
}

/**
 *  点击加号调用
 */
-(void)plusClick{
    
    if([self.delegate respondsToSelector:@selector(tabBarClickPlusButton:)]){
        [self.delegate tabBarClickPlusButton:self];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置"+"的按钮位置
    self.plusBtn.centerX = self.width *0.5 ;
    self.plusBtn.centerY = self.heigt *0.5 ;
    
    //设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonWidth = self.width/5 ;  //把Tabbar五等分
    CGFloat tabbarButtonIndex = 0 ;
    for(UIView *child in self.subviews){
        Class class = NSClassFromString(@"UITabBarButton");
        if([child isKindOfClass:class]){
            //设置宽度
            child.width = tabbarButtonWidth;
            //设置x
            child.x = tabbarButtonWidth * tabbarButtonIndex;
            //增加索引
            tabbarButtonIndex++;
            //为加号按钮挪一个位置
            if (tabbarButtonIndex ==2){tabbarButtonIndex ++ ;}
        }
    }
}


@end

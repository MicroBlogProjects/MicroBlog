//
//  NavigationController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "NavigationController.h"
#import "UIBarButtonItem+DIYButton.h"

@implementation NavigationController

/**
 *  此方法在类第一次使用的时候调用一次
 */
+(void)initialize{
    
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem  appearance];
    
    //设置普通状态(按钮可点击状态时为橙色)
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] =  [ UIColor orangeColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
    
    //设置不可用状态(按钮不可点击状态时为灰色）
    NSMutableDictionary *disableTextAttribute = [NSMutableDictionary dictionary];
    disableTextAttribute[NSForegroundColorAttributeName] = myColor(200, 200, 200);
    disableTextAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableTextAttribute forState:UIControlStateDisabled];
    
    
}


/*
**
 *  重写这个方法的目的是：能够拦截所有push进来的控制器 
    （拦截目的：在控制器的左上角和右上角添加按钮 ）
 *
 *  @param viewController 即将push进来的控制器
 */

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
  
    //不在第一个界面显示左上角和右上角的按钮
    if(self.viewControllers.count > 0 ){
        /*自动显示和隐藏tabbar*/
        viewController.hidesBottomBarWhenPushed = YES ;
        //左上角按钮（功能是：返回上一个控制器）
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) imageName:@"navigationbar_back" highLightImageName:@"navigationbar_back_highlighted"];
        //右上角按钮（功能是：返回根控制器）
            viewController.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithTarget:self action:@selector(more) imageName:@"navigationbar_more" highLightImageName:@"navigationbar_more_highlighted"];
        
     
    }
    
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
-(void)more{
    [self popToRootViewControllerAnimated:YES];
}


@end

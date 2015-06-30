//
//  DropDownMenu.m
//  MicroBlog
//
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "DropDownMenu.h"

@interface DropDownMenu ()
//下拉菜单容器
@property (nonatomic , weak) UIImageView *containerView ;
@end

@implementation DropDownMenu

-(UIImageView *)containerView{
    if(!_containerView){
        //添加带箭头的灰色图片(作为下拉菜单的容器)
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES ; //开启交互功能(imageView默认是没有交互功能的)
        [self addSubview:containerView];
        self.containerView = containerView ;
    }
    return  _containerView ;
}

/**
 *  往下拉菜单容器中添加的组件
 *
 *  @param content 组件
 */
-(void)setContent:(UIView *)content{
      _content = content ;
    //调整组件的在容器中的位置
    content.x= 10 ;
    content.y = 15 ;

    
    //下拉菜单容器的高 比 容器中组件的高多10
    self.containerView.heigt = CGRectGetMaxY(content.frame) +11 ;
    //下拉菜单容器的宽 比 容器中组件的宽多10
    self.containerView.width = CGRectGetMaxX(content.frame) + 10 ;
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController ;
    self.content = contentController.view ;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [ UIColor clearColor];
    }
    return self ;
}


+(instancetype)menu{
    return  [[self alloc]init]; 
}

/**
 *  显示
 */
-(void)showFrom:(UIView *)from{
    //1、获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject ] ;
    //2、添加自己到窗口上
    [window addSubview:self];
    //3、设置尺寸
    self.frame = window.bounds ;
    //4、调整灰色图片的位置（根据点击组件的位置来调整）
    //默认情况下，frame是以父控件左上角为坐标原点，而bounds是以自己左上角为坐标原点（即坐标远点永远是（0，0））;
    //转换坐标系,将from控件的坐标系参照点转换成window参照点（即屏幕左上方为原点）;
    CGRect newRect = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newRect);
    self.containerView.y = CGRectGetMaxY(newRect);
    
    
}

/**
 *  销毁
 */
-(void)dismiss{
    [self removeFromSuperview];
    if([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]){
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end

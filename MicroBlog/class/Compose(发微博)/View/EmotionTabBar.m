//
//  EmotionTabBar.m
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionTabBar.h"
#import "EmotionTabBarButton.h"
@interface EmotionTabBar ()
@property (nonatomic,weak)EmotionTabBarButton *selectedBtn;
@end
@implementation EmotionTabBar

-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        [self setupBtn:@"最近" buttonType:EmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认"  buttonType:EmotionTabBarButtonTypeDefault ];
        [self setupBtn:@"Emoji" buttonType:EmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:EmotionTabBarButtonTypeLxh];
    }
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param title <#title description#>
 */
-(EmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(EmotionTabBarButtonType )buttonType{
    //创建按钮
    EmotionTabBarButton *btn=[[EmotionTabBarButton  alloc] init];
    btn.tag=buttonType;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //设置文字颜色
    [btn setTitle:title forState:UIControlStateNormal];
    
    // 设置背景图片
    NSString *image=@"compose_emotion_table_mid_normal";
    NSString *highImage =@"compose_emotion_table_mid_selected";
    
    if(self.subviews.count == 0){
        image=@"compose_emotion_table_left_normal";
        highImage=@"compose_emotion_table_left_selected";
    }else if(self.subviews.count ==4){
        image=@"compose_emotion_table_right_normal";
        highImage=@"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateDisabled];
    [self addSubview:btn];
    return btn;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger btnCount=self.subviews.count;
    CGFloat btnW=self.width/btnCount;
    CGFloat btnH=self.height;
    for(int i=0; i<btnCount ; i++){
        EmotionTabBarButton *btn=self.subviews[i];
        btn.y=0;
        btn.width=btnW;
        btn.x= i*btnW;
        btn.height=btnH;
    }
}
-(void)setDelegate:(id<EmotionTabBarDelegate>)delegate {
    _delegate =delegate;
    //选中默认按钮
    [self btnClick:(EmotionTabBarButton *)[self viewWithTag:EmotionTabBarButtonTypeDefault]];
    
}
-(void)btnClick:(EmotionTabBarButton *)btn
{
    self.selectedBtn.enabled=YES;
    btn.enabled=NO;
    self.selectedBtn=btn;
    //通知代理
    if([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectBtutton:)]){
        [self.delegate emotionTabBar:self didSelectBtutton:btn.tag];
    }
}
@end

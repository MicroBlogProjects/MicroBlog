//
//  ComposeToolbar.m
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ComposeToolbar.h"
@interface ComposeToolbar()
@property (nonatomic,weak)UIButton *emotionButton;
@end;
@implementation ComposeToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self) {
        self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
         [self setupBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:ComposeToolbarButtonTypeCamera];
        
        [self setupBtn:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:ComposeToolbarButtonTypePicture];
       
        [self setupBtn:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:ComposeToolbarButtonTypeMention];
        
         [self setupBtn:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:ComposeToolbarButtonTypeTrend];
       
       self.emotionButton= [self setupBtn:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:ComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param image     <#image description#>
 *  @param highImage <#highImage description#>
 */
- (UIButton *)setupBtn:(NSString *)image hightImage:(NSString *)highImage type:(ComposeToolbarButtonType)type;
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=type;
    [self addSubview:btn];
    return btn;
}

-(void)btnClick:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)] ){
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    //设置所有按钮的frame
    NSUInteger count =self.subviews.count;
    CGFloat btnw = self.width/count;
    CGFloat btnH = self.height;
    for (NSUInteger i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        btn.y=0;
        btn.width=btnw;
        btn.x=i*btnw;
        btn.height=btnH;
    }
    
}
-(void)setShowKeyboardButton:(BOOL)showKeyboardButton{
    _showKeyboardButton=showKeyboardButton;
    //默认图片
    NSString *image=@"compose_emoticonbutton_background";
    NSString *highImage=@"compose_emoticonbutton_background_highlighted";
    // 显示键盘
    if(showKeyboardButton){
        image=@"compose_keyboardbutton_background";
       highImage=@"compose_keyboardbutton_background_highlighted";
    }
    //设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}
@end

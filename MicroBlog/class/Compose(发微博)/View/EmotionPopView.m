//
//  EmotionPopView.m
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionPopView.h"
#import "EmotionModel.h"
#import "EmotionButton.h"
@interface EmotionPopView()
@property (strong, nonatomic) IBOutlet EmotionButton *emotionButton;

@end
@implementation EmotionPopView

+(instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"EmotionPopView" owner:nil options:nil]lastObject];
}
-(void)showFrom:(EmotionButton *)button {
    if(button==nil)return ;
    //给popView传数据
    self.emotionButton.emotion=button.emotion;
    
    //取得最上面window
    
    UIWindow  *window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //计算出被点击的按钮在window中的frame
    CGRect btnFrame=[button convertRect:button.bounds toView:nil];
    self.y=CGRectGetMidY(btnFrame)-self.height;
    self.centerX= CGRectGetMidX(btnFrame);

}
@end

//
//  EmotionPageView.m
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionPageView.h"
#import "EmotionModel.h"
#import "EmotionPopView.h"
#import "EmotionButton.h"
#import "EmotionTool.h"
@interface EmotionPageView()
/** 点击表情后弹出的放大镜 */
@property (nonatomic,strong)EmotionPopView *popView;
/** 点击表情后弹出的放大镜 */
@property (nonatomic,strong)UIButton *deleteButton;
@end


@implementation EmotionPageView
-(UIButton *)deleteButton {
    if(!_deleteButton){
        UIButton *deleteButton=[[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:deleteButton];
        self.deleteButton=deleteButton;
    }
    return _deleteButton;
}
-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self) {
        //2添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
/**
 *  根据手指位置所在的表情按钮
 *
 *  @param location <#location description#>
 *
 *  @return <#return value description#>
 */
-(EmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    
    NSUInteger count=self.emotions.count;
    for (int i=0; i<count; i++) {
        EmotionButton *btn=self.subviews[i];
        if(CGRectContainsPoint(btn.frame, location)){
            return btn;
        }
    }
    return nil;
}
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location=[recognizer locationInView:recognizer.view];
    //获得手指所在位置的表情按钮
    EmotionButton *btn=[self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled: break;
        case UIGestureRecognizerStateEnded:
        {
            [self.popView removeFromSuperview];
            //如果手指孩子表情按钮上
            if(btn){
                // 发出通知
                [self selectEmotion:btn.emotion];
            }
            break;
        }
        case UIGestureRecognizerStateBegan: //手势开始
        {
            [self.popView showFrom:btn];
            break;
        }

        case UIGestureRecognizerStateChanged:
        {
            [self.popView showFrom:btn];
            break;
        }
        default: break;
    }
}
-(EmotionPopView *)popView {
    if (!_popView) {
        _popView=[EmotionPopView popView];
    }
    return _popView;
}

-(void)setEmotions:(NSArray *)emotions {
    _emotions =emotions;
    NSUInteger count=emotions.count;
    for (int i=0; i<count; i++) {
        EmotionButton *btn =[[EmotionButton alloc]init];
                [self addSubview:btn];
        
        //设置表情数据
        btn.emotion=emotions[i];
        //emotion.code :十六进制-》》Emoji字符
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat inset=10;
    CGFloat btnW=(self.width-2*inset)/EmotionMaccols;
    CGFloat btnH=(self.height-inset)/EmotionMacrows;
    NSUInteger count=self.emotions.count;
    for (int i=0; i<count; i++) {
        UIButton *btn =self.subviews[i];
        btn.width=btnW;
        btn.height=btnH;
        btn.x=inset +(i%EmotionMaccols)*btnW;
        btn.y=inset +(i/EmotionMaccols)*btnH;
        
    }
    self.deleteButton.width=btnW;
    self.deleteButton.height=btnH;
    self.deleteButton.y=self.height-btnH;
    self.deleteButton.x=self.width-inset-btnW;
}
/**
 *  删除按钮的点击
 */
-(void)deleteClick {
    [NotificationCenter  postNotificationName:EmotionDidDeleteNotification object:nil];
}

/**
 *  表情按钮的点击
 */
-(void)btnClick:(EmotionButton *)btn{
    [self.popView showFrom:btn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    //发出通知
    [self selectEmotion:btn.emotion];
}
/**
 *  选中某个表情发出通知
 *
 *  @param emotion <#emotion description#>
 */
-(void)selectEmotion:(EmotionModel *)emotion{
    //将这个表情存入沙盒
    [EmotionTool addRecentEmotion:emotion];
    // 发出通知
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    userInfo[SelectEmotionKey]=emotion;
    [NotificationCenter  postNotificationName:EmotionDidSelectNotification object:nil userInfo:userInfo];
    //表情选中的通知
  
}
@end

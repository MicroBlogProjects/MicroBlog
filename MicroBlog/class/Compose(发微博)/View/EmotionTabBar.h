//
//  EmotionTabBar.h
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
typedef enum {
    EmotionTabBarButtonTypeRecent,//最近
        EmotionTabBarButtonTypeDefault,//默认
        EmotionTabBarButtonTypeEmoji,//emoji
        EmotionTabBarButtonTypeLxh//浪小花

}EmotionTabBarButtonType;

@class EmotionTabBar;

@protocol EmotionTabBarDelegate <NSObject>
@optional
-(void)emotionTabBar:(EmotionTabBar *)tabBat didSelectBtutton:(EmotionTabBarButtonType)buttonType;
@end

@interface EmotionTabBar : UIView
@property (nonatomic,weak)id<EmotionTabBarDelegate> delegate;
@end

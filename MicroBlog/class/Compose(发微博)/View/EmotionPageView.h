//
//  EmotionPageView.h
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  每一页表情

#import <UIKit/UIKit.h>

#define EmotionPageSize 20
//7列
#define EmotionMaccols 7
//3行
#define EmotionMacrows 3
@interface EmotionPageView : UIView
/**
 *  表情存放在Eomtion
 */
@property (nonatomic,strong)NSArray *emotions;

@end

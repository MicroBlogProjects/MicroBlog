//
//  EmotionPopView.h
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionModel.h"
#import "EmotionButton.h"
@interface EmotionPopView : UIView
+(instancetype)popView;
-(void)showFrom:(EmotionButton *)button;
@end

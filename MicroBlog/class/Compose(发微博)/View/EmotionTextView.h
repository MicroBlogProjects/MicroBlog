//
//  EmotionTextView.h
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TextView.h"
@class EmotionModel;
@interface EmotionTextView : TextView
-(void)insertEmotion:(EmotionModel *)emotion;
-(NSString *)fullText;
@end

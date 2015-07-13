//
//  EmotionTextView.h
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TextView.h"
@class EmotionModel;
@protocol EmotionTextViewDeletate <UITextViewDelegate>
-(void)statusHasChange;
@end
@interface EmotionTextView : TextView
@property(nonatomic,assign)id<EmotionTextViewDeletate> delegate;
-(void)insertEmotion:(EmotionModel *)emotion;
-(NSString *)fullText;
@end

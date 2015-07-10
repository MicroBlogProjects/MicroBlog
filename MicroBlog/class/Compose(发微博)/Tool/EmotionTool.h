//
//  EmotionTool.h
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EmotionModel;
@interface EmotionTool : NSObject
+(void)addRecentEmotion:(EmotionModel *)emotion;
+(NSArray *)recentEmotions;
@end

//
//  EmotionTool.m
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//
//表情存储路径
#define RecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "EmotionTool.h"

@implementation EmotionTool
static NSMutableArray *_recentEmotions;
+(void)initialize {
    _recentEmotions=[NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionsPath];
    if(_recentEmotions==nil){
        _recentEmotions=[NSMutableArray array];
    }
}
+(void)addRecentEmotion:(EmotionModel *)emotion {
    NSMutableArray *emotions=(NSMutableArray *)[self recentEmotions];
    if(emotions == nil){
        emotions=[NSMutableArray array];
    }
    //删除重复表情
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:RecentEmotionsPath];
}
+(NSArray *)recentEmotions {
    return _recentEmotions;
}
@end

//
//  EmotionAttachmentModel.m
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionAttachmentModel.h"
#import "EmotionModel.h"
@implementation EmotionAttachmentModel
-(void)setEmotion:(EmotionModel *)emotion
{
    _emotion=emotion;
        self.image =[UIImage imageNamed:emotion.png];
    
}
@end

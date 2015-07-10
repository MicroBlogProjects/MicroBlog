//
//  EmotionAttachmentModel.h
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;
@interface EmotionAttachmentModel : NSTextAttachment
@property (nonatomic,strong)EmotionModel *emotion;
@end

//
//  AnnotationsModel.h
//  MicroBlog
//
//  Created by lai on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  PlaceModel ;
@interface AnnotationsModel : NSObject

/** 存储位置信息的数据模型 */
@property (nonatomic , strong)  PlaceModel *place;

@end

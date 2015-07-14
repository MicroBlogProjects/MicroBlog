//
//  PlaceModel.h
//  MicroBlog
//
//  Created by lai on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject

/** 存储位置信息 (例如：独墅湖大学城)*/
@property (nonatomic , strong) NSString *title;
/** 经度 */
@property (nonatomic , assign)  double lon;
/** 纬度 */
@property (nonatomic , assign)  double lat;


@end

//
//  ProfileFansModelList.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileFansModelList : NSObject
@property (nonatomic , strong) NSMutableArray * profileFansList;
//展示的粉丝数量
@property (nonatomic , assign) NSInteger display_total_number;
//下一批粉丝的下表
@property (nonatomic , assign) NSInteger next_cursor;
//上一批粉丝的下表
@property (nonatomic , assign) NSInteger previous_cursor;

@end

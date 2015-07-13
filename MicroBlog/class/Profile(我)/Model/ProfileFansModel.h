//
//  ProfileFansModel.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileFansModel : NSObject
@property (nonatomic , strong) NSString *profile_image_url;
@property (nonatomic , strong) NSString *screen_name;
@property (nonatomic , strong) NSString *descrip;
@property (nonatomic , assign) NSInteger next_cursor;
@end

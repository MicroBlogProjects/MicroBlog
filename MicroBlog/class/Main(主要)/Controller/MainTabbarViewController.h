//
//  MainTabbarViewController.h
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MainTabbarViewController : UITabBarController

/** 自动转换成单例的函数 */
singleton_interface(MainTabbarViewController)
@end

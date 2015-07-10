//
//  TabBar.h
//  MicroBlog
//
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar ;

//因为TabBar继承自UITabBar，所以想成为TabBar的代理，也必须实现UITabBar的代理协议
@protocol TabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarClickPlusButton:(TabBar *)tabBar;
@end


@interface TabBar : UITabBar
@property (nonatomic , weak) id<TabBarDelegate> delegate;
@end

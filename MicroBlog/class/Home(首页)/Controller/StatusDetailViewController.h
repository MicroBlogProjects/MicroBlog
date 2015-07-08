//
//  StatusDetailViewController.h
//  MicroBlog
//
//  Created by lai on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  微博详情页面

#import <UIKit/UIKit.h>
@class StatusModel ;
@interface StatusDetailViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic, strong) StatusModel *statusModel;

@end

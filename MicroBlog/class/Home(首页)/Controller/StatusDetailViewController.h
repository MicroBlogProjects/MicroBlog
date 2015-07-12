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
/** 标记这是从点击评论按钮来到此页面，这样微博详情页在一开始就将tableView偏移到评论部分 */
@property(nonatomic, assign) BOOL isClickComent;

@end

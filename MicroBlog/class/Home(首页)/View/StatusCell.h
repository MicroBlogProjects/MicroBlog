//
//  StatusCell.h
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrameModel ;

@interface StatusCell : UITableViewCell

@property (nonatomic , strong) StatusFrameModel *statusFrameModel;


/**  用来标记这个微博是要显示在微博列表还是微博详情页 ， 0是微博列表，1是详情页 */
@property (nonatomic , assign) NSUInteger type;


+ (instancetype)cellWithTablView:(UITableView *)tableView Type:(NSUInteger)type;



@end

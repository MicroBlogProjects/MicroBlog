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


+ (instancetype)cellWithTablView:(UITableView *)tableView ;



@end

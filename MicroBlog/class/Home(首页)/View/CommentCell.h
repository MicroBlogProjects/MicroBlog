//
//  CommentCell.h
//  MicroBlog
//
//  Created by lai on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseFrameModel ;
@interface CommentCell : UITableViewCell

@property (nonatomic , strong) BaseFrameModel *statusFrameModel;

+ (instancetype)cellWithTablView:(UITableView *)tableView ;

@end

//
//  CommentCell.h
//  MicroBlog
//
//  Created by lai on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentFrameModel ;
@interface CommentCell : UITableViewCell

@property (nonatomic , strong) CommentFrameModel *commentFrameModel;

+ (instancetype)cellWithTablView:(UITableView *)tableView ;

@end

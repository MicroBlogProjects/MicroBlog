//
//  ProfileToolButtonCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIYSegmentViewController.h"

#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]


@interface ProfileToolButtonCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDIYsegment:(DIYSegmentViewController *)segment;

@property (nonatomic,strong) DIYSegmentViewController * segmentView;
@end

//
//  ProfileToolButtonCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileToolButtonCell.h"

@implementation ProfileToolButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDIYsegment:(DIYSegmentViewController *)segment;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //toolButton
        self.segmentView = segment;
        [self addSubview:self.segmentView.view];
    }
    return self;
}
@end

//
//  ProfileToolButtonCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileToolButtonCell.h"

@implementation ProfileToolButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //toolButton
        self.segmentView = [[DIYSegmentViewController alloc]init];
        [self addSubview:self.segmentView.view];
    }
    return self;
}

//-(void) setCell:(DIYSegmentViewController *)segmentView
//{
//    segmentView = [[DIYSegmentViewController alloc]init];
//    [self addSubview:segmentView.view];
//}
@end

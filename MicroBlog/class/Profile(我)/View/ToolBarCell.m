//
//  ToolBarCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ToolBarCell.h"

@implementation ToolBarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    }
    return self;
}
-(void)setProfileUserModel:(ProfileUserModel *) profileUserModel andToolBarCell: (ToolBarCellController *)toolBarcell
{
    [toolBarcell setProfileUserModel:profileUserModel];
    [self addSubview:toolBarcell.view];
}
@end

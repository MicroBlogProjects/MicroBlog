//
//  profileTableViewCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "profileTableViewCell.h"

@interface profileTableViewCell ()

@end

@implementation profileTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    return self;
}
-(void)setProfileUserModel:(ProfileUserModel *) profileUserModel
{
    /* 头像*/
    CGFloat iconW = 50 ;
    CGFloat iconH = 50 ;
    CGFloat iconX = kStatusCellBorderWidth ;
    CGFloat iconY = kStatusCellBorderWidth ;
    ProfileIconView * iconview = [[ProfileIconView alloc]initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
    iconview.backgroundColor = [UIColor redColor];
    [iconview getView:profileUserModel];
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = kStatusCellNameFont;
    CGFloat nameX = CGRectGetMaxX(iconview.frame) + kStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [profileUserModel.screen_name sizeWithFont:kStatusCellNameFont];
    nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    nameLabel.text = profileUserModel.screen_name;
    
    
    //vip图标;
    if (profileUserModel.mbtype > 2) {
        UIImageView * vipView = [[UIImageView alloc]init];
        CGFloat vipX = CGRectGetMaxX(nameLabel.frame) + kStatusCellBorderWidth;
        CGFloat vipY = nameY ;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = nameSize.height ;
        vipView.frame = CGRectMake(vipX, vipY, vipW, vipH);
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%ld",profileUserModel.mbrank];
        vipView.image = [UIImage imageNamed:vipImageName];
        nameLabel.textColor = [UIColor orangeColor];
        [self addSubview:vipView];
    }
    
    //简介
    NSString * title;
    if ([profileUserModel.descrip isEqualToString:@""]) {
        title = @"简介:暂无介绍";
    }
    else{
        title = [NSString stringWithFormat:@"简介:%@",profileUserModel.descrip];
    }
    UILabel * descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.backgroundColor = [UIColor whiteColor];
    descriptionLabel.font = kStatusCellNameFont;
    CGFloat desciptionX = CGRectGetMaxX(iconview.frame) + kStatusCellBorderWidth;
    CGFloat desciptionY = iconY + (iconview.height / 2);
    CGSize desciptionSize = [title sizeWithFont:kStatusCellNameFont];
    descriptionLabel.frame = CGRectMake(desciptionX, desciptionY, desciptionSize.width, desciptionSize.height);
    descriptionLabel.text = title ;
    descriptionLabel.textColor = myColor(205, 205, 205);
    //线
    [self deleteLine:LineTag];//先删除原先的控件 不然重叠;
    UIImageView *line = [[UIImageView alloc]init];
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(iconview.frame) + kStatusCellBorderWidth;
    CGFloat lineW = [[UIScreen mainScreen]bounds].size.width;
    CGFloat LineH = 1;
    line.backgroundColor = myColor(225, 225, 225);
    line.tag = LineTag;
    line.frame = CGRectMake(lineX, lineY, lineW, LineH);

    [self addSubview:iconview];
    [self addSubview:nameLabel];
    [self addSubview:descriptionLabel];
    [self addSubview:line];
    profileUserModel.cellHight = CGRectGetMaxY(line.frame);
}
-(void)deleteLine:(NSInteger)tag
{
    UIView * view = [self viewWithTag:tag];
    [view removeFromSuperview];
}
@end

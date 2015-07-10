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
    if ([profileUserModel.descrip isEqualToString:@""]) {
        profileUserModel.descrip = @"简介:暂无介绍";
    }
    else{
        profileUserModel.descrip = [NSString stringWithFormat:@"简介:%@",profileUserModel.descrip];
    }
    UILabel * descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.backgroundColor = [UIColor whiteColor];
    descriptionLabel.font = kStatusCellNameFont;
    CGFloat desciptionX = CGRectGetMaxX(iconview.frame) + kStatusCellBorderWidth;
    CGFloat desciptionY = iconY + (iconview.height / 2);
    CGSize desciptionSize = [profileUserModel.descrip sizeWithFont:kStatusCellNameFont];
    descriptionLabel.frame = CGRectMake(desciptionX, desciptionY, desciptionSize.width, desciptionSize.height);
    descriptionLabel.text = profileUserModel.descrip;
    descriptionLabel.textColor = myColor(205, 205, 205);
    //线
    UIImageView *line = [[UIImageView alloc]init];
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(iconview.frame) + kStatusCellBorderWidth;
    CGFloat lineW = [[UIScreen mainScreen]bounds].size.width;
    CGFloat LineH = 1;
    line.backgroundColor = myColor(225, 225, 225);
    line.frame = CGRectMake(lineX, lineY, lineW, LineH);

    [self addSubview:iconview];
    [self addSubview:nameLabel];
    [self addSubview:descriptionLabel];
    [self addSubview:line];
    profileUserModel.cellHight = CGRectGetMaxY(line.frame);


}
@end

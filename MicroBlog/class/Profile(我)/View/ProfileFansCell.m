//
//  ProfileFansCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileFansCell.h"
#import "ProfileIconView.h"
#import "ProfileUserModel.h"

@implementation ProfileFansCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andPersonInfo:(ProfileUserModel *)userModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        CGFloat iconViewX = kStatusCellBorderWidth;
        CGFloat iconViewY = kStatusCellBorderWidth;
        CGFloat iconViewW = KIconViewSize;
        CGFloat iconviewH = KIconViewSize;
        ProfileIconView * iconView = [[ProfileIconView alloc]initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconviewH)];
        [iconView getView:userModel];
        [self addSubview:iconView];
        
        
        //昵称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.font = kStatusCellNameFont;
        CGSize nameSize = [userModel.screen_name sizeWithFont:kStatusCellNameFont];
        CGFloat nameX = CGRectGetMaxX(iconView.frame) + kStatusCellBorderWidth;
        CGFloat nameY = kStatusCellBorderWidth;
        nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
        nameLabel.text = userModel.screen_name;
        [self addSubview:nameLabel];
        //vip图标
        if (userModel.mbtype > 2) {
            UIImageView * vipView = [[UIImageView alloc]init];
            CGFloat vipX = CGRectGetMaxX(nameLabel.frame) + kStatusCellBorderWidth;
            CGFloat vipY = nameY ;
            CGFloat vipH = nameSize.height;
            CGFloat vipW = nameSize.height ;
            vipView.frame = CGRectMake(vipX, vipY, vipW, vipH);
            NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%ld",userModel.mbrank];
            vipView.image = [UIImage imageNamed:vipImageName];
            nameLabel.textColor = [UIColor orangeColor];
            [self addSubview:vipView];
        }
        
        //个人简介
        NSString * title;
        if ([userModel.descrip isEqualToString:@""]) {
            title = @"简介:暂无介绍";
        }
        else{
            title = [NSString stringWithFormat:@"简介:%@",userModel.descrip];
        }
        UILabel * descriptionLabel = [[UILabel alloc]init];
        descriptionLabel.textColor = [UIColor grayColor];
        
        descriptionLabel.font = kStatusCelldescriptionFont;
        CGFloat desciptionX = CGRectGetMaxX(iconView.frame) + kStatusCellBorderWidth;
        CGFloat desciptionY = CGRectGetMaxY(nameLabel.frame)+ kStatusCellBorderWidth;
        
        CGSize descriptionLabelSize = [userModel.screen_name sizeWithFont:kStatusCellNameFont];
        descriptionLabelSize.width = [[UIScreen mainScreen]bounds].size.width - KIconViewSize * 2 - kStatusCellBorderWidth * 2;
        descriptionLabel.frame = CGRectMake(desciptionX, desciptionY, descriptionLabelSize.width  , descriptionLabelSize.height);
        descriptionLabel.text = title;
        [self addSubview:descriptionLabel];
        userModel.cellHight = CGRectGetMaxY(iconView.frame)+ kStatusCellBorderWidth;
        //取消或者点击关注的button
        CGSize  size = CGSizeMake(KIconViewSize / 2, KIconViewSize / 2);
        CGFloat buttonX = [[UIScreen mainScreen]bounds].size.width - 2 * kStatusCellBorderWidth - size.width;
        CGFloat buttonY = (userModel.cellHight - size.width) / 2;
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, size.width, size.height)];
        [button setImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)click:(UIButton *)button
{
    if (button.selected) {
        button.selected = NO;
    }
    else{
        button.selected = YES;
    }
}
@end

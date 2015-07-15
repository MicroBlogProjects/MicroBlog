//
//  PersonInformationViewCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "PersonInformationViewCell.h"
#import "ProfileIconView.h"

@implementation PersonInformationViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andPersonInfo:(ProfileUserModel *)userModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //背景图片
        CGRect mainScreen = [[UIScreen mainScreen]bounds];
        mainScreen.size.height *= 0.2;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:mainScreen];
        imageView.image = [UIImage imageNamed:@"person_information_backgroud"];
        [self addSubview:imageView];
        
        //头像
        CGFloat iconViewX = ([[UIScreen mainScreen]bounds].size.width - IconViewSize) / 2;
        CGFloat iconViewY = kStatusCellBorderWidth;
        CGFloat iconViewW = IconViewSize;
        CGFloat iconViewH = IconViewSize;
        ProfileIconView * iconView = [[ProfileIconView alloc]initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        [iconView getView:userModel];
        iconView.layer.cornerRadius = iconViewW / 2;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = kStatusCellNameFont;
        CGFloat nameY = CGRectGetMaxY(iconView.frame) + kStatusCellBorderWidth;
        CGSize nameSize = [userModel.screen_name sizeWithFont:kStatusCellNameFont];
        CGFloat nameX = ([[UIScreen mainScreen]bounds].size.width - nameSize.width) / 2;
        nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
        nameLabel.text = userModel.screen_name;
        nameLabel.textColor = [UIColor whiteColor];
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
        //关注和粉丝信息
        NSString * attetionAndFan = [NSString stringWithFormat:@"关注 %ld | 粉丝 %ld",userModel.followers_count,userModel.friends_count];
        CGFloat attentionAndFanY = CGRectGetMidY(nameLabel.frame)+kStatusCellBorderWidth;
        CGSize attentionAndFanSize = [attetionAndFan sizeWithFont:kStatusCellNameFont];
        CGFloat attentionAndFanX = ([[UIScreen mainScreen]bounds].size.width - attentionAndFanSize.width) / 2;
        UILabel * attetionAndFanLable = [[UILabel alloc]initWithFrame:CGRectMake(attentionAndFanX, attentionAndFanY, attentionAndFanSize.width, attentionAndFanSize.height)];
        attetionAndFanLable.text = attetionAndFan;
        attetionAndFanLable.font = kStatusCellNameFont;
        attetionAndFanLable.textColor = [UIColor whiteColor];
        [self addSubview:attetionAndFanLable];
        userModel.cellHight = mainScreen.size.height;
    }
    return self;
}
@end

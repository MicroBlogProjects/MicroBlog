//
//  PersonInformationViewCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"
//cell 的边框宽度
#define kStatusCellBorderWidth 10
//昵称字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]
//头像大小
#define IconViewSize 50


@interface PersonInformationViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andPersonInfo:(ProfileUserModel *)userModel;

@end

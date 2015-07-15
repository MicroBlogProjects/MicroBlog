//
//  ProfileFansCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"
//cell 的边框宽度
#define kStatusCellBorderWidth 10
//昵称字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]
//简介字体
#define  kStatusCelldescriptionFont  [UIFont systemFontOfSize:11]
//头像大小
#define KIconViewSize 50

@interface ProfileFansCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andPersonInfo:(ProfileUserModel *)userModel;
@end

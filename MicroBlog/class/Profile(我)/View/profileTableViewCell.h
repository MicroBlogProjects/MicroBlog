//
//  profileTableViewCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"
#import "ProfileUserModel.h"
#import "ProfileIconView.h"
//cell 的边框宽度
#define kStatusCellBorderWidth 10
//昵称字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]



@interface profileTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setProfileUserModel:(ProfileUserModel *) profileUserModel;
@end

//
//  ToolBarCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"

@interface ToolBarCell : UITableViewCell
//粉丝数量按钮的tag
#define fanButtonTag 1003
//关注数量按钮的tag;
#define attentionButtonTag 1002
//微博数量按钮的tag
#define stasusButtonTag 1001
//cell 的边框宽度
#define kStatusCellBorderWidth 10
//昵称字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setProfileUserModel:(ProfileUserModel *) profileUserModel;

@end

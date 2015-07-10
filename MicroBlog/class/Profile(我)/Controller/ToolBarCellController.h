//
//  ToolBarCellController.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"
#import "ProfileStasusController.h"
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



@interface ToolBarCellController : UIViewController
//加载微博界面
@property (nonatomic,strong)ProfileStasusController * profileStasus;

-(void)setProfileUserModel:(ProfileUserModel *) profileUserModel;
@end

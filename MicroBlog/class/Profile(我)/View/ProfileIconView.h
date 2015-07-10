//
//  ProfileIconView.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"

@interface ProfileIconView : UIImageView

-(void)getView:(ProfileUserModel *)userModel;
@end

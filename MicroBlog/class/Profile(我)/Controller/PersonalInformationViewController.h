//
//  PersonalInformationViewController.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"


@protocol PersonInfoDelegate <NSObject>

-(ProfileUserModel *)passValue;

@end
@interface PersonalInformationViewController : UITableViewController
@property (nonatomic,assign) id<PersonInfoDelegate> personInfoDelegate;
@end

//
//  DIYSegmentViewController.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
// DIYsegment 由按钮和nabel组成的  

#import <UIKit/UIKit.h>

//按钮的宽度
#define ButtonWidth [[UIScreen mainScreen]bounds].size.width / 5
//按钮的长度
#define ButtonHight [[UIScreen mainScreen]bounds].size.height / 12
//几号字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]
//主页按钮的tag
#define homePageButtonTag 10001
//微博按钮的tag
#define statusButtonTag 10002
//相册按钮的tage
#define photoAlbumButtonTag 10003
//@class PersonalInformationViewController;
#import "PersonalInformationViewController.h"

@protocol DIYSegmentDelegate <NSObject>

-(void)exchangeView:(NSInteger)tag;

@end
@interface DIYSegmentViewController : UIViewController
@property (nonatomic,assign) id <DIYSegmentDelegate> DIYsegmentdelegate;
@property (nonatomic,strong) PersonalInformationViewController * personInfoController;
@end

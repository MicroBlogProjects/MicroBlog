//
//  DropDownMenu.h
//  MicroBlog
//
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownMenu;
@class MenuTableViewController;

@protocol  DropDownMenuDelegate <NSObject>
@optional
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu ;
@end

typedef void (^DropDownMenueBlock)(NSString *);


@interface DropDownMenu : UIView

+(instancetype)menu ; 
//内容
@property (nonatomic, strong) UIView *content ;
//内容控制器
@property (nonatomic, strong) MenuTableViewController *contentController ;
@property (nonatomic , weak) id<DropDownMenuDelegate> delegate ;
@property (nonatomic, copy) DropDownMenueBlock dropDownMenueBlock;

/**显示*/
-(void)showFrom:(UIView *)from ;
/**销毁*/
-(void)dismiss:(NSString *)string;
@end

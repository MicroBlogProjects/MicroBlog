//
//  ToolBarCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ToolBarCell.h"
#import "MainTabbarViewController.h"
#import "NavigationController.h"
#import "ProfileStasusController.h"
#import "ProfileFansController.h"
#import "AttentionListController.h"


@implementation ToolBarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andProfileUserModel:(ProfileUserModel *)profileUserModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat buttonWidth = [[UIScreen mainScreen]bounds].size.width / 3;
        CGFloat buttonHight = 44.0f;
        
        //微博数量
        //[self deleteButton:stasusButtonTag];//先删除原先的控件 不然会叠加在一起
        CGRect stasusButtonFram = CGRectMake(0,kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * stasusButtonTitle = [NSString stringWithFormat:@"%ld\n微博",profileUserModel.statuses_count];
        [self addButton:stasusButtonFram andTitle:stasusButtonTitle andTag:stasusButtonTag];
        //关注数量
        //[self deleteButton:attentionButtonTag];
        CGRect attentionButton = CGRectMake(buttonWidth, kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * attentionButtonTitle = [NSString stringWithFormat:@"%ld\n关注",profileUserModel.friends_count];
        [self addButton:attentionButton andTitle:attentionButtonTitle andTag:attentionButtonTag];
        //粉丝数量
        //[self deleteButton:fanButtonTag];
        CGRect fansButtonFram = CGRectMake(2 * buttonWidth, kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * fansButtonTitle = [NSString stringWithFormat:@"%ld\n粉丝",profileUserModel.followers_count];
        [self addButton:fansButtonFram andTitle:fansButtonTitle andTag:fanButtonTag];
        
        UIView * view = [self viewWithTag:fanButtonTag];
        profileUserModel.cellHight = CGRectGetMaxY(view.frame);
    }
    return self;
}
- (void) addButton:(CGRect)fram andTitle:(NSString *)title andTag:(NSInteger ) tag;
{
    NSMutableAttributedString * TitleStr = [[NSMutableAttributedString alloc]initWithString:title];
    UIButton * button = [[UIButton alloc]initWithFrame:fram];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = tag;
    button.titleLabel.font = kStatusCellNameFont;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 0;
    [button setAttributedTitle:TitleStr forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)click:(UIButton *)button
{
     NavigationController *nav = [MainTabbarViewController sharedMainTabbarViewController].viewControllers[3];
    //微博
    if(button.tag == 1001){
        ProfileStasusController * stasusController = [[ProfileStasusController alloc]init];
        [nav pushViewController:stasusController animated:YES];
    }
    //关注
    else if (button.tag == 1002){
        AttentionListController * attentionController = [[AttentionListController alloc]init];
        [nav pushViewController:attentionController animated:YES];
    }
    //粉丝
    else{
        ProfileFansController * fansController = [[ProfileFansController alloc]init];
        [nav pushViewController: fansController animated:YES];
    }
}
- (void)deleteButton:(NSInteger )tag
{
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
}
@end

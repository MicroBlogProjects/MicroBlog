//
//  ToolBarCellController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ToolBarCellController.h"
@interface ToolBarCellController ()

@end

@implementation ToolBarCellController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setProfileUserModel:(ProfileUserModel *) profileUserModel
{
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
    
    UIView * view = [self.view viewWithTag:fanButtonTag];
    profileUserModel.cellHight = CGRectGetMaxY(view.frame);
    
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
    [self.view addSubview:button];
}
- (void)click:(UIButton *)button
{
    //微博
    if(button.tag == 1001){
        self.profileStasus = [[ProfileStasusController alloc]init];
        [self.navigationController pushViewController:self.profileStasus animated:YES];
        NSLog(@"%@,%@",self.navigationController,self.profileStasus);
    }
    //关注
    else if (button.tag == 1002){
        
    }
    //粉丝
    else{
        
    }
}
- (void)deleteButton:(NSInteger )tag
{
    UIView *view = [self.view viewWithTag:tag];
    [view removeFromSuperview];
}

@end

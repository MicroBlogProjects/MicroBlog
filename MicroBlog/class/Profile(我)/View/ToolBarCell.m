//
//  ToolBarCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ToolBarCell.h"

@implementation ToolBarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    }
    return self;
}
-(void)setProfileUserModel:(ProfileUserModel *) profileUserModel
{
        CGFloat buttonWidth = [[UIScreen mainScreen]bounds].size.width / 3;
        CGFloat buttonHight = 44.0f;
    
        //微博数量
        [self deleteButton:stasusButtonTag];//先删除原先的控件 不然会叠加在一起
        CGRect stasusButtonFram = CGRectMake(0,kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * stasusButtonTitle = [NSString stringWithFormat:@"%ld\n微博",profileUserModel.statuses_count];
        [self addButton:stasusButtonFram andTitle:stasusButtonTitle andTag:stasusButtonTag];
        //关注数量
        [self deleteButton:attentionButtonTag];
        CGRect attentionButton = CGRectMake(buttonWidth, kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * attentionButtonTitle = [NSString stringWithFormat:@"%ld\n关注",profileUserModel.friends_count];
        [self addButton:attentionButton andTitle:attentionButtonTitle andTag:attentionButtonTag];
        //粉丝数量
        [self deleteButton:fanButtonTag];
        CGRect fansButtonFram = CGRectMake(2 * buttonWidth, kStatusCellBorderWidth, buttonWidth, buttonHight);
        NSString * fansButtonTitle = [NSString stringWithFormat:@"%ld\n粉丝",profileUserModel.followers_count];
        [self addButton:fansButtonFram andTitle:fansButtonTitle andTag:fanButtonTag];
    
    UIView * view = [self viewWithTag:fanButtonTag];
    profileUserModel.cellHight = CGRectGetMaxY(view.frame);

}
- (void) addButton:(CGRect)fram andTitle:(NSString *)title andTag:(NSInteger ) tag;
{
    NSMutableAttributedString * TitleStr = [[NSMutableAttributedString alloc]initWithString:title];
    UIButton * Button = [[UIButton alloc]initWithFrame:fram];
    Button.tag = (tag);
    Button.titleLabel.font = kStatusCellNameFont;
    Button.titleLabel.textAlignment = NSTextAlignmentCenter;
    Button.titleLabel.numberOfLines = 0;
    [Button setAttributedTitle:TitleStr forState:UIControlStateNormal];
    
    [self addSubview:Button];
}
- (void)deleteButton:(NSInteger )tag
{
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
}
@end

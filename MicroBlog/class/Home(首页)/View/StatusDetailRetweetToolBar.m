//
//  StatusDetailRetweetToolBar.m
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  在微博详情页中  转发微博下方的工具条 （转发 评论 赞）
#define kBtnTag 99
#define kBtnTextColor myColor(147, 147, 147)

#import "StatusDetailRetweetToolBar.h"
#import "StatusModel.h"

@implementation StatusDetailRetweetToolBar

-(instancetype)initWithFrame:(CGRect)frame{
 

    if(self = [super initWithFrame:frame]){
        
        [self addButtonWithTitle:@"转发" icon:@"statusdetail_icon_retweet.png" index:0];
        [self addButtonWithTitle:@"评论" icon:@"statusdetail_icon_comment.png" index:1];
        [self addButtonWithTitle:@"赞" icon:@"statusdetail_icon_like.png" index:2];
    }
    return  self;
}


/** 添加一个按钮 */
-(void)addButtonWithTitle:(NSString *)title icon:(NSString *)icon index:(NSUInteger)index {
    CGSize size = self.frame.size ;
    CGFloat btnWidth =  size.width / 3;
    CGFloat btnX = index * btnWidth ;
    
    UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage stretchImageWithName:@"statusdetail_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setTitleColor: kBtnTextColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    button.frame = CGRectMake(btnX, 0, btnWidth, size.height);
    button.tag = index + kBtnTag ;
    
    //设置标题的间隙
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
    
    [self addSubview:button];
    
}


/**  设置数据 */
-(void)setStatusModel:(StatusModel *)statusModel{
    _statusModel = statusModel ;
    
    //设置按钮上的数字
    [self setButtonTitleAtIndex:0 placeholder:@"转发" count:statusModel.reposts_count];
    [self setButtonTitleAtIndex:1 placeholder:@"评论" count:statusModel.comments_count];
    [self setButtonTitleAtIndex:2 placeholder:@"赞" count:statusModel.attitudes_count];
}


/**  设置button里面的数值 */
-(void)setButtonTitleAtIndex:(int)index placeholder:(NSString *)placeholder count:(int)count{
    
    UIButton *button  = (UIButton *)[self viewWithTag:index +kBtnTag ];
    
    if (count == 0) {
        [button setTitle:placeholder forState:UIControlStateNormal];
    } else if (count%10000 == 0) { // 整万
        NSString *title = [NSString stringWithFormat:@"%d万", count/10000];
        [button setTitle:title forState:UIControlStateNormal];
    } else { // 非整万
        double result = (count / 1000) * 0.1;
        
        NSString *title = nil;
        if (((int)result) == 0) { // 不超过1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 超过1W
            title = [NSString stringWithFormat:@"%.1f万", result];
        }
        [button setTitle:title forState:UIControlStateNormal];
    }

}

@end

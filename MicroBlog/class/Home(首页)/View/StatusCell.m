//
//  StatusCell.m
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusCell.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusFrameModel.h"
#import "UIImageView+WebCache.h"
#import "PhotoModel.h"
#import "ToolBar.h"
#import "StatusPhotosView.h"
#import "IconView.h"
#import "NavigationController.h"

#import "MainTabbarViewController.h"
#import "NavigationController.h"
#import "StatusDetailViewController.h"
@interface StatusCell ()

@property (nonatomic , strong) ToolBar *toolbar;

@end
@implementation StatusCell


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
       //与baseCell不一样的东西在这里设置
        [self addOtherObject];
        
        self.retweetView.userInteractionEnabled = YES ;
        [self.retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retweetClick) ]];
    }
    return self ;
}


-(void)retweetClick{
    NSLog(@"121212");
#warning  todo 这里转换还有点不清楚
    NavigationController *nav = (NavigationController *)[MainTabbarViewController sharedMainTabbarViewController].selectedViewController;
    StatusDetailViewController *detail = [[StatusDetailViewController alloc]init ] ;
    detail.statusModel = self.baseFrameModel.statusModel.retweeted_status;
    [nav pushViewController:detail  animated:YES];
}








/** 与baseCell不一样东西在这里设置*/
-(void)addOtherObject{
    
    //1、更多
    CGFloat btnWidth = 40 ;
    CGFloat btnHeight = 40l ;
    CGFloat btnX = self.frame.size.width - btnWidth ;
    CGFloat btnY = 0 ;
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    more.frame  = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self.contentView addSubview:more];
    
}




/**  覆盖高亮显示方法  */
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    // 调用super是为了让cell保持高亮状态
    [super setHighlighted:highlighted animated:animated];
    if(highlighted){
        [self unHighlightSubviews:self.contentView];
    }
}


- (void)unHighlightSubviews:(UIView *)parent
{
    NSArray *views = parent.subviews;
    for (UIButton *child in views) {
        if ([child respondsToSelector:@selector(setHighlighted:)]) {
            child.highlighted = NO;
        }
        [self unHighlightSubviews:child];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
     // 调用super是为了让cell保持高亮状态
    [super setSelected:selected animated:animated];
    if(selected){
        [self unHighlightSubviews:self.contentView];
    }
}


/**
 *  具体设置微博内容的Frame和其他属性
 */
-(void)setBaseFrameModel:(BaseFrameModel *)baseFrameModel{

    [super setBaseFrameModel:baseFrameModel];

    
    /**  工具条 */
    _toolbar.frame = baseFrameModel.toolBarF ;
    _toolbar.statusModel = baseFrameModel.statusModel ;
    [self.contentView addSubview:_toolbar];
    
}


#warning todo 点击微博转发、评论 、点赞
//
//
//#pragma mark- toolBarDelegate 点击转发、评论、点赞
//-(void)toolBar:(ToolBar *)tooBar clickButton:(UIButton *)button{
//    if(button.tag == ToolBarButtonTypeAgree){
//  
//       
//    }
//    if(button.tag == ToolBarButtonTypeComment){
//      
//    }
//    if(button.tag == ToolBarButtonTypeRetweet){
//          NSLog(@"转发");
//    }
//    
//}


@end








































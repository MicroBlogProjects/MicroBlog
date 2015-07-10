//
//  EmotionKeyboard.m
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionTabBar.h"
#import "EmotionListView.h"
#import "EmotionModel.h"
#import "MJExtension.h"
#import "EmotionTool.h"
@interface EmotionKeyboard()<EmotionTabBarDelegate>

@property(nonatomic,strong)EmotionListView *recentlistView;
@property(nonatomic,strong)EmotionListView *defaullistView;
@property(nonatomic,strong)EmotionListView *emojilistView;
@property(nonatomic,strong)EmotionListView *lxhlistView;
@property (nonatomic,weak)EmotionTabBar *tabBar;
@property (nonatomic,weak )UIView *contentView;
@end
@implementation EmotionKeyboard
#pragma mark -懒加载
-(EmotionListView *)recentlistView {
    if(!_recentlistView){
        _recentlistView =[[EmotionListView alloc] init];
        self.recentlistView.emotions=[EmotionTool recentEmotions];
//        self.recentlistView.emotions= ;
    }
    return _recentlistView;
}
-(EmotionListView *)defaullistView {
    if(!_defaullistView){
        _defaullistView =[[EmotionListView alloc] init];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
       _defaullistView.emotions =[EmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaullistView;
}
-(EmotionListView *)emojilistView {
    if(!_emojilistView){
        _emojilistView =[[EmotionListView alloc] init];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojilistView.emotions =[EmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojilistView;
}
-(EmotionListView *)lxhlistView {
    if(!_lxhlistView){
        _lxhlistView =[[EmotionListView alloc] init];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhlistView.emotions =[EmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhlistView;
}
#pragma mark -初始化
-(id)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    
    if(self ){
        // contentview
        UIView  *contentView =[[UIView alloc]init];
        [self addSubview:contentView];
        self.contentView=contentView;
        //tabbar
        EmotionTabBar *tabBar=[[EmotionTabBar alloc]init ];
        [self addSubview:tabBar];
        self.tabBar=tabBar;
        tabBar.delegate=self;
        [NotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:EmotionDidSelectNotification object:nil];
    }
    return self;
}
-(void)emotionDidSelect{
    self.recentlistView.emotions=[EmotionTool recentEmotions];
}
-(void)dealloc {
    [NotificationCenter removeObserver:self];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    //1 tabbar
    self.tabBar.width=self.width;
    self.tabBar.height =37;
    self.tabBar.y=self.height-self.tabBar.height;
    self.tabBar.x=0;
    //2 表情内容
    self.contentView.x=self.contentView.y=0;
    self.contentView.width=self.width;
    self.contentView.height=self.tabBar.y;
    
    UIView *child=[self.contentView.subviews lastObject];
    child.frame =self.contentView.bounds;
}
#pragma mark EmotionTabBarDelegate
-(void)emotionTabBar:(EmotionTabBar *)tabBat didSelectBtutton:(EmotionTabBarButtonType)buttonType {
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case EmotionTabBarButtonTypeRecent://最近
        {
            [self.contentView addSubview:self.recentlistView];
            break;
        }
        case EmotionTabBarButtonTypeDefault://默认
        {
            [self.contentView addSubview:self.defaullistView];            break;
        }
        case EmotionTabBarButtonTypeEmoji://emoji
        {
                        [self.contentView addSubview:self.emojilistView];
            break;
        }
        case EmotionTabBarButtonTypeLxh://lxh
        {
                       [self.contentView addSubview:self.lxhlistView];
            break;
        }
    }
    
    //重新计算子控件的frame（setNeedLayout内部会在恰当的时刻，重新调用layoutSubview，从新布局子控件）
    [self setNeedsLayout];
}
@end

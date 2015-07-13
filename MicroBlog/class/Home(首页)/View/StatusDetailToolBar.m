//
//  StatusDetailToolBar.m
//  MicroBlog
//
//  Created by lai on 15/7/12.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  微博详情页中底部工具条（转发、评论、点赞）

#import "StatusDetailToolBar.h"

@interface StatusDetailToolBar ()

/**里面存放所有的按钮*/
@property (nonatomic , strong) NSMutableArray *buttons ;
/**里面存放所有的分割线*/
@property (nonatomic , strong) NSMutableArray *dividers ;
@property (nonatomic, weak) UIButton *repostBtn;  //转发按钮
@property (nonatomic, weak) UIButton *commentBtn; //评论按钮
@property (nonatomic, weak) UIButton *attitudeBtn; //点赞按钮

@end

@implementation StatusDetailToolBar


+(instancetype)toobar {
    return  [[self alloc] init];
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //设置背景
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toolbar_background"] ];
        self.backgroundColor = [UIColor whiteColor];

        //添加按钮
        self.repostBtn   =  [self setupButtonWithTitle:@"转发" icon:@"timeline_icon_retweet" type:ToolBarButtonTypeRetweet ];
        self.commentBtn  =  [self setupButtonWithTitle:@"评论" icon:@"timeline_icon_comment" type:ToolBarButtonTypeComment ];
        self.attitudeBtn =  [self setupButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"  type:ToolBarButtonTypeAgree];
        
        //添加分割线
        [self setupDevider];
        [self setupDevider];
        
#warning todo 如果有时间，找一下这个背景图片
        //暂时找不到背景图片，所以顶部的分割线就用灰色的View代替
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, window.width, 1)];
        view.backgroundColor = myColor(220,220, 220);
        [self addSubview:view];
        

    }
    
    return self;
}


/**
 *  重写父类的布局，排布ToolBar中按钮的布局
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置按钮的frame
    int count = (int)self.buttons.count ;
    CGFloat buttonW = self.width/count ;
    CGFloat buttonH = self.height;
    for(int i=0 ; i<count ; i++){
        UIButton *button = self.buttons[i];
        button.x = i*buttonW;
        button.y=0;
        button.width = buttonW ;
        button.height = buttonH ;
    }
    
    //设置分割线frame
    int divideCount = (int)self.dividers.count;
    for(int i=0 ; i<divideCount ; i++){
        UIImageView *divider  = self.dividers[i];
        divider.x = (i+1)*buttonW ;
        divider.y =  0 ;
        divider.width = 1;
        divider.height = buttonH;
    }
}



/** 添加分割线 */
-(void)setupDevider{
    UIImageView *diver = [[UIImageView alloc]init] ;
    diver.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:diver];
    [self.dividers addObject:diver];
}

/** 初始化一个按钮*/
-(UIButton *)setupButtonWithTitle:(NSString *)title icon:(NSString *)icon type:(ToolBarButtonType)type {
    
    UIButton *btn  = [[UIButton alloc]init ] ;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0) ;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = type;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.buttons addObject:btn];
    return btn;
}

-(void)buttonClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(toolBar:clickButton:type:)] ){
        [self.delegate toolBar:self clickButton:button type:(int)button.tag];
    }
}


//buttons的懒加载
-(NSMutableArray *)buttons{
    if(_buttons == nil){
        _buttons = [[NSMutableArray alloc]init ] ;
    }
    return  _buttons ;
}
//dividers的懒加载
-(NSMutableArray *)dividers{
    if(_dividers == nil){
        _dividers = [[NSMutableArray alloc]init];
    }
    return _dividers ;
}


@end

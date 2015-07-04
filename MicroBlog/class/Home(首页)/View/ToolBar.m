//
//  ToolBar.m
//  MicroBlog
//
//  Created by lai on 15/7/3.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ToolBar.h"
#import "StatusModel.h"

@interface ToolBar ()
/**里面存放所有的按钮*/
@property (nonatomic , strong) NSMutableArray *buttons ;
/**里面存放所有的分割线*/
@property (nonatomic , strong) NSMutableArray *dividers ;
@property (nonatomic, weak) UIButton *repostBtn;  //转发按钮
@property (nonatomic, weak) UIButton *commentBtn; //评论按钮
@property (nonatomic, weak) UIButton *attitudeBtn; //点赞按钮
@end

@implementation ToolBar

+(instancetype)toobar {
    return  [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
      //设置ToolBar的背景颜色
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
      //添加按钮
      self.repostBtn   =  [self setupButtonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
      self.commentBtn  =  [self setupButtonWithTitle:@"评论" icon:@"timeline_icon_comment"];
      self.attitudeBtn =  [self setupButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
      //添加分割线
      [self setupDevider];
      [self setupDevider];
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

/**
 *  添加分割线
 */
-(void)setupDevider{
    UIImageView *diver = [[UIImageView alloc]init] ;
    diver.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:diver];
    [self.dividers addObject:diver];
}

/**
 *  初始化一个按钮
 *
 *  @param title 按钮文字
 *  @param icon  按钮图标
 */
-(UIButton *)setupButtonWithTitle:(NSString *)title icon:(NSString *)icon{
    
    UIButton *btn  = [[UIButton alloc]init ] ;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0) ;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:btn];
    [self.buttons addObject:btn];
    return btn;
}


-(void)setStatusModel:(StatusModel *)statusModel{
    _statusModel = statusModel ;
    
    [self setupButtonCount:statusModel.reposts_count button:self.repostBtn title:@"转发"];
    [self setupButtonCount:statusModel.comments_count button:self.commentBtn title:@"评论"];
    [self setupButtonCount:statusModel.attitudes_count button:self.attitudeBtn title:@"赞"];
    
   
}

/**
 *  设置 (评论 转发 点赞) 的个数
 *
 *  @param count  评论、转发、点赞的数值
 *  @param button 对应按钮
 *  @param title  原来按钮的title
 */
-(void)setupButtonCount:(int)count button:(UIButton *)button title:(NSString *)title{
    
    if(count){ //如果评论不为0
        if(count < 10000){
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            //例如：  22.0万这种情况，直接去掉 .0
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    
    [button setTitle:title forState:UIControlStateNormal];
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

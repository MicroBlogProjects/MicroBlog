//
//  StatusDetailTitleView.m
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  微博详情页中  评论部分的头部（就是显示转发 评论 赞 的工具条）


#define kBtnWidth 80
#import "StatusDetailTitleView.h"
#import "StatusModel.h"

@interface StatusDetailTitleView ()

@property (nonatomic , strong) UIImageView *bg;
@property (nonatomic , strong) UIImageView *indicator ;
@property (nonatomic , strong) UIButton *selectedBtn;
@property (nonatomic , strong) UIButton *repostButton;
@property (nonatomic , strong) UIButton *commentButton;
@property (nonatomic , strong) UIButton *attitudeButton;

@end




@implementation StatusDetailTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        //设置整个View的背景色
        self.backgroundColor = kGlobalBg ;
        
        //1、白色背景
        _bg = [[UIImageView alloc]init ] ;
        _bg.userInteractionEnabled =YES ;
        _bg.image = [UIImage stretchImageWithName:@"statusdetail_comment_top_background"];
        CGFloat bgX = 0 ;
        CGFloat bgY = 10 ;
        CGFloat bgWidth = frame.size.width ;
        CGFloat bgHeight = frame.size.height - bgY ;
        _bg.frame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
        [self addSubview:_bg];
        
        //2、三角形指示器
        _indicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow"]];
        _indicator.center = CGPointMake(0, _bg.frame.size.height - _indicator.frame.size.height * 0.5);
        [_bg addSubview:_indicator];
        
        
        //添加三个按钮（转发、评论、赞）
        [self addButton];
        
   
    }
    
    
    return self;
}


#pragma mark- 初始化方法
/**  添加三个按钮*/
-(void)addButton{

    _repostButton = [self addButtonWithTitle:@"转发" andX:0];
    
    _commentButton = [self addButtonWithTitle:@"评论" andX:kBtnWidth];
    [self btnClick:_commentButton];
    
    _attitudeButton = [self addButtonWithTitle:@"赞" andX: _bg.frame.size.width - kBtnWidth ];
    _attitudeButton.enabled = NO ;
    
}

/**  添加按钮的具体属性设置 */
-(UIButton *)addButtonWithTitle:(NSString *)title andX:(CGFloat)x{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.frame = CGRectMake(x, 0, kBtnWidth, _bg.frame.size.height);
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [_bg addSubview:btn];
    
    return btn;
}



#pragma  mark- 数据传进来所做的处理
/**  数据入口 */
-(void)setStatusModel:(StatusModel *)statusModel{
    _statusModel =statusModel ;

    [self setButton:_repostButton placeholder:@"转发" count:statusModel.reposts_count] ;
    [self setButton:_commentButton placeholder:@"评论" count:statusModel.comments_count ];
    [self setButton:_attitudeButton placeholder:@"赞" count:statusModel.attitudes_count ] ;
    
}
/**  有数据进来时 ， 修改button的显示内容（多少个评论 多少个转发 多少个赞） */
-(void)setButton:(UIButton *)btn placeholder:(NSString *)placeholder count:(int)count{
    
    if (count == 0) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
    } else if (count%10000 == 0) { // 整万
        NSString *title = [NSString stringWithFormat:@"%d万", count/10000];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 非整万
        double result = (count / 1000) * 0.1;
        
        NSString *title = nil;
        if (((int)result) == 0) { // 不超过1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 超过1W
            title = [NSString stringWithFormat:@"%.1f万", result];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    
    NSString *title = [btn titleForState:UIControlStateNormal];
    title = [title stringByAppendingFormat:@" %@", placeholder];
    [btn setTitle:title forState:UIControlStateNormal];
    
}




#pragma mark- 点击事件
/**  点击按钮 */
-(void)btnClick:(UIButton*)btn{
    
    //让当前按钮取消选中
    _selectedBtn.selected =NO ;
    
    //当新的按钮选中
    btn.selected = YES ;
    
    //新的按钮变成当前按钮
    _selectedBtn = btn ;
    
    [UIView animateWithDuration:0.2 animations:^{
        _indicator.centerX = btn.centerX ;
    }];
    
    
    
}

@end






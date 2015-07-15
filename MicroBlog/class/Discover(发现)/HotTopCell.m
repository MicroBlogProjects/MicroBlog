//
//  HotTop[Cell.m
//  MicroBlog
//
//  Created by lai on 15/7/11.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//
#define kDiscoverHotTopFont [UIFont systemFontOfSize:16]
#define  KDiscoverHotTopMargin 0
#import "HotTopCell.h"

@interface HotTopCell ()

@property (nonatomic , strong) UIButton *leftTopButton ;
@property (nonatomic , strong) UIButton *rightTopButton ;
@property (nonatomic , strong) UIButton *leftBottomButton;
@property (nonatomic , strong) UIButton *rightBottomButton;
@property (nonatomic , strong) UIView *dividerTop;
@property (nonatomic , strong) UIView *dividerBottom;
@property (nonatomic , strong) UIView *dividerLeft;
@property (nonatomic , strong) UIView *dividerRight;
@property (nonatomic , strong) NSMutableArray *titleArray;  //存放热门话题标签

@end

@implementation HotTopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.userInteractionEnabled =YES ;
        
        [self addButton];
        [self addDivider];
    }
    
    return self ;
}

-(void)addButton{
 
    

/** 左上角按钮 */
    CGFloat leftTopButtonX = KDiscoverHotTopMargin ;
    CGFloat leftTopButtonY = KDiscoverHotTopMargin ;
    CGFloat leftTopButtonW = self.contentView.width/2 ;
    CGFloat leftTopButtonH = self.contentView.height ;

    UIButton *leftTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftTopButton setTitle:@"#爸爸去哪儿了#" forState:UIControlStateNormal];
    [leftTopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftTopButton.titleLabel.font = kDiscoverHotTopFont ;
    leftTopButton.frame  = CGRectMake(leftTopButtonX, leftTopButtonY, leftTopButtonW, leftTopButtonH);
    [leftTopButton addTarget:self action:@selector(leftTopButtonClick:) forControlEvents:UIControlEventTouchDown];
    leftTopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    leftTopButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.leftTopButton = leftTopButton ;
    
    
/** 右上角按钮 */
    CGFloat rightTopButtonX = CGRectGetMaxX(leftTopButton.frame);
    CGFloat rightTopButtonY = KDiscoverHotTopMargin ;
    CGFloat rightTopButtonW = self.contentView.width/2 ;
    CGFloat rightTopButtonH = self.contentView.height ;
    
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton setTitle:@"#栀子花开找自己#" forState:UIControlStateNormal];
    [rightTopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightTopButton.titleLabel.font = kDiscoverHotTopFont ;
    rightTopButton.frame  = CGRectMake(rightTopButtonX, rightTopButtonY, rightTopButtonW, rightTopButtonH);
    [rightTopButton addTarget:self action:@selector(rightTopButtonClick:) forControlEvents:UIControlEventTouchDown];
    rightTopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    rightTopButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.rightTopButton = rightTopButton;
    
/** 左下角按钮 */
    CGFloat leftBottomButtonX = KDiscoverHotTopMargin ;
    CGFloat leftBottomButtonY = CGRectGetMaxY(leftTopButton.frame);
    CGFloat leftBottomButtonW = self.contentView.width/2 ;
    CGFloat leftBottomButtonH = self.contentView.height ;
    
    UIButton *leftBottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBottomButton setTitle:@"#runningMan五周年#" forState:UIControlStateNormal];
    [leftBottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBottomButton.titleLabel.font = kDiscoverHotTopFont ;
    leftBottomButton.frame  = CGRectMake(leftBottomButtonX, leftBottomButtonY, leftBottomButtonW, leftBottomButtonH);
    [leftBottomButton addTarget:self action:@selector(leftBottomButtonClick:) forControlEvents:UIControlEventTouchDown];
    leftBottomButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    leftBottomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    leftBottomButton.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;
    
    self.leftBottomButton = leftBottomButton ;
    
    
/**右下角按钮*/
    CGFloat rightBottomButtonX = CGRectGetMaxX(leftBottomButton.frame) ;
    CGFloat rightBottomButtonY = CGRectGetMaxY(rightTopButton.frame);
    CGFloat rightBottomButtonW = self.contentView.width/2 ;
    CGFloat rightBottomButtonH = self.contentView.height ;
    
    UIButton *rightBottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBottomButton setTitle:@"热门话题" forState:UIControlStateNormal];
    [rightBottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBottomButton.titleLabel.font = kDiscoverHotTopFont ;
    rightBottomButton.frame  = CGRectMake(rightBottomButtonX, rightBottomButtonY, rightBottomButtonW, rightBottomButtonH);
    [rightBottomButton addTarget:self action:@selector(rightBottomButtonClcik:) forControlEvents:UIControlEventTouchDown];
    rightBottomButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    rightBottomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.rightBottomButton = rightBottomButton ;
    

    
    [self.contentView addSubview: leftTopButton];
    [self.contentView addSubview: rightTopButton];
    [self.contentView addSubview:leftBottomButton];
    [self.contentView addSubview:rightBottomButton];
    
  
}


-(void)addDivider{
    
    CGFloat dividerTopX = CGRectGetMaxX(_leftTopButton.frame)-1;
    CGFloat dividerTopY = 6;
    CGFloat dividerTopW = 2;
    CGFloat dividerTopH = self.contentView.height-12;
    UIView *dividerTop  = [[UIView alloc]initWithFrame:CGRectMake(dividerTopX, dividerTopY, dividerTopW, dividerTopH)];
    dividerTop.backgroundColor = myColor(239, 239, 239);
    self.dividerTop = dividerTop ;
    
    
    CGFloat dividerBottomX = CGRectGetMaxX(_leftTopButton.frame)-1;
    CGFloat dividerBottomY = CGRectGetMaxY(_leftTopButton.frame)+6;
    CGFloat dividerBottomW = 2;
    CGFloat dividerBottomH = self.contentView.height-12;
    UIView *dividerBottom  = [[UIView alloc]initWithFrame:CGRectMake(dividerBottomX, dividerBottomY, dividerBottomW,dividerBottomH)];
    dividerBottom.backgroundColor = myColor(239, 239, 239);
    self.dividerBottom = dividerBottom ;
    
    
    CGFloat dividerLeftX = 6;
    CGFloat dividerLeftY = CGRectGetMaxY(_leftTopButton.frame)+1;
    CGFloat dividerLeftW = self.contentView.width/2 -12;
    CGFloat dividerLeftH =  2 ;
    UIView *dividerLeft  = [[UIView alloc]initWithFrame:CGRectMake(dividerLeftX, dividerLeftY, dividerLeftW,dividerLeftH)];
    dividerLeft.backgroundColor = myColor(239, 239, 239);
    self.dividerLeft = dividerLeft ;
    
    
    CGFloat dividerRightX = _rightTopButton.x + 6 ;
    CGFloat dividerRightY = CGRectGetMaxY(_leftTopButton.frame)+1;
    CGFloat dividerRightW = self.contentView.width/2 -12;
    CGFloat dividerRightH =  2 ;
    UIView *dividerRight  = [[UIView alloc]initWithFrame:CGRectMake(dividerRightX, dividerRightY, dividerRightW,dividerRightH)];
    dividerRight.backgroundColor = myColor(239, 239, 239);
    self.dividerRight = dividerRight ;
    
 
    [self.contentView addSubview:dividerTop];
    [self.contentView addSubview:dividerBottom];
    [self.contentView addSubview:dividerLeft];
    [self.contentView addSubview:dividerRight];
    
    
    
    
}

-(void)setTitleArray:(NSMutableArray *)titleArray{
    _titleArray = titleArray ;
    
}


-(void)leftTopButtonClick:(UIButton *)button{
    NSLog(@"leftTopButton Click");
}

-(void)rightTopButtonClick:(UIButton *)button{
    NSLog(@"rightTopButton Click");
}

-(void)leftBottomButtonClick:(UIButton*)button{
    NSLog(@"leftBottomButton Click");
}

-(void)rightBottomButtonClcik:(UIButton *)button{
    NSLog(@"rightBottomButton Clcick");
}


@end

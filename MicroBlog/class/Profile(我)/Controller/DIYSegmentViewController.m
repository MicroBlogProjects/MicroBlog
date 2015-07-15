//
//  DIYSegmentViewController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "DIYSegmentViewController.h"

@interface DIYSegmentViewController ()
//现在按钮的下标
@property (nonatomic,assign) NSInteger currIndex;
//菊花色的下标线
@property (nonatomic,strong) UILabel * orangeLineLabel;

@end

@implementation DIYSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currIndex = 2;
    //主页按钮
    CGRect homePageFram = CGRectMake(ButtonWidth, 0, ButtonWidth, ButtonHight);
    [self addButton:homePageFram andTitle:@"主页" AndTag:homePageButtonTag];
    //微博按钮
    CGRect statusFram = CGRectMake(2 * ButtonWidth, 0, ButtonWidth, ButtonHight);
    [self addButton:statusFram andTitle:@"微博" AndTag:statusButtonTag];
    //相册按钮;
    CGRect photoAlbumFram =CGRectMake(3 * ButtonWidth, 0, ButtonWidth, ButtonHight);
    [self addButton:photoAlbumFram andTitle:@"相册" AndTag:photoAlbumButtonTag];
    //灰色线
    UILabel * grayLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ButtonHight, [[UIScreen mainScreen]bounds].size.width, 1)];
    grayLineLabel.backgroundColor = myColor(225, 225, 225);
    [self.view addSubview:grayLineLabel];
    
    self.orangeLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(2 * ButtonWidth, ButtonHight, ButtonWidth, 2)];
    self.orangeLineLabel .backgroundColor = myColor(225, 109, 0);
    [self.view addSubview:self.orangeLineLabel];
    
    
}
//添加按钮
-(void) addButton:(CGRect)fram andTitle:(NSString *)title AndTag:(NSInteger)tag
{
    UIButton * button = [[UIButton alloc]initWithFrame:fram];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = kStatusCellNameFont;
    //正常状态
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //选中状态
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    button.tag = tag;
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//点击按钮
-(void)click:(UIButton *)button
{
    NSInteger tag = button.tag - 10000;
//    NSLog(@"%ld",tag);
    if (tag != self.currIndex) {
        self.currIndex = tag;
        [UIView animateWithDuration:0.3f animations:^{
            CGRect fram = self.orangeLineLabel.frame;
            fram.origin.x = tag * ButtonWidth;
            self.orangeLineLabel.frame = fram;
        } completion:^(BOOL finished) {
            self.DIYsegmentdelegate = self.personInfoController;
            [self.DIYsegmentdelegate exchangeView:tag];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  TitleButton.m
//  MicroBlog
//
//  Created by lai on 15/6/30.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"]forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return  self; 
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+10;
    self.backgroundColor = [UIColor redColor];
}


-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    //每次修改按钮的标题文字就要重新子适应调节大小
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    //每次修改按钮的图片就要重新子适应调节大小
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end

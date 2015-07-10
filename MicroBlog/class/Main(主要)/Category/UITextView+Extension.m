//
//  UITextView+Extension.m
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text{
    [self insertAttributedText:text settingBlock:nil];
}
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock {
    NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]init];
    //拼接之前的文字
    [attributedtext appendAttributedString:self.attributedText];
    //拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedtext replaceCharactersInRange:self.selectedRange withAttributedString:text];
    //设置字体
    //调用外面传进来的代码
    if(settingBlock) {
        settingBlock(attributedtext);
    }
    self.attributedText=attributedtext;
    //移除光标到表情的后面
    self.selectedRange=NSMakeRange(loc+1, 0);
}
@end

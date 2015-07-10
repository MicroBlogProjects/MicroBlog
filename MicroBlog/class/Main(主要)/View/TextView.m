//
//  TextView.m
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TextView.h"

@implementation TextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        // 通知
        // 当UITextView的文字发生改变时，UITextView自己发出一个UITextViewTextChangeNotification通知
        [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  监听文字改变
 *
 *  @param rect 重新绘制
 */
- (void)textDidChange{
        // 重绘(重新调用)
    //setNeedsDisplay 会在下一个消息循环执行这个方法 多次调用也在下一个消息循环只调用一次
    [self setNeedsDisplay];
}
-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder=[placeholder copy];
   [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
/**
 *  重写setText方法
 *
 *  @param rect 传文字的时候触发
 */
-(void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
/**
 *  重写setFont方法
 *
 *  @param rect 改变字体时触发
 */
-(void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    //如果有输入文字就直接返回不要占位文字
    if(self.hasText)return ;
    //占位文字属性
    NSMutableDictionary *attrs= [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=self.font;
    attrs[NSForegroundColorAttributeName]=self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    //画文字
    CGFloat x=5;
    CGFloat w=rect.size.width-2*x;
    CGFloat y=8;
    CGFloat h=rect.size.height-2*y;
    CGRect placeholderRect=CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
@end

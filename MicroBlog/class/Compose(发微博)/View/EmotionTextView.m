//
//  EmotionTextView.m
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionTextView.h"
#import "EmotionModel.h"
#import "EmotionAttachmentModel.h"
@implementation EmotionTextView

- (void)insertEmotion:(EmotionModel *)emotion {
//将文字插入到光标所在的位置
    if(emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
       //加载图片
        EmotionAttachmentModel *attch=[[EmotionAttachmentModel alloc]init];
        //传递模型
        attch.emotion=emotion;

         //设置图片的尺寸
        CGFloat attchWH=self.font.lineHeight;
        attch.bounds=CGRectMake(0, -2 , attchWH , attchWH);

        NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attch];
        //插入属性文字到光标处
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}
-(NSString *)fullText {
    NSMutableString *fullText=[NSMutableString string];
    //遍历所有的属性文字（图片，emoji）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
       //如果是图片表情
        EmotionAttachmentModel *attch=attrs[@"NSAttachment"];
        if(attch){//图片
            [fullText appendString:attch.emotion.chs];
        }else {
           //emoji 普通文本
            NSAttributedString *str=[self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}
-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self hasChange];
}
-(void)hasChange{
    if([self.delegate respondsToSelector:@selector(statusHasChange)]){
        [self.delegate statusHasChange];
    }
}
@end

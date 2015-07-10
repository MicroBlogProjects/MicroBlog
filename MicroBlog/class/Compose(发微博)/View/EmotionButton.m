//
//  EmotionButton.m
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionButton.h"
#import "EmotionModel.h"
@implementation EmotionButton
/**
 *  xib创建的 会调用这个方法
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
    
        self.adjustsImageWhenHighlighted=NO;
    }
    return self;
}
/**
 *  从这个方法中创建
 *
 *  @param emotion <#emotion description#>
 */
-(void)awakeFromNib {
    
}
//-(void)setHeight:(CGFloat)height {
//    
//}
-(void)setEmotion:(EmotionModel *)emotion{
    _emotion=emotion;
    
    if(emotion.png){
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if(emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
            self.titleLabel.font=[UIFont systemFontOfSize:32];
    }

}


@end

//
//  EmotionModel.m
//  MicroBlog
//
//  Created by administrator on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionModel.h"

@implementation EmotionModel
// MJCodingImplementation 调用他的包
-(id)initWithCoder:(NSCoder *)decoder {
    if(self=[super init]){
        self.chs=[decoder decodeObjectForKey:@"chs"];
        self.png=[decoder decodeObjectForKey:@"png"];
        self.code=[decoder decodeObjectForKey:@"code"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:self.chs forKey:@"chs"];
        [enCoder encodeObject:self.png forKey:@"png"];
        [enCoder encodeObject:self.code forKey:@"code"];
}
/**
 *  比较两个对象是否一样
 *
 *  @param object <#object description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)isEqual:(EmotionModel *)object {
    return [self.chs isEqualToString:object.chs]||[self.code isEqualToString:object.code];
}
@end

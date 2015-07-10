//
//  StatusDetailFrameModel.m
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusDetailFrameModel.h"
#import "StatusModel.h"

@implementation StatusDetailFrameModel

-(void)setStatusModel:(StatusModel *)statusModel{
    [super setStatusModel:statusModel];
    
    //如果有转发微博
    if(statusModel.retweeted_status){
        _retweetViewF.size.height += kStatusOptionBarHeight;
        _cellHeight+= kStatusOptionBarHeight ;
    }
    
    
}

@end

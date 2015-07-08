//
//  StatusFrameModel.m
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusPhotosView.h"


@implementation StatusFrameModel


-(void)setStatusModel:(StatusModel *)statusModel{
    [super setStatusModel:statusModel];
    
    _cellHeight  += kStatusOptionBarHeight;

    
}

@end
























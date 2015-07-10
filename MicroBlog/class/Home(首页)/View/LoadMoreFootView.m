//
//  LoadMoreFootView.m
//  MicroBlog
//
//  Created by lai on 15/7/1.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "LoadMoreFootView.h"

@implementation LoadMoreFootView

+(instancetype)footer{
    return  [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreFootView" owner:nil options:nil]lastObject];
}

@end

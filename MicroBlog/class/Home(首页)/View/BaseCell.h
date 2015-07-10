//
//  BaseCell.h
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseFrameModel ;
@interface BaseCell : UITableViewCell{
    
    BaseFrameModel *_baseFrameModel;
}

/** 转发微博容器*/
@property (nonatomic , weak) UIView *retweetView ;

@property (nonatomic , strong)BaseFrameModel *baseFrameModel;

@end

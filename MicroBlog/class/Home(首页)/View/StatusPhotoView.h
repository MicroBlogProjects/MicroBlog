//
//  StatusPhotoView.h
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  9宫格中的一张图片，（为了实现在右下角添加GIF图标）

#import <UIKit/UIKit.h>
@class PhotoModel ;
@interface StatusPhotoView : UIImageView

@property(nonatomic , strong) PhotoModel *photoModel ;

@property (nonatomic , strong) NSString *photoString ;


@end

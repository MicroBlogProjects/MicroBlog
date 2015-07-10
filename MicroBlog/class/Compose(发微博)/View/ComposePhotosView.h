//
//  ComposePhotosView.h
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView
-(void)addPhoto:(UIImage *)photo;
@property(nonatomic,strong,readonly)NSMutableArray *photos;

@end

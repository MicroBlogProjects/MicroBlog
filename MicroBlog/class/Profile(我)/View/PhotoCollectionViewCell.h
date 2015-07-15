//
//  PhotoCollectionViewCell.h
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
//cell 的边框宽度
#define kStatusCellBorderWidth 10

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView * imageView;
-(id)initWithFrame:(CGRect)frame ;
@end

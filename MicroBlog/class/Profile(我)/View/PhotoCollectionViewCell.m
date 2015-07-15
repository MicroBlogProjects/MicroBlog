//
//  PhotoCollectionViewCell.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "SDPhotoBrowser.h"

@interface PhotoCollectionViewCell()<SDPhotoBrowserDelegate>
@end

@implementation PhotoCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
//        ProfileIconView * iconView = [[ProfileIconView alloc]initWithFrame:frame];
//        [iconView getView:usermodel];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)- 10)];
        
        self.imageView.image = [UIImage imageNamed:@"album"];
//        self.imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
//        [self.imageView addGestureRecognizer:gesture];
        [self addSubview:self.imageView];
    }
    return  self;
}
//-(void)photoClick:(UITapGestureRecognizer*)getsture{
//    
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    browser.sourceImagesContainerView = self; // 原图的父控件
//    browser.imageCount = 20; // 图片总数
//    browser.currentImageIndex = getsture.view.tag;  //图片的下标
//    browser.delegate = self;
//    [browser show];
//}

//// 返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    return [self.subviews[index] image];
//}
//
//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
////    NSString *urlStr = [[self.photos[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    NSBundle * bundle = [NSBundle mainBundle];
//    NSString * urlStr = [bundle pathForResource:@"album"  ofType:nil];
//    return [NSURL URLWithString:urlStr];
//}
@end

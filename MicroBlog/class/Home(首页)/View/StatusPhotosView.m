//
//  StatusPhotosView.m
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusPhotosView.h"
#import "StatusPhotoView.h"
#import "PhotoModel.h"
#import "SDPhotoBrowser.h"

#define StatusPhotoWH 70  //图片宽高
#define StatusPhotoMargin 10  //图片间距
#define StatusMaxPhotoCols(count) ((count==4)?2:3)

@interface StatusPhotosView () <SDPhotoBrowserDelegate>
@end

@implementation StatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled =YES;
    }
    return self;
}

/**
 *  根据传进来的图片URL，实现图片的显示内容
 */
-(void)setPhotos:(NSArray *)photos{
    _photos = photos ;
    
    //创建足够数量的图片控件，因为当前拿到的Cell由于重新利用，可能当前的View已经存在之前的imageView
    while (self.subviews.count < photos.count ) {
        StatusPhotoView *imageview = [[StatusPhotoView alloc]init] ;
        [self addSubview: imageview];
    }
    
    //遍历图片，设置1-9张图片内容
    for(int i=0 ; i<self.subviews.count ; i++){
        StatusPhotoView *photoView = self.subviews[i];
        
        if(i < photos.count ){ //只显示图片个数的imageView
            //给每个图片添加手势识别
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
            [photoView addGestureRecognizer:tapGesture];
            photoView.tag = i;  //标志
            photoView.photoModel = photos[i];  //取出数据模型
            photoView.hidden = NO;
        }else{ //隐藏多余的imageView
            photoView.hidden = YES;
        }
    }
    
}

-(void)setPhotoStrings:(NSArray *)photoStrings{
    _photoStrings = photoStrings ;
    
    //创建足够数量的图片控件，因为当前拿到的Cell由于重新利用，可能当前的View已经存在之前的imageView
    while (self.subviews.count < photoStrings.count ) {
        StatusPhotoView *imageview = [[StatusPhotoView alloc]init] ;
        [self addSubview: imageview];
    }
    
    //遍历图片，设置1-9张图片内容
    for(int i=0 ; i<self.subviews.count ; i++){
        StatusPhotoView *photoView = self.subviews[i];
        
        if(i < photoStrings.count ){ //只显示图片个数的imageView
            //给每个图片添加手势识别
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
            [photoView addGestureRecognizer:tapGesture];
            photoView.tag = i;  //标志
            photoView.photoString = photoStrings[i];  //取出数据模型
            photoView.hidden = NO;
        }else{ //隐藏多余的imageView
            photoView.hidden = YES;
        }
    }
}


 


-(void)photoClick:(UITapGestureRecognizer*)getsture{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photos.count?self.photos.count:self.photoStrings.count; // 图片总数
    browser.currentImageIndex = getsture.view.tag;  //图片的下标
    browser.delegate = self;
    [browser show];
}

/**
 *  重写layoutSubviews,目的：设置图片的尺寸和位置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    int photosCount =  self.photos.count?self.photos.count:self.photoStrings.count  ;
    for(int i =0 ; i<photosCount ; i++){
        StatusPhotoView *photoView = self.subviews[i];
        
        int col = i % StatusMaxPhotoCols(photosCount);
        photoView.x = col *(StatusPhotoWH  + StatusPhotoMargin);
        
        int row = i/StatusMaxPhotoCols(photosCount);
        photoView.y = row * (StatusPhotoWH + StatusPhotoMargin);
        
        photoView.width = StatusPhotoWH ;
        photoView.height = StatusPhotoWH ;
        if(photosCount == 1 ){ //只有单张图片的时候长宽都是两倍大小
            photoView.width = StatusPhotoWH*2 ;
            photoView.height = StatusPhotoWH*2 ;
        }
            
        
    }
}

+ (CGSize)sizeWithCount:(int)count{
    //设置最大列数
    int maxCols = StatusMaxPhotoCols(count);

    //列数
    int cols = cols = (count>2)? maxCols : count ;
    CGFloat photosWidth = cols * StatusPhotoWH + (cols-1)*StatusPhotoMargin;
    
    //行数
    int rows = (count + maxCols - 1)/maxCols ;
    CGFloat photosHight = rows * StatusPhotoWH + (rows-1)*StatusPhotoMargin;
    
    if(count == 1){
        photosWidth+=photosWidth;
        photosHight+=photosHight;
    }
        
    return CGSizeMake(photosWidth, photosHight);
}



#pragma mark-SDPhotoBrowser 代理方法
#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] image];
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    if(_photos.count){
        NSString *urlStr = [[self.photos[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        return [NSURL URLWithString:urlStr];
    }
    NSString *urlStr = [self.photoStrings[index]  stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
   
}

@end

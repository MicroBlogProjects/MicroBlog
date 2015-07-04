//
//  StatusPhotoView.m
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  9宫格中的一张图片，（为了实现在右下角添加GIF图标）

#import "StatusPhotoView.h"
#import "PhotoModel.h"
#import "UIImageView+WebCache.h"
@interface StatusPhotoView ()
@property (nonatomic , weak) UIImageView *gifView ;
@end

@implementation StatusPhotoView

 //gifView的懒加载
-(UIImageView *)gifView{
    if(!_gifView){
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView =  [[UIImageView alloc]initWithImage:image];
        [self addSubview: gifView];
        self.gifView = gifView ;
    }
    return _gifView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        //使用图片原始比例自适应，并将超出边框的部分裁减掉
        self.contentMode = UIViewContentModeScaleAspectFill ;
        self.clipsToBounds =YES;
       
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width- self.gifView.width;
    self.gifView.y = self.heigt - self.gifView.heigt;
    
}


/**
 *  将图片的model传进来，完成图片的下载和显示（是否显示gif标志）
 */
-(void)setPhotoModel:(PhotoModel *)photoModel{
    
    _photoModel =photoModel ;
    
    //设置图片 （下载下来）
    [self sd_setImageWithURL:[NSURL URLWithString:photoModel.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示/隐藏GIF标志 (判断方法是：看url文件的后缀有没有gif或者GIF)
    self.gifView.hidden = ![photoModel.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

@end

//
//  NearByStatusFrameModel.m
//  MicroBlog
//
//  Created by lai on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "NearByStatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusPhotosView.h"
#import "AnnotationsModel.h"
#import "PlaceModel.h"

#define  kStatusIconImageWH 35

@implementation NearByStatusFrameModel



/**
 *   计算所有控件的Frame
 */
-(void)setStatusModel:(StatusModel *)statusModel{
    
    
    _statusModel  = statusModel ;
    UserModel *user= statusModel.user;

    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width ;
    
    /** 原创微博*/
    
    /* 头像*/
    CGFloat iconW = kStatusIconImageWH ;
    CGFloat iconH = kStatusIconImageWH ;
    CGFloat iconX = kStatusCellBorderWidth ;
    CGFloat iconY = kStatusCellBorderWidth ;
    self.iconViewF = CGRectMake(iconX , iconY, iconW, iconH);
    
    /* 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:kStatusCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    /* 会员图标*/
    if(user.isVip){
        
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kStatusCellBorderWidth;
        CGFloat vipY = nameY*1.25;
        CGFloat vipH = nameSize.height *0.75;
        CGFloat vipW = nameSize.height *0.75;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /* 时间（微博发布时间）*/
    CGFloat timeX = nameX ;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kStatusCellBorderWidth/2 ;
    CGSize timeSize = [statusModel.created_at sizeWithFont:kStatusCellTimeFont  ];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /* 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kStatusCellBorderWidth;
    CGFloat sourceY = timeY ;
    CGSize  sourceSize = [statusModel.source sizeWithFont:kStatusCellTimeFont  ];
    self.sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    /* 微博正文*/
    
    CGFloat contentX = iconX ;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+kStatusCellBorderWidth;
    CGFloat MaxWidth = cellW - 2*kStatusCellBorderWidth ; //微博消息的最大宽度
    CGSize contenSize = [statusModel.text sizeWithFont:kStatusCellContentFont maxWidth:MaxWidth];
    self.contenLabelF = CGRectMake(contentX, contentY, contenSize.width, contenSize.height);
    
    /* 微博配图*/
    CGFloat originalH = 0 ;  //原创微博整体的高度
    CGFloat locateViewY =0 ;    //定位图标Y值
    if(statusModel.pic_ids.count){ //有配图
        CGFloat photosX = contentX ;
        CGFloat photosY = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
        CGSize photosSize = [StatusPhotosView sizeWithCount:(int)statusModel.pic_ids.count];
        self.photosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        originalH = CGRectGetMaxY(self.photosViewF) + kStatusCellBorderWidth ;
        locateViewY = CGRectGetMaxY(self.photosViewF) + kStatusCellBorderWidth/2 ;
    }else{//没配图
        originalH = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
        locateViewY = originalH ;
    }
    
    AnnotationsModel *annotationModel = statusModel.annotations[0];
    PlaceModel *placeModel = annotationModel.place ;
    if(placeModel.title){ //如果有定位信息（比如：独墅湖大学城）
        
        CGFloat locateViewX = contentX ;
        CGFloat locateViewW = 12;
        CGFloat locateViewH = 15;
        self.locateViewF = CGRectMake(locateViewX, locateViewY, locateViewW, locateViewH);
        
        CGFloat locateLabelX = CGRectGetMaxX(self.locateViewF) + kStatusCellBorderWidth/2;
        CGFloat locateLabelY = locateViewY +2 ;
        CGSize  locateLabelSize = [placeModel.title sizeWithFont:kStatusCellLocateFont maxWidth:MaxWidth];
        self.locationLabelF = CGRectMake(locateLabelX, locateLabelY, locateLabelSize.width, locateLabelSize.height);
        
        
        CGFloat distanceX = CGRectGetMaxX(self.locationLabelF) + kStatusCellBorderWidth ;
        CGFloat distanceY = locateLabelY ;
        NSString *distanceString ;
        if(statusModel.distance >=1000){
            distanceString = [NSString stringWithFormat:@"%.1f公里",statusModel.distance/1000.0];
        }else{
            distanceString = [NSString stringWithFormat:@"%d米",statusModel.distance];
        }
        CGSize  distanceSize = [[NSString stringWithFormat:@"(距离%@)", distanceString] sizeWithFont:kStatusCellLocateFont maxWidth:MaxWidth ];
        self.distanLabelF = CGRectMake(distanceX, distanceY, distanceSize.width, distanceSize.height);
        
        
        originalH = CGRectGetMaxY(self.locateViewF) + kStatusCellBorderWidth ;
  
    }
    
    /*原创微博整体*/
    CGFloat originalX = 0 ;
    CGFloat originalY = kStatusCellBorderWidth ;
    CGFloat originalW = cellW ;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    
   
    /*工具条*/
    CGFloat toolbarX = 0 ;
    CGFloat toolbarY =CGRectGetMaxY(self.originalViewF);
    CGFloat toolbarW = cellW ;
    CGFloat toolbarH = 36;
    self.toolBarF = CGRectMake(toolbarX, toolbarY+1, toolbarW, toolbarH);
    
    
    self.cellHeight = toolbarY +kStatusOptionBarHeight;

}

@end

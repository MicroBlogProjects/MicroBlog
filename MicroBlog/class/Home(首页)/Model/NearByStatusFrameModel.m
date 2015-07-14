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
    if(statusModel.pic_ids){ //有配图
        CGFloat photosX = contentX ;
        CGFloat photosY = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
        CGSize photosSize = [StatusPhotosView sizeWithCount:statusModel.pic_ids.count];
        self.photosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        originalH = CGRectGetMaxY(self.photosViewF) + kStatusCellBorderWidth ;
    }else{//没配图
        originalH = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
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
    
    
    self.cellHeight = toolbarY;

}

@end

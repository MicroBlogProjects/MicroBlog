//
//  StatusFrameModel.m
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusPhotosView.h"


@implementation StatusFrameModel

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
    CGFloat iconW = 50 ;
    CGFloat iconH = 50 ;
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
        CGFloat vipY = nameY ;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = nameSize.height ;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /* 时间（微博发布时间）*/
    CGFloat timeX = nameX ;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kStatusCellBorderWidth ;
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
    if(statusModel.pic_urls.count){ //有配图
        CGFloat photosX = contentX ;
        CGFloat photosY = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
        CGSize photosSize = [StatusPhotosView sizeWithCount:statusModel.pic_urls.count];
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
    
    /**被转发微博*/
    CGFloat toolbarY = 0 ;
    if(statusModel.retweeted_status){ //如果有被转发微博，才计算frame
        StatusModel *retweeted_statusModel = statusModel.retweeted_status; //被转发微博的数据
        UserModel *retweeted_userModel  = retweeted_statusModel.user ; //被转发微博博主的数据
        
        /*被转发微博正文*/
        CGFloat retweetContentX = kStatusCellBorderWidth;
        CGFloat retweetContentY = kStatusCellBorderWidth ;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_userModel.name , retweeted_statusModel.text];
        CGSize retweetContenSize = [retweetContent sizeWithFont:kStatusCellRetweetContentFont maxWidth:MaxWidth];
        self.retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContenSize.width, retweetContenSize.height);
        
        /*被转发微博配图*/
        CGFloat retweetViewH =0 ;
        if(retweeted_statusModel.pic_urls.count){ //如果转发微博有配图
            CGFloat retweetPhotosX = retweetContentX ;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + kStatusCellBorderWidth ;
            CGSize  retweetPhotosSize = [StatusPhotosView sizeWithCount:retweeted_statusModel.pic_urls.count];
            self.retweetPhotosViewF = CGRectMake(retweetPhotosX, retweetPhotosY, retweetPhotosSize.width, retweetPhotosSize.height);
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewF) + kStatusCellBorderWidth ;
        }else{//转发微博没配图
            retweetViewH = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
        }
        
        /*被转发微博整体*/
        CGFloat retweetViewX = 0 ;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = cellW ;
        
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        toolbarY = CGRectGetMaxY(self.retweetViewF); //有转发，则toolBar参照物为转发微博
        
        
    }else{ //没有转发微博
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    
    /*工具条*/
    CGFloat toolbarX = 0 ;
    CGFloat toolbarW = cellW ;
    CGFloat toolbarH = 35;
    self.toolBarF = CGRectMake(toolbarX, toolbarY+1, toolbarW, toolbarH);
    
    
    
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
    self.cellHeightForDetailStatus = toolbarY;
    
    
}



@end
























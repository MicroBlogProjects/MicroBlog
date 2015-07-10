//
//  CommentFrameModel.m
//  MicroBlog
//
//  Created by lai on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//


#import "CommentFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"

@implementation CommentFrameModel



/**
 *   计算所有控件的Frame
 */
-(void)setStatusModel:(StatusModel *)statusModel{
    
    _statusModel = statusModel ;
    UserModel *user= statusModel.user;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width ;
    
    
    /* 头像*/
    CGFloat iconW = kIconImageWidth;
    CGFloat iconH = kIconImageHeight ;
    CGFloat iconX = kCommentCellBorderWidth ;
    CGFloat iconY = kCommentCellBorderWidth ;
    self.iconViewF = CGRectMake(iconX , iconY, iconW, iconH);
    
    /* 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kCommentCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:kCommentCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    /* 会员图标*/
    if(user.isVip){
        
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kCommentCellBorderWidth;
        CGFloat vipY = nameY ;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = nameSize.height ;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /* 时间（微博发布时间）*/
    CGFloat timeX = nameX ;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kCommentCellBorderWidth ;
    CGSize timeSize = [statusModel.created_at sizeWithFont:kCommentCellTimeFont  ];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
   
    
    /* 微博正文*/
    
    CGFloat contentX = timeX ;
    CGFloat contentY =  CGRectGetMaxY(self.timeLabelF)+kCommentCellBorderWidth;
    CGFloat MaxWidth = cellW - 3*kCommentCellBorderWidth- kIconImageWidth;
    CGSize contenSize = [statusModel.text sizeWithFont:kCommentCellContentFont maxWidth:MaxWidth];
    self.contenLabelF = CGRectMake(contentX, contentY, contenSize.width, contenSize.height);
    
    
    
    self.cellHeight = CGRectGetMaxY(_contenLabelF) + kCommentCellBorderWidth ;
    
    
}


@end

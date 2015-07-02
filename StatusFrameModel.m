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



@implementation StatusFrameModel

/**
 *   计算所有控件的Frame
 */
-(void)setStatusModel:(StatusModel *)statusModel{
    _statusModel  = statusModel ;
    UserModel *user= statusModel.user;
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width ;
    
    /*原创微博框架容器*/
    
    /* 头像*/
    CGFloat iconW = 50 ;
    CGFloat iconH = 50 ;
    CGFloat iconX = kStatusCellBorderWidth ;
    CGFloat iconY = kStatusCellBorderWidth ;
    self.iconViewF = CGRectMake(iconX , iconY, iconW, iconH);

    /* 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:kStatusCellNameFont];
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
    CGSize timeSize = [self sizeWithText:statusModel.created_at font:kStatusCellTimeFont  ];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /* 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kStatusCellBorderWidth;
    CGFloat sourceY = timeY ;
    CGSize  sourceSize = [self sizeWithText:statusModel.source font:kStatusCellTimeFont  ];
    self.sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);

    /* 微博正文*/
    
    CGFloat contentX = iconX ;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+kStatusCellBorderWidth;
    CGFloat MaxWidth = cellW - 2*kStatusCellBorderWidth ;
    CGSize contenSize = [self sizeWithText:statusModel.text font:kStatusCellContentFont maxWidth:MaxWidth];
    self.contenLabelF = CGRectMake(contentX, contentY, contenSize.width, contenSize.height);
    
    /* 微博配图*/
    

    /*原创微博整体*/
    CGFloat originalX = 0 ;
    CGFloat originalY = 0 ;
    CGFloat originalW = cellW ;
    CGFloat originalH = CGRectGetMaxY(self.contenLabelF) + kStatusCellBorderWidth ;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /* cell的高度*/
    self.cellHeight =CGRectGetMaxY(self.originalViewF) ;

    
}





/**
 *  计算出给定文本Text的CGsize

 */
-(CGSize)sizeWithText: (NSString *)text font:(UIFont* )font maxWidth:(CGFloat )maxWidth   {
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = font ;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size ;
}

-(CGSize)sizeWithText: (NSString *)text font:(UIFont* )font {
   return   [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}

@end
























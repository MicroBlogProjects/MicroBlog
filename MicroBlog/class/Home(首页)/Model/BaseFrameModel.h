//
//  BaseFrameModel.h
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  StatusModel;

@interface BaseFrameModel : NSObject {
    CGFloat _cellHeight;
    CGRect _retweetViewF  ;
}

/* 微博数据 */
@property (nonatomic , strong) StatusModel *statusModel ;

/*原创微博控件的Frame数据*/

/**原创微博框架容器*/
@property (nonatomic , assign) CGRect originalViewF ;
/** 头像*/
@property (nonatomic , assign) CGRect iconViewF ;
/** 会员图标*/
@property (nonatomic , assign) CGRect vipViewF ;
/** 微博配图*/
@property (nonatomic , assign) CGRect photosViewF ;
/** 昵称*/
@property (nonatomic , assign) CGRect nameLabelF ;
/** 时间（微博发布时间）*/
@property (nonatomic , assign) CGRect timeLabelF ;
/** 来源 */
@property (nonatomic , assign) CGRect sourceLabelF ;
/** 微博正文*/
@property (nonatomic , assign) CGRect contenLabelF ;


/*转发微博*/
/** 转发微博容器*/
@property (nonatomic , assign) CGRect retweetViewF ;
/** 转发微博正文+昵称*/
@property (nonatomic , assign) CGRect retweetContentLabelF ;
/** 转发配图*/
@property (nonatomic , assign) CGRect retweetPhotosViewF ;


/** 底部工具条*/
@property (nonatomic , assign) CGRect toolBarF;

/** cell的高度*/
@property (nonatomic , assign) CGFloat cellHeight;


@end
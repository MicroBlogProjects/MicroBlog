//
//  NearByStatusFrameModel.h
//  MicroBlog
//
//  Created by lai on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  StatusModel;
@interface NearByStatusFrameModel : NSObject

/* 微博数据 */
@property (nonatomic , strong) StatusModel *statusModel ;

/*原创微博控件的Frame数据*/

/**原创微博框架容器*/
@property (nonatomic , assign) CGRect originalViewF ;
/** 头像*/
@property (nonatomic , assign) CGRect iconViewF ;
/** 会员图标*/
@property (nonatomic , assign) CGRect vipViewF ;
/** 定位图标*/
@property (nonatomic , assign) CGRect locateViewF;
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
/** 定位地址 */
@property (nonatomic , assign) CGRect locationLabelF ;
/** 距离*/
@property (nonatomic , assign) CGRect distanLabelF ;




/** 底部工具条*/
@property (nonatomic , assign) CGRect toolBarF;

/** cell的高度*/
@property (nonatomic , assign) CGFloat cellHeight;


@end

//
//  StatusFrameModel.h
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
/*  
 
 一个StatusFrameModel模型里面包含的信息：
     1、存放着一个cell内部所有子控件的frame数据
     2、存放一个cell的高度
     3、存放着一个数据模型StatusModel
 */

#import <Foundation/Foundation.h>
//cell 的边框宽度
#define kStatusCellBorderWidth 10
//昵称字体
#define  kStatusCellNameFont  [UIFont systemFontOfSize:15]
//时间字体
#define  kStatusCellTimeFont [UIFont systemFontOfSize:12]
//微博来源字体
#define  kStatusCellSourceFont [UIFont systemFontOfSize:12]
//微博正文字体
#define  kStatusCellContentFont [UIFont systemFontOfSize:14]

@class  StatusModel;

@interface StatusFrameModel : NSObject

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
@property (nonatomic , assign) CGRect photoViewF ; 
/** 昵称*/
@property (nonatomic , assign) CGRect nameLabelF ; 
/** 时间（微博发布时间）*/
@property (nonatomic , assign) CGRect timeLabelF ; 
/** 来源 */
@property (nonatomic , assign) CGRect sourceLabelF ; 
/** 微博正文*/
@property (nonatomic , assign) CGRect contenLabelF ; 
/** cell的高度*/
@property (nonatomic , assign) CGFloat cellHeight;



@end

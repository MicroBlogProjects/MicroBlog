//
//  CommentFrameModel.h
//  MicroBlog
//
//  Created by lai on 15/7/9.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentModel;
@interface CommentFrameModel : NSObject

/** 评论数据 */
@property (nonatomic , strong) CommentModel *commentModel;
/** 头像*/
@property (nonatomic , assign) CGRect iconViewF ;
/** 会员图标*/
@property (nonatomic , assign) CGRect vipViewF ;
/** 昵称*/
@property (nonatomic , assign) CGRect nameLabelF ;
/** 时间（微博发布时间）*/
@property (nonatomic , assign) CGRect timeLabelF ;

/** 评论正文*/
@property (nonatomic , assign) CGRect contenLabelF ;

/** cell的高度*/
@property (nonatomic , assign) CGFloat cellHeight;



@end

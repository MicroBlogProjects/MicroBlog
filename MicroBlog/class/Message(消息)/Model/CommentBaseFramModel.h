//
//  CommentBaseFramModel.h
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  CommentCellModel;
@interface CommentBaseFramModel : NSObject
{
    CGFloat _cellHeight;
    CGFloat _retweetViewF;
}
@property (nonatomic,assign)CGFloat retweetViewF;
/** 右上角button */
@property (nonatomic,assign)CGRect rightandupButtonF;
/*微博数据*/
@property (nonatomic,strong)CommentCellModel *commentCellModel;
/*头像*/
@property (nonatomic,assign)CGRect iconViewF;
/**会员图标*/
@property (nonatomic,assign)CGRect vipViewF;
/**昵称*/
@property (nonatomic,assign)CGRect nameLabelF;
/**
 *  时间
 */
@property (nonatomic,assign) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic,assign) CGRect sourceLabelF;

/**
 *  cell的高度
 */
@property (nonatomic,assign)CGFloat cellHeight;
/**
 *  微博的这次评论
 */
@property (nonatomic,assign)CGRect contenLabelF;




/**  计算上面那个View的大小 */
@property (nonatomic,assign)CGRect originaViewF;

/**
 *  微博前一次评论
 */
@property (nonatomic,assign)CGRect commentLabelF;
/**
 被评微博主人的头像
 */
@property (nonatomic,assign)CGRect commenticonViewF;
/**
 *  被评微博主人
 */
@property (nonatomic,assign)CGRect commentnameF;
/**
 *  被评微博正文
 */
@property (nonatomic,assign)CGRect commentContentLabelF;
/**
 * 填装被评微博的View
 */
@property (nonatomic,assign)CGRect prestatusViewF;
/**
 *  填装下半部分的view
 */
@property (nonatomic,assign) CGRect retWeetViewF;

@end

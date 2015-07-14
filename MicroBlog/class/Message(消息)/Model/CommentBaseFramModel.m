//
//  CommentBaseFramModel.m
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentBaseFramModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "CommentCellModel.h"
@implementation CommentBaseFramModel
/**
 *  计算各个控件的Frame
 */
-(void)setCommentCellModel:(CommentCellModel *)commentCellModel {
    _commentCellModel =commentCellModel;
    
    UserModel *user=commentCellModel.user;
    
    //cell的宽度
    CGFloat cellW =[UIScreen mainScreen].bounds.size.width;
    //右上角的button、
    self.rightandupButtonF=CGRectMake(cellW-50, kStatusCellBorderWidth, 45, 25);
    //头像
    CGFloat iconW=30;
    CGFloat iconH =30;
    CGFloat iconX=kStatusCellBorderWidth;
    CGFloat iconY =kStatusCellBorderWidth;
    self.iconViewF=CGRectMake(iconX, iconY, iconW, iconH);
    //昵称
    CGFloat nameX=CGRectGetMaxX(self.iconViewF)+kStatusCellBorderWidth;
    CGFloat nameY=iconY;
    CGSize nameSize=[user.name sizeWithFont:[UIFont systemFontOfSize:12]];
    self.nameLabelF=CGRectMake(nameX, nameY, nameSize.width, nameSize.height);

    /* 时间（微博发布时间）*/
    CGFloat timeX = nameX ;
    CGFloat timeY = nameY+nameSize.height;
    CGSize timeSize = [commentCellModel.created_at sizeWithFont:[UIFont systemFontOfSize:9]  ];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    /* 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kStatusCellBorderWidth;
    CGFloat sourceY = timeY ;

    CGSize  sourceSize = [commentCellModel.source sizeWithFont:[UIFont systemFontOfSize:9]  ];
   
    self.sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    
    
    /**微博的这次评论*/
    CGFloat contentX=iconX;
    CGFloat contentY=MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+kStatusCellBorderWidth;
    CGFloat MaxWidth=cellW-2*kStatusCellBorderWidth;//微博最大宽度
    CGSize contenSize=[commentCellModel.text sizeWithFont:[UIFont systemFontOfSize:12]   maxWidth:MaxWidth];
    self.contenLabelF=CGRectMake(contentX, contentY, contenSize.width, contenSize.height);
    
    //计算上面那个View的大小
    CGFloat originalH=CGRectGetMaxY(self.contenLabelF)+kStatusCellBorderWidth;
    CGFloat originalX=0;
    CGFloat originalY=kStatusCellBorderWidth/1.5;
    CGFloat originalW=cellW;
    self.originaViewF=CGRectMake(originalX, originalY, originalW,
                                 originalH);
    CGFloat retwiewY=kStatusCellBorderWidth;
    CGFloat retwiewH=0;
    
    
    //微博前一次评论
    if(commentCellModel.reply_comment){
        CGFloat commentconX=kStatusCellBorderWidth;
        CGFloat commentconY=kStatusCellBorderWidth/2;
        NSString *commenttext=[NSString stringWithFormat:@"@%@:%@",self.commentCellModel.reply_comment.user.name,self.commentCellModel.reply_comment.text];

        CGSize retWeetContenSize =[commenttext sizeWithFont:[UIFont systemFontOfSize:14] maxWidth:MaxWidth];

        self.commentLabelF=CGRectMake(commentconX, commentconY, retWeetContenSize.width, retWeetContenSize.height);
        retwiewY=CGRectGetMaxY(self.commentLabelF);
        retwiewH=retWeetContenSize.height;
    }else {
        retwiewY =0;
        retwiewH=0;
    }
    /**
     *  被评微博主人的头像
     */
    CGFloat SiconH=50;
    CGFloat SiconW=50;
    CGFloat SiconX=0;
    CGFloat SiconY=0;
    self.commenticonViewF=CGRectMake(SiconX, SiconY, SiconW, SiconH);
    
    /**
     *  被评微博主人名字
     */
    CGFloat SnameX=CGRectGetMaxX(self.commenticonViewF)+kStatusCellBorderWidth/2;
    CGFloat SnameY=kStatusCellBorderWidth/2;
    NSString *Sname=[NSString stringWithFormat:@"@%@",commentCellModel.status.user.name];
    CGSize SnameSize=[Sname sizeWithFont:[UIFont systemFontOfSize:13]];
    self.commentnameF=CGRectMake(SnameX, SnameY, SnameSize.width, SnameSize.height);
    /**
     *  被评微博正文
     */
    CGFloat PstausX=SnameX;
    CGFloat PstausY=CGRectGetMaxY(self.commentnameF)+kStatusCellBorderWidth/2;
    CGFloat PstausH=SiconH-PstausY-kStatusCellBorderWidth/2;
    CGFloat PstausW=cellW-PstausX-kStatusCellBorderWidth/2;
    self.commentContentLabelF=CGRectMake(PstausX, PstausY, PstausW, PstausH);
    /**
     *  填装被评微博的View
     */
    CGFloat SX=kStatusCellBorderWidth;
    CGFloat SY=retwiewY+kStatusCellBorderWidth/2;
    CGFloat SW=cellW-2*kStatusCellBorderWidth;
    CGFloat SH=SiconH;
    self.prestatusViewF=CGRectMake(SX, SY, SW, SH);
    
    //填装下半部分的view
    CGFloat X=0;
    CGFloat Y=CGRectGetMaxY(self.originaViewF);
    CGFloat W=cellW;
    CGFloat H=CGRectGetMaxY(self.prestatusViewF);
    self.retWeetViewF=CGRectMake(X, Y, W, H);
    self.cellHeight=CGRectGetMaxY(self.retWeetViewF);
}
@end

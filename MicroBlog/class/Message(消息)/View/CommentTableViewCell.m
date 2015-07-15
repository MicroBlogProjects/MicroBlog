//
//  CommentTableViewCell.m
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentCellModel.h"
#import "CommentBaseFramModel.h"
@interface CommentTableViewCell()
/** 右上角button */
@property (nonatomic,weak) UIButton *rightandupButton;
/**  原创微博框架容器 */
@property (nonatomic,weak) UIView *originaView;
/*头像*/
@property (nonatomic,weak) IconView *iconView;
/**会员图标*/
@property (nonatomic,weak)UIImageView *vipView;
/**昵称*/
@property (nonatomic,weak)UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic,weak)UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic,weak) UILabel *sourceLabel;
/**
 *  微博正文
 */
@property (nonatomic,weak) UILabel *contenLabel;
/**
 *  微博容器
 */
@property (nonatomic,weak) UIView *retWeetView;
/**
 *  被评微博正文
 */
@property (nonatomic,weak) UILabel *commentContentLabel;
/**
 *  微博第一次评论
 */
@property (nonatomic,weak)UILabel *commentLabel;
/*微博组人头像*/
@property (nonatomic,weak)IconView *commenticonView;
//被评微博主人
@property (nonatomic,weak)UILabel *commentname;
//微博view
@property (nonatomic,weak) UIView *prestatusView;
// 填充白色的view
@property (nonatomic,weak) UIView *brankView;
@end
@implementation CommentTableViewCell
/**
 *  cell的初始化方法 一个cell只会调用一次
   一般在这里添加所有可能显示的子控件以及子空间的一次性设置
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor =[UIColor clearColor];
        //初始化原创微博模块
        [self setupOriginal];
    }
    return self;
}
-(void)setupOriginal {
    
    /**  上面那个View */

    UIView *originaView=[[UIView alloc] init];
    [self.contentView addSubview:originaView];
    self.originaView=originaView;
    [self.originaView setBackgroundColor:[UIColor whiteColor]];
    
    /** 右上角button */
    UIButton *rightandupButton=[[UIButton alloc] init];
    [rightandupButton setTitle:@"回复" forState:UIControlStateNormal];
    [rightandupButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.originaView addSubview:rightandupButton];
    [rightandupButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_below_button"] forState:UIControlStateNormal];
    rightandupButton.font=[UIFont systemFontOfSize:14];
    self.rightandupButton=rightandupButton;

    
    /*头像*/
     IconView *iconView=[[IconView alloc] init];
    [self.originaView addSubview:iconView];
    self.iconView=iconView;
    
    /**会员图标*/
    UIImageView *vipView=[[UIImageView alloc]init];
    [self.originaView addSubview:vipView];
    self.vipView=vipView;
    
    /**昵称*/
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.font=[UIFont systemFontOfSize:12];
    [self.originaView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    /***  时间*/
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.font=[UIFont systemFontOfSize:9];
    [self.originaView addSubview:timeLabel];
    self.timeLabel=timeLabel;
    /***  来源     */
    UILabel *sourceLabel=[[UILabel alloc] init];
    [self.originaView addSubview:sourceLabel];
    self.sourceLabel=sourceLabel;
    /***  第一次评论微博    */
    UILabel *contenLabel=[[UILabel alloc] init];
    [self.originaView addSubview:contenLabel];
    self.contenLabel=contenLabel;
    self.contenLabel.numberOfLines=0;
    self.contenLabel.font=[UIFont systemFontOfSize:12];
    /***  下面那个view*/
    UIView *retWeetView=[[UIView alloc]init];
    [self.contentView addSubview:retWeetView];
    self.retWeetView=retWeetView;

    /***  微博第一次评论 */
    
    UILabel *commentLabel=[[UILabel alloc] init];
    [self.retWeetView addSubview:commentLabel];
    commentLabel.font=[UIFont systemFontOfSize:14];
    self.commentLabel=commentLabel;
    UIView *prestatusView=[[UIView alloc] init];
    /* view中嵌套的那个view */
    [self.retWeetView addSubview:prestatusView];
    self.prestatusView=prestatusView;
    /*被评论的微博主人头像*/
    IconView *commenticonView=[[IconView alloc]init];
    [self.prestatusView addSubview:commenticonView];
    self.commenticonView=commenticonView;
    
    //被评微博主人名字
    UILabel *commentname=[[UILabel alloc] init];
    [self.prestatusView addSubview:commentname];
    self.commentname=commentname;
    self.commentname.font=[UIFont systemFontOfSize:13];
    /**
     *  被评微博正文
     */
    UILabel *commentContentLabel=[[UILabel alloc]init];
    [self.prestatusView addSubview:commentContentLabel];
    self.commentContentLabel=commentContentLabel;
    self.commentContentLabel.numberOfLines=2;
    
}
-(void)setCommentBaseFramModel:(CommentBaseFramModel *)commentBaseFramModel {
    _commentBaseFramModel =commentBaseFramModel;
    CommentCellModel *cellModel=commentBaseFramModel.commentCellModel;
    UserModel *userMode=cellModel.user;
    /** 右上角button */
    self.rightandupButton.frame=commentBaseFramModel.rightandupButtonF;
    
    /**  原创微博框架容器 */
    self.originaView.frame=commentBaseFramModel.originaViewF;
    
    /*头像*/
    self.iconView.frame =commentBaseFramModel.iconViewF;
    self.iconView.userModel=userMode;
    
    /**会员图标*/
    if(userMode.isVip){
        self.vipView.hidden=NO;
        self.vipView.frame=commentBaseFramModel.vipViewF;
        NSString *vipImageName=[NSString stringWithFormat:@"common_icon_membership_level%d",userMode.mbrank];
        self.vipView.image=[UIImage imageNamed:vipImageName];
        self.nameLabel.textColor=[UIColor orangeColor];
    }else {
        self.nameLabel.textColor=[UIColor blackColor];
        self.vipView.hidden=YES;
    }
    /**昵称*/
    self.nameLabel.frame=commentBaseFramModel.nameLabelF;
    self.nameLabel.text=userMode.name;
    /**
     *  时间
     */
    NSString *time=cellModel.created_at;
    CGFloat timeX=commentBaseFramModel.nameLabelF.origin.x;
    CGFloat timeY=CGRectGetMaxY(commentBaseFramModel.nameLabelF);
    CGSize timeSize=[time sizeWithFont:[UIFont systemFontOfSize:9]];
    self.timeLabel.frame=CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.text=time;
    /**
     *  来源
     */
    NSString *source=cellModel.source;
    CGFloat sourceX=CGRectGetMaxX(self.timeLabel.frame)+kStatusCellBorderWidth;
    CGFloat soruceY=timeY;
    CGSize soruceSize=[source sizeWithFont:[UIFont systemFontOfSize:9]];
    self.sourceLabel.frame=CGRectMake(sourceX, soruceY, soruceSize.width, soruceSize.height);
    self.sourceLabel.font=[UIFont systemFontOfSize:9];
    self.sourceLabel.text=source;
    /**
     *  微博正文
     */
    self.contenLabel.frame=commentBaseFramModel.contenLabelF;
    self.contenLabel.font=[UIFont systemFontOfSize:12];
    self.contenLabel.numberOfLines=0;
    self.contenLabel.text=cellModel.text;
    /**
     *  微博容器
     */
    self.retWeetView.frame=commentBaseFramModel.retWeetViewF;
   
    /**
    *  微博第一次评论
     */
    int d=0;
    if(cellModel.reply_comment){
        d++;
        self.retWeetView.backgroundColor=myColor(245, 245, 245);
        self.commentLabel.hidden=NO;
    NSString *name=[NSString stringWithFormat:@"@%@:%@",cellModel.reply_comment.user.name,cellModel.reply_comment.text];
       
    self.commentLabel.text=name;
    self.commentLabel.numberOfLines=0;
       
    self.commentLabel.frame=commentBaseFramModel.commentLabelF;
    }else {
        self.commentLabel.hidden=YES;
        self.retWeetView.backgroundColor=myColor(245, 245, 245);
    }
    self.prestatusView.frame=commentBaseFramModel.prestatusViewF;
    if(d>0){
        self.prestatusView.backgroundColor=myColor(254, 254, 254);
    }else {
        self.prestatusView.backgroundColor=myColor(245, 245, 245);
    }
    /*微博组人头像*/
    self.commenticonView.userModel=cellModel.status.user;
    self.commenticonView.frame=commentBaseFramModel.commenticonViewF;

    //被评微博主人名字
    self.commentname.frame=commentBaseFramModel.commentnameF;
    self.commentname.text=[NSString stringWithFormat:@"@%@",cellModel.status.user.name];
    

        /**
         *  被评微博正文
         */
        self.commentContentLabel.frame=commentBaseFramModel.commentContentLabelF;
            self.commentContentLabel.text=cellModel.status.text;
    self.commentContentLabel.font=[UIFont systemFontOfSize:10];
    self.commentContentLabel.numberOfLines=2;
    
}
@end

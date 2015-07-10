//
//  CommentCell.m
//  MicroBlog
//
//  Created by lai on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentCell.h"
#import "StatusCell.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "CommentFrameModel.h"
#import "UIImageView+WebCache.h"
#import "IconView.h"

@interface  CommentCell ()

/** 头像*/
@property (nonatomic , weak)  IconView *iconView ;
/** vip图片*/
@property (nonatomic , weak) UIImageView  *vipView ;
/** 昵称*/
@property (nonatomic , weak) UILabel *name ;
/** 时间*/
@property (nonatomic , weak) UILabel *time ;
/** 评论内容*/
@property (nonatomic , weak) UILabel *commentContent ;


@end



@implementation CommentCell

+(instancetype )cellWithTablView:(UITableView *)tableView {
    
    static NSString *ID = @"comment" ;
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor whiteColor];

        [self initContent];
    }
    return self ;
}

-(void)initContent{
    
    /* 设置头像*/
    IconView *iconView = [[IconView alloc]init] ;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    /* vip头像*/
    UIImageView *vipView = [[UIImageView alloc]init ] ;
    self.vipView = vipView ;
    [self.contentView addSubview:vipView];
 
    /* 昵称*/
    UILabel *name = [[UILabel alloc]init];
    self.name = name ;
    [self.contentView addSubview:name];
    
    /* 时间*/
    UILabel *time = [[UILabel alloc]init];
    self.time = time ;
    [self.contentView addSubview:time];
    
    /* 评论内容*/
    UILabel *commentContent  = [[UILabel alloc]init] ;
    self.commentContent = commentContent ;
    [self.contentView addSubview:commentContent];
}

-(void)setCommentFrameModel:(CommentFrameModel *)commentFrameModel{
    
    _commentFrameModel = commentFrameModel ;
    
    StatusModel *commentModel = _commentFrameModel.statusModel ;
    UserModel *userModel = commentModel.user  ;
    
    
    //头像
    self.iconView.frame = commentFrameModel.iconViewF ;
    self.iconView.userModel = userModel ;
//    NSLog(@"%@",userModel);
    
    //vip
    if(userModel.isVip){
        self.vipView.hidden = NO ;
        self.vipView.frame = commentFrameModel.vipViewF;
        self.name.textColor = [UIColor orangeColor];
        NSString *vipString = [NSString stringWithFormat:@"common_icon_membership_level%d",userModel.mbrank];
        self.vipView.image = [UIImage imageNamed:vipString];
    }else{
        self.vipView.hidden = YES ;
        self.name.textColor = [UIColor blackColor];
    }
    
    //名字
    self.name.frame = commentFrameModel.nameLabelF ;
    self.name.font = kCommentCellNameFont;
    self.name.text = userModel.name ;
    
    
    /* 时间（微博发布时间）, 每次刷新的时候都要重新计算一下Frame,因为时间会变，宽度就会变 */
    NSString *time = commentModel.created_at ;
    NSLog(@"%@",time);
    CGFloat timeX =  commentFrameModel.nameLabelF.origin.x ;
    CGFloat timeY = CGRectGetMaxY(commentFrameModel.nameLabelF) + kStatusCellBorderWidth/2 ;
    CGSize timeSize = [time sizeWithFont:kCommentCellTimeFont  ];
    self.time.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.time.font = kCommentCellTimeFont;
    self.time.text = time;
    
    //评论内容
    self.commentContent.frame = commentFrameModel.contenLabelF ;
    self.commentContent.text = commentFrameModel.statusModel.text;
    self.commentContent.font = kCommentCellContentFont;
    
}


@end

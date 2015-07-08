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
#import "StatusFrameModel.h"
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
        
        self.backgroundColor = [UIColor redColor];

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

-(void)setStatusFrameModel:(StatusFrameModel *)statusFrameModel{
    _statusFrameModel = statusFrameModel ;
//    NSLog(@"%@",statusFrameModel);
    StatusModel * statusModel = statusFrameModel.statusModel ;
    UserModel *userModel = statusModel.user  ;
    
    self.iconView.frame = statusFrameModel.iconViewF ;
    self.iconView.userModel = userModel ;
//    NSLog(@"%@",userModel);
    
    if(userModel.isVip){
        self.vipView.hidden = NO ;
        self.vipView.frame = statusFrameModel.vipViewF;
        self.name.textColor = [UIColor orangeColor];
        NSString *vipString = [NSString stringWithFormat:@"common_icon_membership_level%d",userModel.mbrank];
        self.vipView.image = [UIImage imageNamed:vipString];
    }else{
        self.vipView.hidden = YES ;
        self.name.textColor = [UIColor blackColor];
    }
    
    
}


@end

//
//  StatusCell.m
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusCell.h"
#import "StatusModel.h"
#import "StatusFrameModel.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"

@interface StatusCell ()
/*原创微博*/

/**原创微博容器*/
@property (nonatomic , weak) UIView *originalView ;
/** 头像*/
@property (nonatomic , weak) UIImageView *iconView ;
/** 会员图标*/
@property (nonatomic , weak) UIImageView *vipView ;
/** 微博配图*/
@property (nonatomic , weak) UIImageView *photoView ;
/** 昵称*/
@property (nonatomic , weak) UILabel *nameLabel ;
/** 时间（微博发布时间）*/
@property (nonatomic , weak) UILabel *timeLabel ;
/** 来源 */
@property (nonatomic , weak) UILabel *sourceLabel ;
/** 微博正文*/
@property (nonatomic , weak) UILabel *contenLabel ;

@end



@implementation StatusCell

/**
 *  负责返回一个DIY好的Cell
 */
+(instancetype )cellWithTablView:(UITableView *)tableView{
    
    static NSString *ID = @"Cell" ;
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        /**原创微博框架容器*/
        UIView *originalView  = [[UIView alloc]init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /** 头像*/
         UIImageView *iconView = [[UIImageView alloc]init];
        [self.originalView addSubview:iconView];
        self.iconView = iconView ;
        
        /** 会员图标*/
        UIImageView *vipView = [[UIImageView alloc]init];
        [self.originalView addSubview:vipView];
        self.vipView = vipView ;
        
        /** 微博配图*/
        UIImageView *photoView = [[UIImageView alloc]init];
        [self.originalView addSubview:photoView];
        self.photoView = photoView ;
        
        /** 昵称*/
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = kStatusCellNameFont;
        [self.originalView addSubview:nameLabel];
        self.nameLabel = nameLabel ;
        
        /** 时间（微博发布时间）*/
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = kStatusCellTimeFont ;
        [self.originalView addSubview:timeLabel];
        self.timeLabel = timeLabel ;
        
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = kStatusCellSourceFont;
        [self.originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel ;
        
        /** 微博正文*/
        UILabel *contenLabel = [[UILabel alloc]init];
        contenLabel.font = kStatusCellContentFont ;
        contenLabel.numberOfLines =0 ;
        [self.originalView addSubview:contenLabel];
        self.contenLabel = contenLabel ;
        
        
    }
    return self ;
}



-(void)setStatusFrameModel:(StatusFrameModel *)statusFrameModel{
    _statusFrameModel = statusFrameModel ;
    
    StatusModel *statusModel = statusFrameModel.statusModel ;
    UserModel *userModel = statusModel.user;

    
    /**原创微博容器*/
    self.originalView.frame = statusFrameModel.originalViewF;
    self.originalView.backgroundColor = [UIColor redColor];
    
    
    /** 头像*/
    self.iconView.frame = statusFrameModel.iconViewF ;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    /** 会员图标*/
    if(userModel.isVip){
         self.vipView.hidden =NO;
         self.vipView.frame = statusFrameModel.vipViewF ;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",userModel.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor]; 
         self.vipView.hidden =YES;
    }
    
    /** 微博配图*/
    self.photoView.frame = statusFrameModel.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
    /** 昵称*/
    self.nameLabel.frame = statusFrameModel.nameLabelF;
    self.nameLabel.text = userModel.name ;
    
#warning 时间的格式还没修改
    /** 时间（微博发布时间）*/
    self.timeLabel.frame = statusFrameModel.timeLabelF;
    self.timeLabel.text = statusModel.created_at ; 
#warning  来源格式还没修改
    /** 来源 */
    self.sourceLabel.frame = statusFrameModel.sourceLabelF;
    self.sourceLabel.text = statusModel.source ;
    
    /** 微博正文*/
    self.contenLabel.frame = statusFrameModel.contenLabelF;
    self.contenLabel.text = statusModel.text ; 
    
}

@end










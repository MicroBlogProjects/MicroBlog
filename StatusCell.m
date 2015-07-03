//
//  StatusCell.m
//  MicroBlog
//
//  Created by lai on 15/7/2.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "StatusCell.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusFrameModel.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "photoModel.h"
#import "ToolBar.h"

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


/*转发微博*/
/** 转发微博容器*/
@property (nonatomic , weak) UIView *retweetView ;
/** 转发微博正文+昵称*/
@property (nonatomic , weak) UILabel *retweetContentLabel ;
/** 转发配图*/
@property (nonatomic , weak) UIImageView *retweetPhotoView ;


/** 工具条*/
@property (nonatomic , weak) ToolBar *toolbar;


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
        self.backgroundColor = [UIColor clearColor];
//        self.selectionStyle = UITableViewCellEditingStyleNone; //点击cell不变色
//        UIView *view = [[ UIView alloc]init];
//       view.backgroundColor = [UIColor blueColor];
//        self.selectedBackgroundView = view ;              //设置选中cell时显示的颜色
        
       //初始化原创微博模块
        [self setupOriginal];
       //初始化转发微博模块
        [self setupRetweet];
       //初始化工具条
        [self setupToolBar];
        
        
    }
    return self ;
}
/**
 *  初始化微博工具条 (转发 评论 点赞)
 */
-(void)setupToolBar{
    ToolBar *toolBar = [[ToolBar alloc]init] ; 
    [self.contentView addSubview:toolBar];
    self.toolbar = toolBar ;
    
}

/**
 *  初始化转发微博模块
 */
-(void)setupRetweet{
  /** 转发微博整体*/
    UIView *retweetView = [[UIView alloc]init] ;
    retweetView.backgroundColor =myColor(245, 245, 245);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView ;
  
  /** 转发微博正文+昵称*/
    UILabel *retweetContentLabel = [[UILabel alloc]init ] ;
    retweetContentLabel.numberOfLines = 0 ;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel ;
    
  /** 转发微博配图 */
    UIImageView * retweetPhotoView = [[UIImageView alloc]init ] ;
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
}


/**
 *  初始化原创微博模块
 */
-(void)setupOriginal{
    /**原创微博框架容器*/
    UIView *originalView  = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
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

/**
 *  具体设置微博内容的Frame和其他属性
 */
-(void)setStatusFrameModel:(StatusFrameModel *)statusFrameModel{
    _statusFrameModel = statusFrameModel ;
    
    StatusModel *statusModel = statusFrameModel.statusModel ;
    UserModel *userModel = statusModel.user;

    /**原创微博容器*/
    self.originalView.frame = statusFrameModel.originalViewF;
    
    /* 头像*/
    self.iconView.frame = statusFrameModel.iconViewF ;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    /* 会员图标*/
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
    
    /* 微博配图*/
    if(statusModel.pic_urls.count){
        self.photoView.frame = statusFrameModel.photoViewF ;
        photoModel *photoModel = [statusModel.pic_urls lastObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photoModel.thumbnail_pic]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES ; 
    }
    
    /* 昵称*/
    self.nameLabel.frame = statusFrameModel.nameLabelF;
    self.nameLabel.text = userModel.name ;
    
#warning 时间的格式还没修改
    /* 时间（微博发布时间）*/
    self.timeLabel.frame = statusFrameModel.timeLabelF;
    self.timeLabel.text = statusModel.created_at ;
    
#warning  来源格式还没修改
    /* 来源 */
    self.sourceLabel.frame = statusFrameModel.sourceLabelF;
    self.sourceLabel.text = statusModel.source ;
    
    /* 微博正文*/
    self.contenLabel.frame = statusFrameModel.contenLabelF;
    self.contenLabel.text = statusModel.text ; 
    
    
    /**被转发的微博*/
    if(statusModel.retweeted_status){  //如果有转发
        StatusModel *retweeted_statusModel = statusModel.retweeted_status;
        UserModel *retweeted_status_userModel = retweeted_statusModel.user ;
        
        
        self.retweetView.hidden = NO;
        /*被转发微博的整体*/
        self.retweetView.frame = statusFrameModel.retweetViewF ;
        
        /*被转发微博的正文*/
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_userModel.name , retweeted_statusModel.text];
        self.retweetContentLabel.frame = statusFrameModel.retweetContentLabelF;
        self.retweetContentLabel.font = kStatusCellRetweetContentFont;
        self.retweetContentLabel.text = retweetContent;
        
        /*被转发微博的配图*/
        if(retweeted_statusModel.pic_urls.count){//如果转发微博有配图
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrameModel.retweetPhotoViewF;
            photoModel *retweetPhoto = [retweeted_statusModel.pic_urls firstObject]; //只取出图片的第一张
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
          
        }else{ //没有配图
            self.retweetPhotoView.hidden = YES;
        }
        
  
    }else{//如果没有转发微博
        self.retweetView.hidden = YES;
    }
    
    /**  工具条 */
    self.toolbar.frame = statusFrameModel.toolBarF ;
    self.toolbar.statusModel = statusFrameModel.statusModel;
    
    
}





@end








































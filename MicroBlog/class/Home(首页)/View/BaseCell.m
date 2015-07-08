//
//  BaseCell.m
//  MicroBlog
//
//  Created by lai on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "BaseCell.h"
#import "IconView.h"
#import "StatusPhotosView.h"
#import "ToolBar.h" 
#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"



@interface BaseCell ()

/*原创微博*/
/**原创微博容器*/
@property (nonatomic , weak) UIView *originalView ;
/** 头像*/
@property (nonatomic , weak) IconView *iconView ;
/** 会员图标*/
@property (nonatomic , weak) UIImageView *vipView ;
/** 微博配图*/
@property (nonatomic , weak) StatusPhotosView *photosView ;
/** 昵称*/
@property (nonatomic , weak) UILabel *nameLabel ;
/** 时间（微博发布时间）*/
@property (nonatomic , weak) UILabel *timeLabel ;
/** 来源 */
@property (nonatomic , weak) UILabel *sourceLabel ;
/** 微博正文*/
@property (nonatomic , weak) UILabel *contenLabel ;


/*转发微博*/

/** 转发微博正文+昵称*/
@property (nonatomic , weak) UILabel *retweetContentLabel ;
/** 转发配图*/
@property (nonatomic , weak) StatusPhotosView *retweetphotosView ;

/** 工具条*/
@property (nonatomic , weak) ToolBar *toolbar;

@end



@implementation BaseCell

 

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





#pragma mark- 初始化微博框架
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
    StatusPhotosView * retweetphotosView = [[StatusPhotosView alloc]init ] ;
    [retweetView addSubview:retweetphotosView];
    self.retweetphotosView = retweetphotosView;
    
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
    IconView *iconView = [[IconView alloc]init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView ;
    
    /** 会员图标*/
    UIImageView *vipView = [[UIImageView alloc]init];
    [self.originalView addSubview:vipView];
    self.vipView = vipView ;
    
    /** 微博配图*/
    StatusPhotosView *photosView = [[StatusPhotosView alloc]init];
    
    [self.originalView addSubview:photosView];
    self.photosView = photosView ;
    
    /** 昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = kStatusCellNameFont;
    [self.originalView addSubview:nameLabel];
    self.nameLabel = nameLabel ;
    
    /** 时间（微博发布时间）*/
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kStatusCellTimeFont ;
    timeLabel.textColor = [UIColor orangeColor];
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
 *  具体设置微博内容的Frame和 其他属性
 */
-(void)setBaseFrameModel:(BaseFrameModel *)baseFrameModel{
    _baseFrameModel = baseFrameModel ;
    
    StatusModel *statusModel = baseFrameModel.statusModel ;
    UserModel *userModel = statusModel.user;
    
    /**原创微博容器*/
    self.originalView.frame = baseFrameModel.originalViewF;
    
    /* 头像*/
    self.iconView.frame = baseFrameModel.iconViewF ;
    self.iconView.userModel = userModel ;
    
    
    /* 会员图标*/
    if(userModel.isVip){
        self.vipView.hidden =NO;
        self.vipView.frame = baseFrameModel.vipViewF ;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",userModel.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden =YES;
    }
    
    /* 微博配图*/
    if(statusModel.pic_urls.count){
        self.photosView.frame = baseFrameModel.photosViewF ;
        self.photosView.photos = statusModel.pic_urls;
        
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES ;
    }
    
    /* 昵称*/
    self.nameLabel.frame = baseFrameModel.nameLabelF;
    self.nameLabel.text = userModel.name ;
    
    
    /* 时间（微博发布时间）, 每次刷新的时候都要重新计算一下Frame,因为时间会变，宽度就会变 */
    NSString *time = statusModel.created_at ;
    CGFloat timeX =  baseFrameModel.nameLabelF.origin.x ;
    CGFloat timeY = CGRectGetMaxY(baseFrameModel.nameLabelF) + kStatusCellBorderWidth ;
    CGSize timeSize = [time sizeWithFont:kStatusCellTimeFont  ];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.text = time;
    
    /* 来源 ，需要每次刷新的时候计算是因为参照物是时间，时间会变*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kStatusCellBorderWidth;
    CGFloat sourceY = timeY ;
    CGSize  sourceSize = [statusModel.source sizeWithFont:kStatusCellTimeFont  ];
    self.sourceLabel.frame =CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    self.sourceLabel.text = statusModel.source ;
    
    
    
    /* 微博正文*/
    self.contenLabel.frame = baseFrameModel.contenLabelF;
    self.contenLabel.text = statusModel.text ;
    
    
    /**被转发的微博*/
    if(statusModel.retweeted_status){  //如果有转发
        StatusModel *retweeted_statusModel = statusModel.retweeted_status;
        UserModel *retweeted_status_userModel = retweeted_statusModel.user ;
        
        
        self.retweetView.hidden = NO;
        /*被转发微博的整体*/
        self.retweetView.frame = baseFrameModel.retweetViewF ;
        
        /*被转发微博的正文*/
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_userModel.name , retweeted_statusModel.text];
        self.retweetContentLabel.frame = baseFrameModel.retweetContentLabelF;
        self.retweetContentLabel.font = kStatusCellRetweetContentFont;
        self.retweetContentLabel.text = retweetContent;
        
        /*被转发微博的配图*/
        if(retweeted_statusModel.pic_urls.count){//如果转发微博有配图
            self.retweetphotosView.hidden = NO;
            self.retweetphotosView.frame = baseFrameModel.retweetPhotosViewF;
            self.retweetphotosView.photos = retweeted_statusModel.pic_urls;
            
            
        }else{ //没有配图
            self.retweetphotosView.hidden = YES;
        }
        
        
    }else{//如果没有转发微博
        self.retweetView.hidden = YES;
    }
    
//    
//    /**  工具条 */
//    self.toolbar.frame = baseFrameModel.toolBarF ;
//    self.toolbar.statusModel = baseFrameModel.statusModel;
    

}


/**
 *  重写setFrame方法，自己调整cell的Frame
 */



#warning todo 点击微博转发、评论 、点赞
//
//
//#pragma mark- toolBarDelegate 点击转发、评论、点赞
//-(void)toolBar:(ToolBar *)tooBar clickButton:(UIButton *)button{
//    if(button.tag == ToolBarButtonTypeAgree){
//
//
//    }
//    if(button.tag == ToolBarButtonTypeComment){
//
//    }
//    if(button.tag == ToolBarButtonTypeRetweet){
//          NSLog(@"转发");
//    }
//    
//}


@end




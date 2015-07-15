//
//  NearByStatusCell.m
//  MicroBlog
//
//  Created by lai on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "NearByStatusCell.h"

#import "IconView.h"
#import "StatusPhotosView.h"
#import "ToolBar.h"
#import "NearByStatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "AnnotationsModel.h"
#import "PlaceModel.h"

@interface NearByStatusCell ()


/**原创微博容器*/
@property (nonatomic , weak) UIView *originalView ;
/** 头像*/
@property (nonatomic , weak) IconView *iconView ;
/** 会员图标*/
@property (nonatomic , weak) UIImageView *vipView ;
/** 定位图标*/
@property (nonatomic , weak) UIImageView *locateView ;
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
/** 定位位置*/
@property (nonatomic , weak) UILabel *locateLabel ;
/** 距离多远 */
@property (nonatomic , weak) UILabel *distanceLabel ;
/** 工具条*/
@property (nonatomic , weak) ToolBar *toolbar;

@end



@implementation NearByStatusCell




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
    
    /** 定位图标*/
    UIImageView *locateView = [[UIImageView alloc]init ] ;
    [self.originalView addSubview:locateView];
    self.locateView = locateView ;
    
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
    
    /** 定位信息 */
    UILabel *locateLabel = [[UILabel alloc]init ] ;
    locateLabel.font =kStatusCellLocateFont;
    locateLabel.numberOfLines =0 ;
    [self.originalView addSubview:locateLabel];
    self.locateLabel = locateLabel ;
    
    UILabel *distanceLabel = [[UILabel alloc]init ] ;
    distanceLabel.font = kStatusCellLocateFont;
    distanceLabel.numberOfLines =0  ;
    [self.originalView addSubview:distanceLabel];
    self.distanceLabel = distanceLabel ;
}

/**
 *  具体设置微博内容的Frame和 其他属性
 */
-(void)setNearbyStatusFrameModel:(NearByStatusFrameModel *)nearbyStatusFrameModel{
    

    _nearbyStatusFrameModel = nearbyStatusFrameModel ;
    
    StatusModel *statusModel = nearbyStatusFrameModel.statusModel ;
    UserModel *userModel = statusModel.user;
    
    /**原创微博容器*/
    self.originalView.frame = nearbyStatusFrameModel.originalViewF;
    
    /* 头像*/
    self.iconView.frame = nearbyStatusFrameModel.iconViewF ;
    self.iconView.userModel = userModel ;
    
    
    /* 会员图标*/
    if(userModel.isVip){
        self.vipView.hidden =NO;
        self.vipView.frame = nearbyStatusFrameModel.vipViewF ;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",userModel.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden =YES;
    }
    

    /* 微博配图*/
    if(statusModel.pic_ids.count){
        
        // 图片拼接好再传进去
        NSMutableArray *photos = [NSMutableArray array];
        NSString  *headString  = @"http://ww1.sinaimg.cn/thumbnail/";
        NSString *tailSting = @".jpg";
        for(NSString *photoString in statusModel.pic_ids){
            NSString *newString = [NSString stringWithFormat:@"%@%@%@",headString,photoString ,tailSting];

            [photos addObject:newString];
        }
        
        self.photosView.frame = nearbyStatusFrameModel.photosViewF ;

        self.photosView.photoStrings = photos;
        
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES ;
    }
    
    AnnotationsModel *annotationsModel = statusModel.annotations[0] ;
    PlaceModel *placeModel = annotationsModel.place ;
    if(placeModel.title){ //如果有位置信息
        
        self.locateView.frame = nearbyStatusFrameModel.locateViewF ;
        self.locateView.image = [UIImage imageNamed:@"activity_card_locate"];
        self.locateView.hidden =NO ;
        
        self.locateLabel.frame = nearbyStatusFrameModel.locationLabelF ;
        self.locateLabel.text = placeModel.title ;
        self.locateLabel.hidden =NO ;
        
        NSString *distanceString ;
        if(statusModel.distance >=1000){
            distanceString = [NSString stringWithFormat:@"%.1f公里",statusModel.distance/1000.0];
        }else{
            distanceString = [NSString stringWithFormat:@"%d米",statusModel.distance];
        }
        self.distanceLabel.frame = nearbyStatusFrameModel.distanLabelF ;
        self.distanceLabel.text = [NSString stringWithFormat:@"(距离%@)",distanceString];
        self.distanceLabel.hidden =NO;
        
        
    }else{
        self.locateView.hidden = YES ;
        self.locateLabel.hidden = YES ;
        self.distanceLabel.hidden = YES; 
    }
    
    
    /* 昵称*/
    self.nameLabel.frame = nearbyStatusFrameModel.nameLabelF;
    self.nameLabel.text = userModel.name ;
    
    
    /* 时间（微博发布时间）, 每次刷新的时候都要重新计算一下Frame,因为时间会变，宽度就会变 */
    NSString *time = statusModel.created_at ;
    CGFloat timeX =  nearbyStatusFrameModel.nameLabelF.origin.x ;
    CGFloat timeY = CGRectGetMaxY(nearbyStatusFrameModel.nameLabelF) + kStatusCellBorderWidth/2 ;
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
    self.contenLabel.frame = nearbyStatusFrameModel.contenLabelF;
    self.contenLabel.text = statusModel.text ;
    
    
    /**  工具条 */
    self.toolbar.frame = nearbyStatusFrameModel.toolBarF ;
    self.toolbar.statusModel = nearbyStatusFrameModel.statusModel;
    
    
}







@end

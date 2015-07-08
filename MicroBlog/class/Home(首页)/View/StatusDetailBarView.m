//
//  StatusDetailBarView.m
//  MicroBlog
//
//  Created by lai on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  微博详情页中  评论部分的顶部

#import "StatusDetailBarView.h"
#import "StatusModel.h"
#define  kStatusDetailWidth 80   //微博详情页中，评论部分的头部Label宽度（转发 评论 赞）
@interface StatusDetailBarView ()

@property (nonatomic , strong) UILabel *labelRetweet ;
@property (nonatomic , strong) UILabel *labelComment ;
@property (nonatomic , strong) UILabel *labelAttitudes ;

@end

@implementation StatusDetailBarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        
        /**转发*/
        UILabel *labelRetweet = [[UILabel alloc]init];
        labelRetweet.textAlignment = NSTextAlignmentCenter;
        labelRetweet.font = [UIFont systemFontOfSize:14];
        labelRetweet.x = 2 ;
        labelRetweet.y =0 ;
        labelRetweet.width =kStatusDetailWidth;
        labelRetweet.height =36;
        self.labelRetweet = labelRetweet ;
        [self addSubview:labelRetweet];
        
        
        /**评论*/
        UILabel *labelComment = [[UILabel alloc]init];
        labelComment.textAlignment = NSTextAlignmentCenter;
        labelComment.font = [UIFont systemFontOfSize:14];
        labelComment.x = CGRectGetMaxX(labelRetweet.frame) +10;
        labelComment.y =0 ;
        labelComment.width =kStatusDetailWidth;
        labelComment.height =36;
        self.labelComment = labelComment;
        [self addSubview:labelComment];
        
        
        /**点赞*/
        UILabel *labelAttitudes = [[UILabel alloc]init];
        labelAttitudes.font = [UIFont systemFontOfSize:14];
        labelAttitudes.textAlignment = NSTextAlignmentCenter ;
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        labelAttitudes.x = window.width - kStatusDetailWidth ;
        labelAttitudes.y =0 ;
        labelAttitudes.width =kStatusDetailWidth;
        labelAttitudes.height =36;
        self.labelAttitudes =labelAttitudes;
        [self addSubview:labelAttitudes];
  
        
    }
    return self;
}


-(void)setStatsModel:(StatusModel *)statsModel{
    _statsModel = statsModel ;
    
    int repostCount =statsModel.reposts_count ;
    if(repostCount != 0){
        if(repostCount >= 10000 ){
            double  wan = repostCount/10000.0  ;
            NSString *title = [NSString stringWithFormat:@"转发%.1f万",wan] ;
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        self.labelRetweet.text = title;
        
        }else{
          self.labelRetweet.text = [NSString stringWithFormat:@"转发 %d",statsModel.reposts_count];
        }
    }else{
        self.labelRetweet.text = @"转发";
    }
    
    
    int commentCount =statsModel.comments_count ;
    if(commentCount != 0){
        if(commentCount >= 10000 ){
            double  wan = commentCount/10000.0  ;
            NSString *title = [NSString stringWithFormat:@"评论%.1f万",wan] ;
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            self.labelComment.text = title;
            
        }else{
            self.labelComment.text = [NSString stringWithFormat:@"转发 %d",statsModel.comments_count ];
        }
    }else{
        self.labelComment.text = @"评论";
    }
    
    
    
    int attitudesCount =statsModel.attitudes_count ;
    if(attitudesCount != 0){
        if(attitudesCount >= 10000 ){
            double  wan = attitudesCount/10000.0  ;
            NSString *title = [NSString stringWithFormat:@"赞%.1f万",wan] ;
            //例如：  22.0万这种情况，直接去掉 .0
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            self.labelAttitudes.text = title;
            
        }else{
            self.labelAttitudes.text = [NSString stringWithFormat:@"赞 %d",statsModel.attitudes_count];
            
        }
    }else{
        self.labelAttitudes.text = @"赞";
    }




}






@end

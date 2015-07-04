//
//  IconView.m
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "IconView.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"


@interface IconView ()
@property (nonatomic , weak) UIImageView *verfiedView ;
@end

@implementation IconView





-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}


-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel ;
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    if(userModel.verified){ //如果是加V用户
        self.verfiedView.hidden =NO;
        self.verfiedView.image = [UIImage imageNamed:@"avatar_vip"];
    }else{
        self.verfiedView.hidden =YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    //设置加v标志的frame
    self.verfiedView.size = self.verfiedView.image.size;
    self.verfiedView.x = self.width-self.verfiedView.width*0.6;
    self.verfiedView.y = self.height - self.verfiedView.height*0.6;
    
}

//懒加载
-(UIImageView *)verfiedView{
   if(!_verfiedView){
       UIImageView *vefiedView = [[UIImageView alloc]init];
       [self addSubview:vefiedView];
       self.verfiedView = vefiedView;
    }
    return  _verfiedView;
}


@end

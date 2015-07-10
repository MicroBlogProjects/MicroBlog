//
//  ProfileIconView.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ProfileIconView.h"
#import "UIImageView+WebCache.h"

@interface ProfileIconView ()
@property (nonatomic , weak) UIImageView *verfiedView ;
@end

@implementation ProfileIconView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
}
//下载图片
-(void)getView:(ProfileUserModel *)userModel{
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    if(userModel.verified){ //如果是加V用户
        self.verfiedView.hidden =NO;
        self.verfiedView.image = [UIImage imageNamed:@"avatar_vip"];
    }else{
        self.verfiedView.hidden =YES;
    }
}
/**
 *  //设置加v标志的frame
 */
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

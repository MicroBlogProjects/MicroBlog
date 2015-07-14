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
#import "AccountTool.h"
#import "PhotoModel.h"
#import "ToolBar.h"
#import "StatusPhotosView.h"
#import "IconView.h"
#import "NavigationController.h"
#import "ZZActionSheet.h"
#import "MainTabbarViewController.h"
#import "NavigationController.h"
#import "StatusDetailViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "CommentViewController.h"
@interface StatusCell ()  <ZZActionSheetDelegate  >

@property (nonatomic , strong) ToolBar *toolbar;


@end
@implementation StatusCell


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
       //与baseCell不一样的东西在这里设置
        [self addOtherObject];
        
        /* 为转发部分设置手势 */
        self.retweetView.userInteractionEnabled = YES ;
        [self.retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retweetClick) ]];
    }
    return self ;
}


/** 点击转发微博，页面跳转到转发微博的详情页 */
-(void)retweetClick{
    NavigationController *nav = (NavigationController *)[MainTabbarViewController sharedMainTabbarViewController].selectedViewController;
    StatusDetailViewController *detail = [[StatusDetailViewController alloc]init ] ;
    detail.statusModel = self.baseFrameModel.statusModel.retweeted_status;
    [nav pushViewController:detail  animated:YES];
}



#pragma mark- 点击更多按钮

/** 与baseCell不一样东西在这里设置*/
-(void)addOtherObject{
    
    //1、更多
    CGFloat btnWidth = 40 ;
    CGFloat btnHeight = 40l ;
    CGFloat btnX = self.frame.size.width - btnWidth ;
    CGFloat btnY = 0 ;
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    [more addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchDown];
    more.frame  = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self.contentView addSubview:more];
    
    
}

/** 点击微博右上角的下标按钮触发 */
-(void)clickMore{
    
    NSString *collectSting ;
    if(self.baseFrameModel.statusModel.favorited){
        collectSting = @"取消收藏";
    }else{
        collectSting = @"收藏";
    }
    
    ZZActionSheet *actionSheet = [[ZZActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[collectSting,@"帮上头条",@"取消关注",@"屏蔽",@"举报"]];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow ];
}

/**  ActionSheet 点击事件 */
-(void)ZZActionSheet:(ZZActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self collection];
            break;
        case 1:
            [self showMessage:@"API接口限制无法实现"];
            break;
        case 2:
            [self showMessage:@"API接口限制无法实现"];
            break;
        case 3:
            [self showMessage:@"API接口限制无法实现"];
            break;
        case 4:
            [self showMessage:@"API接口限制无法实现"];
            break;
            
            
        default:
            break;
    }
    
}

/** 收藏 */
-(void)collection{
    

    if(!self.baseFrameModel.statusModel.favorited){  //还未收藏，现在要收藏
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AccountModel *account  = [AccountTool account];
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token ;
    params[@"id"] = self.baseFrameModel.statusModel.idstr;
    [manager POST:@"https://api.weibo.com/2/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [MBProgressHUD showSuccess:@"收藏成功" toView:[UIApplication sharedApplication].keyWindow ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        //修改收藏状态
        self.baseFrameModel.statusModel.favorited = !self.baseFrameModel.statusModel.favorited ;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"收藏失败" toView:[UIApplication sharedApplication].keyWindow ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
    }else{ /* 已经收藏，现在要取消收藏 */
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AccountModel *account  = [AccountTool account];
        NSMutableDictionary *params= [NSMutableDictionary dictionary];
        params[@"access_token"] = account.access_token ;
        params[@"id"] = self.baseFrameModel.statusModel.idstr;
        [manager POST:@"https://api.weibo.com/2/favorites/destroy.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            [MBProgressHUD showSuccess:@"删除收藏成功" toView:[UIApplication sharedApplication].keyWindow ];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
            //修改收藏状态
            self.baseFrameModel.statusModel.favorited = !self.baseFrameModel.statusModel.favorited ;
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [MBProgressHUD showError:@"删除收藏失败" toView:[UIApplication sharedApplication].keyWindow ];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }];
    }
    
}

-(void)showMessage:(NSString *)message{
    [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow ];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
    });
}




#pragma mark  高亮设置


/**  覆盖高亮显示方法  */
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    // 调用super是为了让cell保持高亮状态
    [super setHighlighted:highlighted animated:animated];
    if(highlighted){
        [self unHighlightSubviews:self.contentView];
    }
}


- (void)unHighlightSubviews:(UIView *)parent
{
    NSArray *views = parent.subviews;
    for (UIButton *child in views) {
        if ([child respondsToSelector:@selector(setHighlighted:)]) {
            child.highlighted = NO;
        }
        [self unHighlightSubviews:child];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
     // 调用super是为了让cell保持高亮状态
    [super setSelected:selected animated:animated];
    if(selected){
        [self unHighlightSubviews:self.contentView];
    }
}



/**
 *  具体设置微博内容的Frame和其他属性
 */
-(void)setBaseFrameModel:(BaseFrameModel *)baseFrameModel{

    [super setBaseFrameModel:baseFrameModel];

    
    /**  工具条 */
    _toolbar.frame = baseFrameModel.toolBarF ;
    _toolbar.statusModel = baseFrameModel.statusModel ;
    [self.contentView addSubview:_toolbar];
    
}


 



@end








































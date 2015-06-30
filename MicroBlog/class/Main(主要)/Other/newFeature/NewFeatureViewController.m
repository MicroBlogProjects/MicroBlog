//
//  NewFeatureViewController.m
//  MicroBlog
//  第一次使用APP时展示的新版本特性
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#define kNewFeaturePictureCount 4
#import "MainTabbarViewController.h"
#import "NewFeatureViewController.h"

@interface NewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic ,weak) UIPageControl *pageControl ;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init] ;
    scrollView.frame = self.view.bounds ;
   [self.view addSubview:scrollView];
    
    //添加图片到scrollView中去
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.heigt;
    for(int i =0 ; i<kNewFeaturePictureCount ; i++){
        UIImageView *imageView  = [[ UIImageView alloc]init] ;
        imageView.width = scrollW ;
        imageView.heigt = scrollH;
        imageView.y = 0 ;
        imageView.x = i*imageView.width ;
        NSString *name  = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        //如果是最后一个imageView ， 就往里面添加其他内容（比如进入微博的按钮）
        if(i==kNewFeaturePictureCount -1){
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    //设置scrollView的一些属性
    scrollView.bounces = NO;
    scrollView.pagingEnabled =YES ;
    scrollView.showsHorizontalScrollIndicator  = NO;
    scrollView.contentSize = CGSizeMake(kNewFeaturePictureCount*scrollView.width, 0);
    scrollView.delegate =self;
    
    //设置pageControl的一些属性
    UIPageControl *pageControl = [[UIPageControl alloc]init] ;
    pageControl.numberOfPages = kNewFeaturePictureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.centerX = scrollW * 0.5;
    pageControl.y = scrollH -50 ;
    self.pageControl = pageControl ;
    
    [self.view addSubview:pageControl];
    
}

/**
 *  功能：让scrollView和pageControl同步
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当页面的一半划出时，四舍五入，pageConrol的页数就进一位
    double pageNumber = scrollView.contentOffset.x/self.view.width  + 0.5 ;
    self.pageControl.currentPage = (int)pageNumber  ;
}


/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
-(void)setupLastImageView :(UIImageView *)imageView{
    
   //1.分享给大家
    UIButton *shareButton = [[UIButton alloc]init ] ;
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState: UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    shareButton.width = 120;
    shareButton.heigt = 35  ;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.heigt * 0.65;
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0); //图片和文字距离10
    [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
    
    //2.开始微博
    UIButton *startButton = [[UIButton alloc]init] ;
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted ];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = shareButton.centerX ;
    startButton.centerY = imageView.heigt * 0.75 ;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
}
/**
 *  点击分享
 *
 *  @param button 分享按钮
 */
-(void)shareClick:(UIButton *)button{
    button.selected =! button.selected ;
}
/**
 *  点击开始微博
 */
-(void)startClick{
    UIWindow *window = [UIApplication sharedApplication ].keyWindow ;
    window.rootViewController = [[MainTabbarViewController alloc]init];
}

@end

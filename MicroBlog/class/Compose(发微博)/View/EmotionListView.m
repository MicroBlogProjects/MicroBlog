//
//  EmotionListView.m
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EmotionListView.h"
#import "EmotionPageView.h"
#define EmotionPageSize 20
@interface EmotionListView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@end
@implementation EmotionListView
-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self) {
        //1 UIScollView
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        [self addSubview:scrollView];
        self.scrollView=scrollView;
        self.scrollView.pagingEnabled=YES;
        self.scrollView.delegate=self;
        //2 pageControl
        UIPageControl *pageControl =[[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        pageControl.backgroundColor=[UIColor whiteColor];
        [self addSubview:pageControl];
        self.pageControl=pageControl;
        pageControl.hidesForSinglePage=YES;
        pageControl.userInteractionEnabled=NO;
    }
    return self;
}
-(void)setEmotions:(NSArray *)emotions {
    _emotions =emotions;
    //删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //设置页数
    NSUInteger count = (emotions.count-1+EmotionPageSize )/EmotionPageSize;
//    CGFloat screenW= [UIScreen mainScreen].bounds.size.width;
    self.pageControl.numberOfPages=count;
    //2 创建用来显示每一页表情的容器
    NSUInteger numofemotions=emotions.count;
    for(int i=0; i<count; i++){
        EmotionPageView    *pageView=[[EmotionPageView alloc] init];
        pageView.backgroundColor=[UIColor whiteColor];
        //计算这一页的表情范围
        NSRange range;
        range.location=i*EmotionPageSize;
        range.length=MIN(EmotionPageSize,numofemotions-range.location);
        //设置这一页的表情
        pageView.emotions=[emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    // 3.设置scrollview的contentSize
//    self.scrollView.contentSize=CGSizeMake(count*screenW, 0);
    //去除水平垂直方向滚动条
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    [self setNeedsLayout];
}
-(void)layoutSubviews {
    [super layoutSubviews];

    //1 pageControl
   
    self.pageControl.width =self.width;
    self.pageControl.height=35;
    self.pageControl.x=0;
    self.pageControl.y=self.height-self.pageControl.height;
    
    //2.scrollView
    
    self.scrollView.width=self.width;
    self.scrollView.height=self.pageControl.y;
    self.scrollView.x=self.scrollView.y=0;
   
   
    //3设置scrollView内部每一页的尺寸
   
    NSUInteger count =self.scrollView.subviews.count;
    for(int i=0; i<count; i++){
        EmotionPageView *pageView=self.scrollView.subviews[i];
        pageView.width =self.scrollView.width;
        pageView.height=self.scrollView.height;
        pageView.x=pageView.width*i;
        pageView.y=0;
    }
    //4设置scrollView的conttentSize
    self.scrollView.contentSize=CGSizeMake(count*self.scrollView.width, 0);
}
#pragma mark -测试
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNo =scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(pageNo +0.5);
}

@end

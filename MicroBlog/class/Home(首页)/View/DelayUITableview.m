//
//  DelayUITableview.m
//  MicroBlog
//
//  Created by lai on 15/7/12.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//  功能：解决在UITableView的Cell中  按钮快速点击没有高亮的问题

#import "DelayUITableview.h"


@implementation DelayUITableview


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        // iterate over all the UITableView's subviews
        for (id view in self.subviews)
        {
             self.delaysContentTouches = NO;
            // looking for a UITableViewWrapperView
            if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"])
            {
                // this test is necessary for safety and because a "UITableViewWrapperView" is NOT a UIScrollView in iOS7
                if([view isKindOfClass:[UIScrollView class]])
                {
                    // turn OFF delaysContentTouches in the hidden subview
                    UIScrollView *scroll = (UIScrollView *) view;
                    scroll.delaysContentTouches = NO;
                }
                break;
            }
        }
    }
return self;

}



- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
return YES;
}

@end

//
//  ComposeViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/4.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "ComposeViewController.h"

@implementation ComposeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendCompose)];
 
}

-(void)sendCompose{
    
}

/**
 *  点击取消按钮 动作：退出当前控制器
 */
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

//
//  WebViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/15.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
}

-(void)setURLString:(NSString *)URLString{
    _URLString = URLString ;
    
    UIWebView *webView = [[UIWebView alloc]init] ;
    webView.frame = self.view.bounds ;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    
}

-(void)cancelClick {

    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
    
}


@end

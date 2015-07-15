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
//    创建一个webView
    UIWebView *webView = [[UIWebView alloc]init] ;
    webView.frame = self.view.bounds ;
    
    [self.view addSubview:webView];
    
    
    //用webView加载登录页面(新浪提供的)
    //请求地址：https://api.weibo.com/oauth2/authorize
    /*
     请求参数
     client_id	 	申请应用时分配的AppKey。 304647707
     redirect_uri	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

-(void)setURLString:(NSString *)URLString{
    
    _URLString = URLString ;
    
    //创建一个webView
    UIWebView *webView = [[UIWebView alloc]init] ;
    webView.frame = self.view.bounds ;
    
    [self.view addSubview:webView];
    
    
    //用webView加载登录页面(新浪提供的)
    //请求地址：https://api.weibo.com/oauth2/authorize
    /*
     请求参数
     client_id	 	申请应用时分配的AppKey。 304647707
     redirect_uri	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    
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

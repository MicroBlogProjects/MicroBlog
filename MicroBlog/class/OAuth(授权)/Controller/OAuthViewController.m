//
//  OAuthViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "OAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h" 
#import "AccountModel.h"
#import "AccountTool.h"
@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个webView
    UIWebView *webView = [[UIWebView alloc]init] ;
    webView.frame = self.view.bounds ;
    webView.delegate =self;
    [self.view addSubview:webView];
    
    //用webView加载登录页面(新浪提供的)
    //请求地址：https://api.weibo.com/oauth2/authorize
    /*
      请求参数
     client_id	 	申请应用时分配的AppKey。 304647707
     redirect_uri	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=304647707&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}



/**
 *  利用code换取accessToken , 获取accessToken后存入沙盒中以供以后使用
 *
 *  @param code = 授权成功后的request token
 */
-(void)accessTokenWithCode:(NSString *)code{
 
/*进行POST操作*/
    //1.请求管理者
    AFHTTPRequestOperationManager *manager  = [AFHTTPRequestOperationManager  manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = @"304647707" ;
    params[@"client_secret"] = @"533cfea336e04f236c469931f5d40a7c";
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code ;
    params[@"redirect_uri"]  = @"http://";
    //3.发送请求;
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject){
        
         [MBProgressHUD hideHUD];
         //将返回的账号字典数据转化成模型
         AccountModel *account = [AccountModel accountWitDict:responseObject];
         //存储账号信息
         [AccountTool saveAccount:account];
         //切换窗口控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
         [window switchRootViewController];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
         /*页面授权失败的操作*/
    }];
}



#pragma mark - webViewDelegate实现

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // 获得URL
    NSString *url = request.URL.absoluteString ;
    // http://www.baidu.com/?code=b251e69a5359e82aecdf0f83ec402993
    //判断是否为回调地址
    NSRange range =  [url rangeOfString:@"code="];
    if(range.length!=0) { //是回调地址
        unsigned long fromIndex = range.location + range.length ;
        NSString *code = [url substringFromIndex:fromIndex];
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return  NO;
    }
    return  YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
@end



























































































































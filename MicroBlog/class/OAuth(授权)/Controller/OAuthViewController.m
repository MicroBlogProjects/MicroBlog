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

    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=942446141&redirect_uri=http://"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

/*
 测试账号 18905914304 密码 a6352598
 App Key：591317646
 App Secret：841b33bb8451a1e2b041d46d09776558
 
 
 
 赖伟煌的迷你微博
 ?access_token=2.004nnkxBNS6mBB72a37612fdviOKvD&uid=1799091161
 access_token=2.004nnkxBNS6mBB72a37612fdviOKvD
 uid=1799091161
 App Key：304647707
 App Secret：533cfea336e04f236c469931f5d40a7c
 
 
 迷你微博应用
 access_token=2.004nnkxB0hmQc1ca9521a831L5MZsB
 uid=1799091161d
 App key : 942446141
 App Secret : 387ea016d0c2baa3fb73ca00ac3ec049
 
 //陈嘉
 App Key：2713979731
 App Secret：fd88b5cf58d8ee23a90c76cf9f50f37f
 
 
 迷你微博测试版1
 App Key：3911897486
 App Secret：7e0c8ab5272a96dcdb65cf83036304b0
 
 
 迷你微博测试版2
 access_token=2.004nnkxBhxH_LD465cd88e98gTvHSB
 uid=1799091161
 App Key：2915497033
 App Secret：84c8eda8fb9be1b8429cd9287a6fc398
 
 App Key：
 1589673142
 
 App Secret：
 5ea2a3deb5f39a16215ffc6ebf4fcfeb
 */

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

    params[@"client_id"]     = @"942446141" ;
    params[@"client_secret"] = @"387ea016d0c2baa3fb73ca00ac3ec049";

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



























































































































//
//  AppDelegate.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarViewController.h"
#import "NewFeatureViewController.h"
#import "OAuthViewController.h"
#import "AccountModel.h"
#import "AccountTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //1.创建窗口
    self.window = [[UIWindow alloc]init ];
    self.window.frame = [[UIScreen mainScreen] bounds];
    
    //2.显示窗口
    [self.window makeKeyAndVisible];
    
    //3.设置根控制器
    AccountModel *account = [AccountTool account];
    
    if(account){  //之前已经登录过，
        [self.window switchRootViewController];   //跳转页面(一般是跳转到主页面，如果软件更新版本，则进入新特性介绍页面)
    }
    else{ //没有登录过,进入登陆授权页面
        self.window.rootViewController = [[OAuthViewController alloc]init];
    }

    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state  information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  UIWindow+Extention.m
//  MicroBlog
//
//  Created by lai on 15/6/29.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "UIWindow+Extention.h"
#import "MainTabbarViewController.h"
#import "NewFeatureViewController.h"

@implementation UIWindow (Extention)

-(void)switchRootViewController{
    
     //从沙盒中获取上次运行的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CFBundleVersion" ] ;
    
     //获取info.plist文件的内容
    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary ;
     //获取当前运行的版本号
    NSString *currentVersion =  dict[@"CFBundleVersion"];
    
    
    if([currentVersion isEqualToString:lastVersion]){ //如果版本没有更新,进入主界面
        self.rootViewController = [[MainTabbarViewController alloc]init];
    }else{//如果版本更新，进入新特性界面
        self.rootViewController = [[NewFeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults]synchronize]; //马上进行同步,这样才会马上写入沙盒中
    }
    
    
    
    
    //想要在桌面图标显示未读消息数字，在ios8.0系统之后都要 先获得用户允许才能实现
    float sysVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if(sysVersion>=8.0){
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    //如果不实现上面方法，则会报错：Attempting to badge the application icon but haven't received permission from the user to badge the application
    
    
}

@end

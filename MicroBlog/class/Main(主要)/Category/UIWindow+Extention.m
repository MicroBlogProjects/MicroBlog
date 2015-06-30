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
    
    
}

@end

//
//  MainTabbarViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "HomeViewController.h"
#import "NavigationController.h"
#import "TabBar.h"
#import "MBProgressHUD+MJ.h"
@interface MainTabbarViewController () <TabBarDelegate>

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    HomeViewController *home = [[HomeViewController alloc ]init];
    [self addChildVC:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MessageViewController *message  = [[MessageViewController alloc]init];
    [self addChildVC:message Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc ]init ] ;
    [self addChildVC:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addChildVC:profile Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //把tabBarViewController 自带的tabBar(就是下方工具条) 换成 自定义的tabBar(为了添加那个“+”按钮)
    //由于tabBar属性是只读的，不能用self.tabBar进行直接赋值，要用KVC进行赋值
    TabBar *tabBar = [[TabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}



/**
 *  添加一个子控制器 （底部的Tabbar,首页，消息，发现，我）
 *
 *  @param childVC       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
-(void)addChildVC:(UITableViewController *)childVC Title:(NSString *)title  image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    
//    childVC.view.backgroundColor = myRandomColor; 
//   childVC.tabBarItem.title  = title ;
//   childVC.navigationItem.title = title;
//   下面的语句等价于上面两句（同时设置tabBarItem和navigationItem）
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //设置不要让系统自动渲染图片，只使用原片原有的样子（因为系统会默认渲染选中状态的图片），这是 IOS7之后使用的技术
    childVC.tabBarItem.selectedImage  = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = myColor(123, 123, 123);
    NSMutableDictionary *selectedTextAttribute = [NSMutableDictionary dictionary];
    selectedTextAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttribute forState:UIControlStateSelected];
    
    //给外面传进来的小控制器 包装 一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
}


#pragma mark - TabBarDelegate代理方法

#warning 这是要实现点击“+”按钮后跳出View  ，实现发微博的功能
-(void)tabBarClickPlusButton:(TabBar *)tabBar{
    
    
    [MBProgressHUD showSuccess:@"发微博功能块，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
//    UIViewController *vc = [[UIViewController alloc]init] ;
//    vc.view.backgroundColor  = [UIColor redColor];
//    [self presentViewController:vc animated:YES completion:nil];

}

@end

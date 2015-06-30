//
//  HomeViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+DIYButton.h"
#import "MBProgressHUD+MJ.h"
#import "DropDownMenu.h"
#import "MenuTableViewController.h"
@interface HomeViewController () <DropDownMenuDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //左上角按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" highLightImageName:@"navigationbar_friendsearch_highlighted"];
    //右上角按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) imageName:@"navigationbar_pop" highLightImageName:@"navigationbar_pop_highlighted"];
  
    //中间的标题栏按钮
    UIButton *titleButton = [[UIButton alloc]init];
    titleButton.width = 150 ;
    titleButton.heigt =30 ;
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton ;
    
}
 
/**
 *  点击标题
 */
-(void)titleClick:(UIButton *)titleButton{
    
    //创建下拉菜单
    DropDownMenu *menu = [DropDownMenu menu];
    //设置下拉菜单的内容
    MenuTableViewController *menuTable = [[MenuTableViewController alloc]init];
    menuTable.view.heigt =44*3 ;
    menuTable.view.width =217 ;
    menu.contentController =  menuTable ;
    menu.delegate = self ;
    //显示
    [menu showFrom:titleButton];
    //让箭头向上
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
}



/**
 *  点击左上角按钮
 */
-(void)pop{
    [MBProgressHUD showMessage:@"扫码功能，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    NSLog(@"pop");
    
}
/**
 *  点击右上角按钮
 */
-(void) friendSearch{
    [MBProgressHUD showMessage:@"添加好友，施工中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    
    NSLog(@"friendSearch");
}


#pragma mark - dropDownMenuDelegate代理实现
/**
 *  下拉菜单被销毁时触发，箭头方向向下
 *
 *  @param menu 下拉菜单
 */
-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu{
    UIButton *titleButton  = (UIButton*)self.navigationItem.titleView ;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}








@end

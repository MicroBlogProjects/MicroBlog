//
//  MenuTableViewController.m
//  MicroBlog
//  首页下拉菜单的视图控制器
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"好友";
            break;
        case 1:
            cell.textLabel.text = @"密友";
            break;
        case 2:
            cell.textLabel.text = @"全部";
            break;
        default:
            break;
    }
    
    return  cell;
}

@end
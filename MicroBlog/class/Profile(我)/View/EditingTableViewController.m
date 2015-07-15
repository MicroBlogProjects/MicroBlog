//
//  EditingTableViewController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "EditingTableViewController.h"

@interface EditingTableViewController ()

@end

@implementation EditingTableViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"设置";
    [super viewDidLoad];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"账号管理";
    }
    else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"通知";
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"隐私与安全";
        }
        else{
            cell.textLabel.text = @"通用设计";
        }
    }
    else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清理缓冲";
        }
        else if(indexPath.row == 1){
            cell.textLabel.text = @"意见反馈";
        }
        else{
            cell.textLabel.text = @"关于微博";
        }
    }
    else {
        cell.textLabel.text = @"退出当前账号";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
/** 以下两个函数功能：使Cell中添加图片不会导致分割线被裁减一部分 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end

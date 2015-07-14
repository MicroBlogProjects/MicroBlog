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
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.rowHeight = 44 ;

  
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if(indexPath.row == 0){
        if(self.homeTitleClickBlock){
            self.homeTitleClickBlock(@"好友");
        }
    }
    if(indexPath.row ==1){
        if(self.homeTitleClickBlock){
            self.homeTitleClickBlock(@"我的微博");
        }
    }
    if(indexPath.row ==2 ){
        if(self.homeTitleClickBlock){
            self.homeTitleClickBlock(@"周边的微博");
        }
    
    
    
    }
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
            cell.textLabel.text = @"我的微博";
            break;
        case 2:
            cell.textLabel.text = @"周边的微博";
            break;
        default:
            break;
    }

    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];



    return  cell;
}

@end
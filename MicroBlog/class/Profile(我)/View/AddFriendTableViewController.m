//
//  AddFriendTableViewController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/7.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "AddFriendTableViewController.h"
#import "SearchBar.h"

@interface AddFriendTableViewController ()

@end

@implementation AddFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /* 创建搜索框 */
    //创建搜索框对象(这是我自定义的工具)
    
    CGRect fram = [[UIScreen mainScreen]bounds];
    CGFloat  w = fram.size.width;
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.frame = CGRectMake(10, 10, w - 20, 35);
    self.navigationItem.title = @"添加好友";
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"like"];
        cell.textLabel.text = @"当前加好友";
        cell.detailTextLabel.text = @"添加身边的好友";
    }
    else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"like"];
        cell.textLabel.text = @"扫一扫";
        cell.detailTextLabel.text = @"扫描二维码名片";
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"new_friend"];
        cell.textLabel.text = @"通讯录好友";
        cell.detailTextLabel.text = @"添加或者邀请通讯录好友";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

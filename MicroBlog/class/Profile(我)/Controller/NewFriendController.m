//
//  NewFriendController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/14.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "NewFriendController.h"
#import "ProfileFansController.h"

@interface NewFriendController ()<UITableViewDelegate>

@end

@implementation NewFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新的好友";
    self.tableView.backgroundColor = myColor(245, 245, 245);
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

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"new_friend"];
    cell.textLabel.font = kStatusCellNameFont;
    cell.textLabel.text = @"查看所有粉丝";
    cell.detailTextLabel.font = kStatusCelldescriptionFont;
    cell.detailTextLabel.text = @"暂时没有新的粉丝";
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *tempView = [[UIView alloc] init] ;
    [cell setBackgroundView:tempView];
    cell.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 25.0f;
}
//点击cell函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ProfileFansController * fansController = [[ProfileFansController alloc]init];
        [self.navigationController pushViewController:fansController animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * headerLabel = [[UILabel alloc]init];
    headerLabel.font = kStatusCelldescriptionFont;
    headerLabel.size = [headerLabel.text sizeWithFont:kStatusCelldescriptionFont];
    headerLabel.text = @"新粉丝";
    headerLabel.backgroundColor = myColor(245, 245, 245);
    return headerLabel;
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

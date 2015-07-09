//
//  PersonalInformationViewController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonInformationViewCell.h"
#import "ProfileUserModel.h"
#import "ProfileToolButtonCell.h"
#import "DIYSegmentViewController.h"

@interface PersonalInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) ProfileUserModel* userModel;

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = myColor(239, 239, 239);
    //代理传值 从上个界面将需要的值传递到这个界面
    self.userModel = [self.personInfoDelegate passValue];
    NSLog(@"%@",_userModel.avatar_large);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if(section != 2)
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        static NSString * ID = @"PersonInfoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[PersonInformationViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andPersonInfo:self.userModel];
            UIView *tempView = [[UIView alloc] init] ;
            [cell setBackgroundView:tempView];
            cell.backgroundColor = [UIColor clearColor];
            tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else if (indexPath.section ==1)
    {
        static NSString * ID = @"ProfileToolButtonCell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ProfileToolButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//            [(ProfileToolButtonCell *)cell setCell:self.segmentView];
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.userModel.cellHight;
    }
    else if (indexPath.section ==1){
        return [[UIScreen mainScreen]bounds].size.height / 12;
    }
    return 100.0;
}





@end

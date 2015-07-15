

//
//  MessageViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "MessageViewController.h"

#import "MessageModel.h"
#import "AtMeTableViewController.h"
#import "CommentTableViewController.h"
#define cellinsertdist 5
@interface MessageViewController ()
@property (nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation MessageViewController
-(NSMutableArray *)messageArray {
    if (_messageArray==nil) {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Message.plist" ofType:nil];
        _messageArray = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _messageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 去掉多余格式的线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(writeMessage)];
}
/**
 *  点击"写私信"按钮时调用该方法
 */
-(void)writeMessage{
    NSLog(@"%s",__func__);
}

-(void)viewWillAppear:(BOOL)animated{
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96/2+14;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    static NSString *ID = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MessageModel *message=[MessageModel messageModelbuild:self.messageArray[row]];
    cell.imageView.image=[UIImage imageNamed:message.png];
    cell.textLabel.text=message.title;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        AtMeTableViewController *atMetable=[[AtMeTableViewController alloc]init];
        [self.navigationController pushViewController:atMetable animated:YES];
    }else if(indexPath.row==1){
        CommentTableViewController *comment=[[CommentTableViewController alloc] init];
        [self.navigationController pushViewController:comment animated:YES];
    }
//    TestViewController *test = [[TestViewController alloc]init] ;
//    test.title = [NSString stringWithFormat:@"%lu",indexPath.row];
//    [self.navigationController pushViewController:test animated:YES];
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

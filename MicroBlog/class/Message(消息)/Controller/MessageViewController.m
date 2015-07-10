

//
//  MessageViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "MessageViewController.h"
#import "TestViewController.h"
#import "MessageModel.h"
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"test_message_%d",indexPath.row];
    return  cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestViewController *test = [[TestViewController alloc]init] ;
    test.title = @"测试页面1";
    [self.navigationController pushViewController:test animated:YES];
}


@end

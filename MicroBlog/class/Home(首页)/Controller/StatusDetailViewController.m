//
//  StatusDetailViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
// 查看微博详情页面

#define kOptionHeight 44
#define kTitleViewHeiht 50

#import "StatusDetailViewController.h"
#import "StatusDetailFrameModel.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "StatusModel.h"
#import "StatusFrameModel.h"
#import "MJExtension.h"


@interface StatusDetailViewController ()
@property (nonatomic , strong) StatusDetailFrameModel *statusFrameModel;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation StatusDetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"微博正文";
    
    //2.添加View的子控制器
    [self createSubViews];
    
    
 
    
}

-(void)createSubViews{
    
    //初始化frameModel
    CGSize size = self.view.frame.size;
    _statusFrameModel.statusModel =_statusModel;
    
    //1.添加tableView
    _tableView = [[UITableView alloc]init];
    _tableView.allowsSelection = NO ;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kGlobalBg ;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.frame = CGRectMake(0, 0, size.width, size.height - kOptionHeight);
    [self.view addSubview:_tableView];
    [UIImage imageNamed:@"toolbar_background"];
    
    
    //2.评论条
    UIImageView *option = [[UIImageView alloc]init] ;
    option.image = [UIImage stretchImageWithName:@"toolbar_background.png"];
    option.frame = CGRectMake(0, size.height-kOptionHeight, size.width, kOptionHeight);
    option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:option];
    
    
    
}


#pragma mark - TabelView代理

/** 2个Section */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/** row*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text =@"1111";
    return cell;
}




#pragma mark- 懒加载

-(StatusDetailFrameModel *)statusFrameModel {
    if(!_statusFrameModel){
        _statusFrameModel = [[StatusDetailFrameModel alloc]init];
    }
    return _statusFrameModel;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init] ;
    }
    return  _tableView;
}




@end

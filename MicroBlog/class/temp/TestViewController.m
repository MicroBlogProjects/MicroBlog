//
//  TestViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "TestViewController.h"
#import "Test2ViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

 

- (void)viewDidLoad {
    [super viewDidLoad];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    Test2ViewController *test = [[Test2ViewController alloc]init ] ;
    test.title = @"测试2";
    
    [self.navigationController pushViewController:test animated:YES];
    
}


@end

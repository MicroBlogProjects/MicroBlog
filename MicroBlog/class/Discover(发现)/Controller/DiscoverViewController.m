//
//  DiscoverViewController.m
//  MicroBlog
//
//  Created by lai on 15/6/26.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SearchBar.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 创建搜索框 */
    //创建搜索框对象(这是我自定义的工具)
    
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = 300 ;
    searchBar.heigt = 35 ;
  
    self.navigationItem.titleView = searchBar;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    // Return the number of rows in the section.
    return 0;
}



@end

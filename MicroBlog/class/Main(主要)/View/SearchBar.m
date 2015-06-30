//
//  SearchBar.m
//  MicroBlog
//  创建搜索框工具
//  Created by lai on 15/6/27.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar


-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        //设置搜索框左边的放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30 ;
        searchIcon.heigt = 30 ;
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return  self;
}

+(instancetype)searchBar{
    return [[self alloc]init];
}

@end

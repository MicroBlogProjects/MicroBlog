//
//  MenuTableViewController.h
//  MicroBlog
//
//  Created by lai on 15/6/28.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeTitltClickBlock)(NSString*);
@interface MenuTableViewController : UITableViewController

@property (nonatomic ,copy ) HomeTitltClickBlock homeTitleClickBlock ;

@end

//
//  CommentTableViewCell.h
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"
@class CommentBaseFramModel;
@interface CommentTableViewCell : UITableViewCell
{
    CommentBaseFramModel *_commentBaseFramModel;
}
@property (nonatomic,weak)UIView *commentView;
@property (nonatomic,strong)CommentBaseFramModel *commentBaseFramModel;
@end

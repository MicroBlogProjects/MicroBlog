//
//  TextView.h
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView
/** 占位文字 */
@property (nonatomic,copy)NSString *placeholder;
/** 占位位子颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;
@end

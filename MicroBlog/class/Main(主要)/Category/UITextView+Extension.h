//
//  UITextView+Extension.h
//  MicroBlog
//
//  Created by administrator on 15/7/8.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;
@end

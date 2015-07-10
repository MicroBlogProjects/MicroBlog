//
//  ComposeToolbar.h
//  MicroBlog
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ComposeToolbarButtonTypeCamera,//拍照
        ComposeToolbarButtonTypePicture,//相册
        ComposeToolbarButtonTypeMention,//@
        ComposeToolbarButtonTypeTrend,//#
        ComposeToolbarButtonTypeEmotion//表情
}  ComposeToolbarButtonType;
@class ComposeToolbar;
@protocol ComposeToolbarDelegate<NSObject>
@optional -(void)composeToolbar:(ComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType;
@end
@interface ComposeToolbar : UIView
@property (nonatomic,weak) id<ComposeToolbarDelegate> delegate;
/**  是否要显示表情按钮   */
@property (nonatomic,assign) BOOL showKeyboardButton;
@end

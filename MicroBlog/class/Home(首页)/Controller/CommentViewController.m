//
//  CommentViewController.m
//  MicroBlog
//
//  Created by lai on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentViewController.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "TextView.h"
#import "EmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "ComposeToolbar.h"
#import "ComposePhotosView.h"
#import "EmotionKeyboard.h"
#import "EmotionModel.h"

@interface CommentViewController ()<UITextViewDelegate,ComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/** 输入控件  */
@property (nonatomic,weak)EmotionTextView *textView;
/** 键盘顶部工具条 */
@property (nonatomic,weak)ComposeToolbar *toolbar;
/**表情键盘 */
@property (nonatomic,strong)EmotionKeyboard *emotionKeyboard;

@property (nonatomic,assign) BOOL  switchingKeybaord;
@property (nonatomic,assign) CGFloat keyboardHeight;
@end



@implementation CommentViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNav];
    //添加输入框
    [self setupTextView];
    //添加工具条
    [self setupToolbar];
}

#pragma mark - 初始化方法


/**
 *  添加工具条
 */
-(void)setupToolbar{
    ComposeToolbar *toolbar =[[ComposeToolbar alloc]init];
    
    toolbar.width=self.view.width;
    toolbar.height=44;
    toolbar.y=self.view.height-toolbar.height;
    [self.view addSubview:toolbar];
    toolbar.delegate=self;
    
    self.toolbar=toolbar;
    
    //inputAccessoryView设置显示键盘顶部的内容
    //self.textView.inputAccessoryView=toolbar;
    
    //inputView设置键盘
    //self.textView.inputView=[UIButton buttonWithType:UIButtonTypeContactAdd];
    
}

/**
 *  设置导航栏内容
 */
-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置取消点击事件
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    // 发微博点击事件
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendComment)];
    // 不可用状态
    self.navigationItem.rightBarButtonItem.enabled=NO;
    UILabel *titleView= [[UILabel alloc] init];
    titleView.width=200;
    titleView.height=35;
    titleView.textAlignment=NSTextAlignmentCenter;
    // 自动换行
    titleView.numberOfLines=0;
    NSString *prefix=@"发评论";
    AccountModel *model=[AccountTool account];
    if(model){
        NSString *name=  model.name;
        NSString *str=[NSString stringWithFormat:@"发评论\n%@",name];
        //创建一个带有属性的字符串（比如颜色 字体 文字 属性）
        NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range: [str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:    [str rangeOfString:name]];
        titleView.attributedText=attrStr;
        
        self.navigationItem.titleView=titleView;
    } else {
        self.title=prefix;
    }
}

/**
 *  添加输入框
 */
-(void)setupTextView{
    EmotionTextView *textView =[[EmotionTextView alloc]init];
    //垂直方向可以拖拽 （弹簧效果）
    textView.alwaysBounceVertical=YES;
    textView.frame=self.view.bounds;
    textView.delegate=self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder=@"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView=textView;
    
    //文字改变监听通知
    [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //键盘通知
    // 键盘的frame发生改变就会调用（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification
    //    UIKeyboardDidChangeFrameNotification
    // 键盘显示的时候发出
    //    UIKeyboardWillShowNotification
    //    UIKeyboardDidHideNotification
    // 键盘隐藏时发出通知
    //    UIKeyboardWillHideNotification
    //    UIKeyboardDidHideNotification
    //键盘通知
    [NotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:)   name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中通知
    [NotificationCenter addObserver:self selector:@selector(emotionDidSelect:)   name:EmotionDidSelectNotification object:nil];
    
    //表情选中通知
    [NotificationCenter addObserver:self selector:@selector(emotionDidDelete)   name:EmotionDidDeleteNotification object:nil];
    
}

/**
 *  页面一出现就弹出键盘
 */
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //成为第一相应者
    [self.textView becomeFirstResponder];;
}


#pragma mark - 键盘事件

/**
 *  删除一个表情
 */
-(void)emotionDidDelete {
    [self.textView deleteBackward];
}

/**
 *  选择一个表情
 */
-(void)emotionDidSelect:(NSNotification *)notification
{
    EmotionModel *emotion=notification.userInfo[SelectEmotionKey];
    [self.textView insertEmotion:emotion];
}

/**
 *  键盘的frame发生改变时调用（显示 隐藏）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    if(self.switchingKeybaord) return;
    
    /**
     notification内容
     {
     //键盘弹出后的frame
     UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 694},
     //耗时
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     
     // 键盘弹出\隐藏的动画的执行节奏
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    NSDictionary *userInfo=notification.userInfo;
    /** 获得键盘高度 */
    NSValue *aValue=[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect=[aValue CGRectValue];
    self.keyboardHeight=keyboardRect.size.height;
    //toolbar 动画
    double duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF=[userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y=keyboardF.origin.y-self.toolbar.height;
    }];
}


#pragma mark - 顶部工具条事件

/**
 *  发布评论
 */
-(void)sendComment {
    
    
    AFHTTPRequestOperationManager *manager  = [AFHTTPRequestOperationManager  manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"]     = [AccountTool account].access_token;
    params[@"comment"] = self.textView.fullText;
    params[@"id"] = self.idstr ;
    [manager POST:@"https://api.weibo.com/2/comments/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject){
        [MBProgressHUD showSuccess:@"评论成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [MBProgressHUD showError:@"评论失败"];
    }];
    
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击取消按钮 动作：退出当前控制器
 */
-(void)cancel{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


#pragma mark - UITextView的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#warning todo BUG-》 打开相机没反应
#pragma mark - 键盘上方工具条
-(void)composeToolbar:(ComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType {
    
    
    switch (buttonType) {
        case ComposeToolbarButtonTypeCamera: //拍照
            [self openCamera];
            break;
        case ComposeToolbarButtonTypePicture:// 相册
            [self openAlbum];
            break;
        case ComposeToolbarButtonTypeMention://@
            NSLog(@"@");
            break;
        case ComposeToolbarButtonTypeTrend://#
            NSLog(@"#");
            break;//表情键盘
        case ComposeToolbarButtonTypeEmotion:
            [self switchKeyboard];
            break;
    }
}

-(void)switchKeyboard {
    //self.textView.inputView==nil 系统那个自带键盘
    if(self.textView.inputView==nil){//切换自定义表情键盘
        
        self.textView.inputView=self.emotionKeyboard;
        // 显示键盘图标
        self.toolbar.showKeyboardButton=YES;
    }else{// 切换为系统自带的键盘
        self.textView.inputView=nil;
        //显示表情图标
        self.toolbar.showKeyboardButton=NO;
    }
    //开始切换键盘
    self.switchingKeybaord=YES;
    //退出键盘
    [self.textView endEditing:YES];
    self.switchingKeybaord=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        
        [self.textView becomeFirstResponder];
        
        
    });
}

-(void)openAlbum {
    //如果想自己写一个图片选择控制器 得利用AssetsLibrary.framework利用这个框架可以获得手机上德所有相册图片
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)openCamera {
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if(![UIImagePickerController isSourceTypeAvailable:type])return ;
    
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=type;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}





#pragma mark -懒加载
-(EmotionKeyboard *)emotionKeyboard {
    if(!_emotionKeyboard){
        EmotionKeyboard *emotionKeyboard=[[EmotionKeyboard alloc]init];
        emotionKeyboard.width=self.view.width;
        emotionKeyboard.height=self.keyboardHeight;
        _emotionKeyboard=emotionKeyboard;
    }
    return _emotionKeyboard;
}



@end

//
//  TextViewContentController.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "TextViewContentController.h"

@interface TextViewContentController ()<UITextViewDelegate>

@end

@implementation TextViewContentController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
    
    [self _initNavigationBar];
}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
    UITextView * textView = [[UITextView alloc] initWithFrame:Rect(0, 0, 200, 80)]; //初始化大小并自动释放
    textView.center = CGPointMake(ScreenWidth/2, 200);
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    textView.font = [UIFont fontWithName:@"Arial"size:15.0];//设置字体名字和字体大小
    textView.delegate = self;//设置它的委托方法
    textView.backgroundColor = [UIColor groupTableViewBackgroundColor];//设置它的背景颜色
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.scrollEnabled = YES;//是否可以拖动
    textView.editable = YES;//编辑
    //    textView.attributedPlaceholder  attributedPlaceholder 233333
    textView.placeholder = @"直接设置textview的palceholder";//普通placeholder
    textView.placeholderColor = [UIColor redColor];//placeholder颜色
    textView.inputAccessoryView = [SLInputAccessoryView inputAccessoryView];
//    textView.autoresizingMask
//    = UIViewAutoresizingFlexibleHeight;//自适应高度           
    
    [self.view addSubview:textView];//加入到整个页面中
    

}


/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"textview相关" backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - Action


#pragma mark - 网络请求


#pragma mark - Delegate
#pragma mark - 屏幕上弹
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //键盘高度216
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}
#pragma mark - 屏幕下移
- (void)textViewDidEndEditing:(UITextView *)textView {
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];

}


#pragma mark - Private


#pragma mark - 懒加载



@end

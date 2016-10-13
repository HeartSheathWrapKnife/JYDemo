//
//  AppDelegate.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/30.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSScreenShotView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//弹出登录页面
- (void)showLoginViewController;

/// 截屏view
@property (nonatomic, strong) TSScreenShotView * screenShotView;
///  获取Delegate
//+ (instancetype)sharedDelegate;
/// 添加监听
//- (void)ts_addObserver;
/// 移除监听
//- (void)ts_removeObserver;
///  窗口控制器器
//@property (nonatomic, strong, readonly) TSMainViewController *mainViewController;
@end


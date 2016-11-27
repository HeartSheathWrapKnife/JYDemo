//
//  AppDelegate.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/30.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "AppDelegate.h"
#import "TSTabBarController.h"
#import "FirstGuideViewController.h"
#import "TSNavigationController.h"
#import "XHLaunchAd.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [self setupRootViewController];
    [self setupUserData];
    [self initADView];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];//设置HUD和文本的颜色
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];//背景
    return YES;
}

///  设置用户信息
- (void)setupUserData {
    User * user = [User sharedUser];
    TSUserInfo * userInfo = [User getUserInfomation];
    if (userInfo) {
        [User sharedUser].userInfo = userInfo;
        [User sharedUser].login = YES;
    } else {
        user.userInfo = [TSUserInfo new];
    }
}


// 设置rootviewController
- (void)setupRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    // 截屏view
    self.screenShotView = [[TSScreenShotView alloc] initWithFrame:CGRectMake(0, 0, self.window.size.width, self.window.size.height)];
    self.screenShotView.hidden = YES;
    [self.window insertSubview:self.screenShotView atIndex:0];

    if (!NOTFIRSTOPEN) {//第一次进入app
        self.window.rootViewController = [[FirstGuideViewController alloc] init];
    } else {
        
        self.window.rootViewController = [[TSTabBarController alloc] init];
        
    }
    
//    else if (LOGIN) {
//        
//    }
}

//添加启动广告控件
- (void)initADView{
    
    //后台获取广告图，保存在本地
    [[NSUserDefaults standardUserDefaults] setObject:@"http://img05.tooopen.com/images/20140925/sy_71877587655.jpg" forKey:@"adimageurl"];
    
    
    XHLaunchAd *launchAd = [[XHLaunchAd alloc] initWithFrame:self.window.bounds andDuration:ADIMAGEURL?6:3];
    NSString *imgUrlString = ADIMAGEURL;//广告图地址，（可写死，后台改变广告图时，图片地址不变，也可在进入app后调用接口获取，再缓存，下次启动app生效）
    [launchAd imgUrlString:imgUrlString options:XHWebImageRefreshCached completed:^(UIImage *image, NSURL *url) {
    }];
    launchAd.hideSkip = !ADIMAGEURL;
    
    @weakify(self)
    [launchAd setClickBlock:^(){
        @strongify(self)
        TSLog(@"跳转到广告webview，或者固定某一页");
        
    }];
    
    if (ADIMAGEURL) {
        [launchAd addInWindow];
    }
}


#pragma mark 弹出登录页面
- (void)showLoginViewController
{
    TSLog(@"跳转到登录");
    self.window.rootViewController = [[TSNavigationController alloc] initWithRootViewController:[TSTabBarController new]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

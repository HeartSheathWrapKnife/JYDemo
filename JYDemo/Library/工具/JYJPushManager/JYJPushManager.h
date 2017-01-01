//
//  JYJPushManager.h
//  JYDemo
//
//  Created by 李佳育 on 2016/12/23.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

//自己应用的appkey
#define JPushAppKey @"0a3904a3546d1e2efdca5b15"

typedef void(^setActionBlock)(NSDictionary *userInfo);


@interface JYJPushManager : NSObject

//@property (nonatomic,   copy) void (^ClickNotificationsBlock)(NSDictionary *userInfo);

@property (nonatomic,   copy) setActionBlock block;

+ (JYJPushManager *)shareManager;

/**
 初始化极光相关

 @param option option
 @param appkey 自己应用的appkey
 @param isProduction 是否是发布状态
 @param completionHandler 注册id回调
 */
+ (void)setupJPushWithOption:(NSDictionary *)launchOptions AppKey:(NSString *)appkey apsForProduction:(BOOL)isProduction;


/**
 设置别名一定要在登录后设置，否者设置无效
 */
+ (void)setJPushAlias:(NSString *)alias;

///  判断用户是否开启推送权限
+ (BOOL)isAllowedRemoteNotification;

///  注册远程通知
+ (void)setupRemoteNotification;

///  清除角标
+ (void)clearBadgeNumber;

@end

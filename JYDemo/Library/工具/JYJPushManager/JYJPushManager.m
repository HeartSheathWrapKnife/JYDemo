//
//  JYJPushManager.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/23.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "JYJPushManager.h"
#import "SelfSound.h"

@interface JYJPushManager()<JPUSHRegisterDelegate>
@end

@implementation JYJPushManager

static JYJPushManager * manager = nil;

+ (JYJPushManager *)shareManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[JYJPushManager alloc] init];
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
    });
    return manager;
}

+ (void)setupJPushWithOption:(NSDictionary *)launchOptions AppKey:(NSString *)appkey apsForProduction:(BOOL)isProduction {
    if (!isProduction) {
        TSLog(@"debug模式 打印开");
        [JPUSHService setDebugMode];
    } else {
        TSLog(@"product模式 打印关");
        [JPUSHService setLogOFF];
    }
    
    //注册极光推送
    // notice: 3.0.0及以后版本注册可以这样写，也可以继续 旧的注册 式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:[JYJPushManager shareManager]];

    //setup
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:@"App Store"
                 apsForProduction:isProduction];
    
    //??
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }

}



/**
 设置别名

 @param alias 别名字符串
 */
+ (void)setJPushAlias:(NSString *)alias {
    [JPUSHService setAlias:alias callbackSelector:nil object:nil];
}

#pragma mark  ios  通知相关相关处理
//ios10 系统在前台收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        TSLog2(@"iOS10 前台收到远程通知:%@", userInfo);
        [self sendLocalNotification:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//iOS 10 系统点击消息
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //判断app是不是在前台运行，有三个状态(如果不进行判断处理，当你的app在前台运行时，收到推送时，通知栏不会弹出提示的)
    // UIApplicationStateActive, 在前台运行// UIApplicationStateInactive,未启动app//UIApplicationStateBackground    app在后台
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        //此时app在前台运行
        //妈的实际上这里是走的前台方法 接收的还是本地通知
        TSLog(@"前台消息 转 本地通知  执行对应事件");
        BLOCK_SAFE_RUN(self.block,userInfo);
        
    } else {
        //这里是app未运行或者在后台，通过点击手机通知栏的推送消息打开app时可以在这里进行处理
        //这里是后台运行 或 离线 的时候  推送过来的
        TSLog(@"未运行 或 后台  推送  执行对应事件");
        BLOCK_SAFE_RUN(self.block,userInfo);
    }
    completionHandler();
    
}




///  发送本地通知
- (void)sendLocalNotification:(NSDictionary *)userInfo {
    //    //播放自定声音
//    SelfSound *tap = [[SelfSound alloc]initForPlayingSoundEffectWith:@"sms-receivedZero.caf"];
//    [tap play];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    // 2.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    // 2.2.设置通知的内容
    localNote.alertBody = content;
    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
    localNote.alertAction = @"解锁";
    // 2.4.决定alertAction是否生效
    localNote.hasAction = NO;
    // 2.5.设置点击通知的启动图片
    localNote.alertLaunchImage = @"AppIcon";
    // 2.6.设置alertTitle
    localNote.alertTitle = @"JYDemo";
    // 2.7.设置有通知时的音效
//    localNote.soundName = ;
    // 2.8.设置应用程序图标右上角的数字
    //    localNote.applicationIconBadgeNumber = 999;
    // 2.9.设置额外信息
    localNote.userInfo = extras;
    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}


///  判断用户是否开启推送权限
+ (BOOL)isAllowedRemoteNotification {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types != UIUserNotificationTypeNone) {
            return YES;
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type != UIRemoteNotificationTypeNone) {
            return YES;
        }
#pragma clang diagnostic pop
    }
    return NO;
}

///  注册远程通知
+ (void)setupRemoteNotification {
    
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
        } else {
            UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
            UIRemoteNotificationTypeSound |
            UIRemoteNotificationTypeAlert;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
        }
    });
}

+ (void)unregisterRemoteNotifications
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    [[NSNotificationCenter defaultCenter] postNotificationName:kJPFNetworkDidCloseNotification object:nil];
}

+ (void)clearBadgeNumber {
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

//+ (void)changeRemotePushState:(UISwitch*)sender
//{
//    if (!sender.on){ //关闭通知
//        [JYJPushManager unregisterRemoteNotifications];
//    }else{ // 打开通知
//        
//        // 先检查用户在手机设置中是否打开了小自播通知
//        
//        // 如果未打开，提示用户打开
//        if (![JYJPushManager isAllowedRemoteNotification]) {
//            UIAlertView* alert = [UIAlertView alertViewWithTitle:@"提示" message:@"请在 设置 - 通知 中找到iChanl应用，\n勾选允许通知" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(NSInteger buttonIndex, NSString *buttonTitle) {
//                [DataManager sharedManager].remotePushStateMaybeChange = YES;
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&path=com.365sji.iChanl"]];
//                
//            } onCancel:^{
//                sender.on = NO;
//                [DataManager sharedManager].allowRemotePush = sender.on;
//            }];
//            
//            NSString * message = @"请在 设置 - 通知 中找到JYDemo应用，\n勾选允许通知";
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"], nil];
//            [alert show];
//            
//        }else{ //如果已打开，马上注册推送通知
//            
////            [JYJPushManager configurePushWithOptions:nil];
//            
//        }
//        [JYJPushManager shareManager].allowRemotePush = sender.on;
//    }
//}
//#pragma mark - alert
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//}
@end








//
//  User.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "User.h"

static User * _user = nil;
NSString * const kRefreshFinanceDataNotificationName = @"kRefreshFinanceDataNotificationName";
NSString * const kLastLoactionSuccessTime = @"kLastLoactionSuccessTime";


NSString * const kRefreshFirstDataNotificationName = @"kRefreshFirstDataNotificationName";
NSString * const kRefreshRobOderVCNotification = @"kRefreshRobOderVCNotification";
NSString * const kWorkStatusKey = @"kWorkStatusKey";
NSString * const kCurrentOrderStatus = @"kCurrentOrderStatus";
NSString * const kAgreeRefundNotification = @"kAgreeRefundNotification";
@implementation User

+ (void)printPropertyName:(NSDictionary *)dict {
    TSLog(@"打印属性------------------begin");
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSString * property = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray * %@;", key];
            TSLog(property);

        } else {
            NSString * property = [NSString stringWithFormat:@"@property (nonatomic,   copy) NSString * %@;", key];
            TSLog(property);
        }
        
    }];
    TSLog(@"打印属性------------------end");
}

+ (instancetype)sharedUser
{
    if (_user == nil) {
        _user = [[self alloc] init];
    }
    return _user;
}

+ (BOOL)userIsLogin {
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSDictionary * d = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([d count]) {
        [User sharedUser].userInfo = [TSUserInfo mj_objectWithKeyValues:d];
        [User sharedUser].login = YES;
        return YES;
    }
    return NO;
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _user = [super allocWithZone:zone];
//    });
//    return _user;
//}

+ (BOOL)saveUserInfomation:(NSDictionary *)userInfo {
    
    if (!userInfo) return NO;
    
    TSUserInfo * info = [TSUserInfo objectWithKeyValues:userInfo];
    [[User sharedUser] setUserInfo:info];
    [[User sharedUser] setLogin:YES];
    
    // 沙盒路径
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    TSLog(path);
    // 是否保存成功
    return [[info keyValues] writeToFile:path atomically:YES];
}

+ (TSUserInfo *)getUserInfomation {
    // 沙盒路径
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    return [TSUserInfo objectWithKeyValues:[NSDictionary dictionaryWithContentsOfFile:path]];
}

+ (BOOL)removeUserInfomation {
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSFileManager * manager = [NSFileManager defaultManager];
//    [User sharedUser].member = NO;
    // 判断文件路径是否存在
    if (![manager fileExistsAtPath:path]) {
        return NO;
    }
//    [User sharedUser].userInfo = nil;
    // 删除文件
    return [manager removeItemAtPath:path error:nil];
}

+ (void)removeUseDefaultsForKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUseDefaultsForKeys:(NSArray *)keysArray {
    
    for (NSString * key in keysArray) {
        [self removeUseDefaultsForKey:key];
    }
}

- (NSMutableArray *)orders {
    
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
    return _orders;
}
@end

@implementation TSUserInfo



@end

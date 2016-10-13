//
//  User.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const kLastLoactionSuccessTime;
/// 定义没有返回值的block
typedef void (^VoidBlcok)(void);

/// 定义带一个NSDictionary参数的block
///
/// @param dict NSDictionary
typedef void (^DictionaryBlcok)(NSDictionary *dict);

/// 定义带一个array参数的block
///
/// @param array NSArray
typedef void (^ArrayBlcok)(NSArray *array);

/// 定义带一个NSString参数的block
///
/// @param string NSString
typedef void (^StringBlcok)(NSString *string);


#pragma mark - 用户参数
@interface TSUserInfo : NSObject

@property (nonatomic,   copy) NSString * area_id;
@property (nonatomic,   copy) NSString * balance;
@property (nonatomic,   copy) NSString * bysr;
@property (nonatomic,   copy) NSString * circle_id;
@property (nonatomic,   copy) NSString * city_id;
@property (nonatomic,   copy) NSString * cis_id;
@property (nonatomic,   copy) NSString * city;
@property (nonatomic,   copy) NSString * complete_order_number;
@property (nonatomic,   copy) NSString * freeze_balance;
@property (nonatomic,   copy) NSString * gender;
@property (nonatomic,   copy) NSString * head;
@property (nonatomic,   copy) NSString * identifier;
@property (nonatomic,   copy) NSString * last_dispatch_time;
@property (nonatomic,   copy) NSString * jrsr;
@property (nonatomic,   copy) NSString * level;
@property (nonatomic,   copy) NSString * comment_num;
@property (nonatomic,   copy) NSString * not_done_order_number;
@property (nonatomic,   copy) NSString * really_name;
@property (nonatomic,   copy) NSString * service_items;
@property (nonatomic,   copy) NSString * status;
@property (nonatomic,   copy) NSString * pay_pass;
@property (nonatomic,   copy) NSString * account;
@property (nonatomic,   copy) NSString * area;
@property (nonatomic,   copy) NSString * address;
@end

@interface User : NSObject

///定位
@property (nonatomic, strong) NSString * locationCity;
/// 用户是否登录
@property (nonatomic, assign, getter=isLogin) BOOL login;
///  存放推送过来的订单
@property (nonatomic, strong) NSMutableArray * orders;
///  是否正在工作
@property (nonatomic, assign, getter=isWorking) BOOL working;
///  是否有订单有显示中
@property (nonatomic, assign, getter=isShowing) BOOL showing;
///  是否准备好显示订单
@property (nonatomic, assign, getter=isPrepared) BOOL prepared;
///  是否需要过滤消息
@property (nonatomic, assign, getter=isNeedFilter) BOOL needFilter;
///  是否手动点击退出登录(用来防止掉线),如果YES,是主动调退出方法，否则为掉线
@property (nonatomic, assign, getter=isManuallyLogout) BOOL manuallyLogout;
/// 用户的信息
@property (nonatomic, strong) TSUserInfo * userInfo;

///  是否需要发通知（用于支付完成时候的回调，从支付宝\微信返回的时候，需要在appDelegate里面发通知，刷新状态）
@property (nonatomic, assign, getter=isNeedSendNotifyNotification) BOOL needSendNotifyNotification;

@property (nonatomic, assign,getter=isNeedToHadBought) BOOL needToHadBought;

+ (instancetype)sharedUser;
+ (BOOL)userIsLogin ;
/**
 *  保存用户信息
 *
 *  @param userInfo 用户信息字典
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveUserInfomation:(NSDictionary *)userInfo;


///  从沙盒中获取用户信息
///
///  @return 用户字典或nil
+ (TSUserInfo *)getUserInfomation;
/**
 *  删除用户信息
 *
 *  @return 是否删除成功
 */
+ (BOOL)removeUserInfomation;
/**
 *  移除userDefaults key对应的object
 *
 *  @param key key
 */
+ (void)removeUseDefaultsForKey:(NSString *)key;
/**
 *  移除userDefaults keys对应的objects
 *
 *  @param keysArray 传入数组，里面存放key
 */
+ (void)removeUseDefaultsForKeys:(NSArray *)keysArray;
//
+ (void)printPropertyName:(NSDictionary *)dict;
@end

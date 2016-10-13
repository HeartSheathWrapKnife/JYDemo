//
//  TSParamter.h
//  晟轩生鲜
//
//  Created by 李佳育 on 15/11/13.
//  Copyright © 2015年 Seven Lv. All rights reserved.
#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"
#import "NSObject+MJProperty.h"

@interface TSParamter : NSObject
//id
@property (nonatomic,   copy) NSString * cis_id;
//状态
@property (nonatomic,   copy) NSString * status;
//分页
@property (nonatomic,   copy) NSString * p;
//订单id
@property (nonatomic,   copy) NSString * order_id;

@property (nonatomic,   copy) NSString * item_id;//服务项目ID

@property (nonatomic,   copy) NSString * city_id;//订单城市ID

@property (nonatomic,   copy) NSArray * data;//json

@property (nonatomic,   copy) NSString * user_id;

//    pay_pass	支付密码	必选	文本
@property (nonatomic,   copy) NSString * pay_pass;
//    rec_card_id	"rec_card_id": 充值卡ID	必选	文本
@property (nonatomic,   copy) NSString * rec_card_id;
//content	反馈建议
@property (nonatomic,   copy) NSString * content;
//n_password	新密码	必选	文本
@property (nonatomic,   copy) NSString * n_password;

//unique_code	标识 注册：register 找回密码：retrieve 修改支付密码：update_pay_password_verify 绑定手机：bind
@property (nonatomic,   copy) NSString * unique_code;

//re_pay_pass	确认支付密码	必选	文本
@property (nonatomic,   copy) NSString * re_pay_pass;

@property (nonatomic,   copy) NSString * bank_id;

//bank_short	银行简称	必选	文本
@property (nonatomic,   copy) NSString * bank_short;
//bank_name	银行名称	必选	文本
@property (nonatomic,   copy) NSString * bank_name;
//mobile	开户预留手机号	必选	文本
@property (nonatomic,   copy) NSString * mobile;
//open_name	开户名称	必选	文本
@property (nonatomic,   copy) NSString * open_name;
//card_number	卡号	必选
@property (nonatomic,   copy) NSString * card_number;

//order_id	订单ID	必选	文本
//payment	支付方式 1支付宝 2微信
@property (nonatomic,   copy) NSString * payment;

//money	提现金额	必选	文本
@property (nonatomic,   copy) NSString * money;
//start_time	查询开始时间 格式 2016-07-30 00:00:00 每天记录就是当天零点，每月收入就是那月第一天零点	必选	文本

@property (nonatomic,   copy) NSString * start_time;
//end_time	查询结束时间 格式 2016-07每天记录就是当天零点，每月收入就是那月第一天零点-30 00:00:00	必选	文本
@property (nonatomic,   copy) NSString * end_time;

@property (nonatomic,   copy) NSString * order_sn;

@property (nonatomic,   copy) NSString * pay_fee;

@property (nonatomic,   copy) NSString * number;

@property (nonatomic,   copy) NSString * site_msg_id;

@property (nonatomic,   copy) NSString * user_type;
///  youqiao
//登录手机号
@property (nonatomic,   copy) NSString * account;
//登录密码
@property (nonatomic,   copy) NSString * password;

//验证码
@property (nonatomic,   copy) NSString * verify;
//第二次输入的密码
@property (nonatomic,   copy) NSString * re_password;


/** 上一级城市id **/
@property (nonatomic,   copy) NSString * parent_id;
//真实名字
@property (nonatomic,   copy) NSString * real_name;
/** 性别 **/
@property (nonatomic,   copy) NSString * gender;
/** 区域 **/
@property (nonatomic,   copy) NSString * area_id;
/** 地址 **/
@property (nonatomic,   copy) NSString * address;
/** 类型 **/
@property (nonatomic,   copy) NSString * type;
///  图片
@property (nonatomic,   copy) NSString * f;

@end

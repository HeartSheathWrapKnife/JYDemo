//
//  ForFans
//
//  Created by Seven Lv on 15/10/18.
//  Copyright (c) 2015年 Seven Lv. All rights reserved.
//  定义各种宏

#ifndef ForFans_Common_h
#define ForFans_Common_h

#define RGBColor(r, g, b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define RGBColor2(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

/// 十六进制颜色
#define HexColor(hexString) [UIColor hexColor:(hexString)]

#define kScreenHeigth [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kHalfScreenHeigth [[UIScreen mainScreen] bounds].size.height * 0.5
#define kHalfScreenWidth [[UIScreen mainScreen] bounds].size.width * 0.5
#define User_is_login [User sharedUser].isLogin
#define USER [User sharedUser]


#define User_m_id [User sharedUser].userInfo.cis_id
//#define User_m_id @"8"

#define SVShowError(message) [SVProgressHUD showError:(message)]
#define SVShowSuccess(message)[SVProgressHUD showSuccess:(message)]
#define SLFail SVShowError(@"网络连接失败");
#define ThemeOrangeColor RGBColor(253, 158 , 40)

#define WeakSelf __weak typeof(self) wself = self;


// 背景颜色
#define SetBackgroundGrayColor self.view.backgroundColor = RGBColor(245, 245, 245);

#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;

/// CGRect
#define Rect(x, y, w, h) CGRectMake((x), (y), (w), (h))
/// CGSize
#define Size(w, h) CGSizeMake((w), (h))
/// CGPoint
#define Point(x, y) CGPointMake((x), (y))


#define IfUserIsNotLogin \
if (!User_is_login) { \
    SLLoginViewController * login = [[TSLoginViewController alloc] init]; \
    login.ts_navgationBar = [TSNavigationBar navWithTitle:@"登录" backAction:^{ \
        [login dismissViewControllerAnimated:YES completion:nil]; \
    }]; \
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login]; \
    nav.navigationBar.hidden = YES; \
    [self presentViewController:nav animated:YES completion:nil]; \
    return; \
}

/// 验证是文字是否输入
///
/// @param __Text    文字长度
/// @param __Message 错误提示
    #define SLVerifyText(__TextLength, __Message)\
    if (!__TextLength) {\
    SVShowError(__Message);\
    return;\
    }

/// 验证手机正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define SLVerifyPhone(__Phone, __Message)\
if (![__Phone validateMobile]) {\
SVShowError(__Message);\
return;\
}

/// 验证邮箱正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define SLVerifyEmail(__Email, __Message)\
if (![__Email validateEmail]) {\
SVShowError(__Message);\
return;\
}

/// 验证密码正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define SLVerifyPassword(__Password, __Message)\
if (![__Password validatePassword]) {\
SVShowError(__Message);\
return;\
}

/// 验证条件
#define SLAssert(Condition, Message)\
if (!(Condition)) {\
    SVShowError(Message);\
    return;\
}

#define SLEndRefreshing(__ScrollView)\
if ([__ScrollView.mj_footer isRefreshing]) {\
    [__ScrollView.mj_footer endRefreshing];\
}\
if ([__ScrollView.mj_header isRefreshing]) {\
    [__ScrollView.mj_header endRefreshing];\
}


#define SLReleaseView(__View) { \
    [(__View) removeFromSuperview];\
    (__View) = nil;}


#define SLLazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);

#define SLLazyArray(_array)    \
return !(_array) ? (_array) = [NSArray array] : (_array);

#define SLLazyMutableDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSMutableDictionary dictionary] : (_dictionary);

#define SLLazyDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSDictionary dictionary] : (_dictionary);

#define Fit375(num) ((num)*kScreenWidth/375.00)

#endif

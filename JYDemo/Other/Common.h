//
//  JYDemo
//
//  Created by 李佳育 on 16/8/30.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#ifndef JYDemo_Common_h
#define JYDemo_Common_h


//#pragma mark - 色彩相关宏
#define RGBColor(r, g, b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]//RGB
#define RGBAColor(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]//RGB alpha
#define HexColor(hexString) [UIColor hexColor:(hexString)]//十六进制颜色
#define ThemeOrangeColor RGBColor(253, 158 , 40)//主题颜色
#define SetBackgroundGrayColor self.view.backgroundColor = RGBColor(245, 245, 245);// 背景颜色

////////////////////////////////////////////////////////////////////////////////////////////

//#pragma mark - 宽高大小相关宏
#define ScreenWith  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenHeigth [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define Fit375(num) ((num)*kScreenWidth/375.00)
/// CGRect
#define Rect(x, y, w, h) CGRectMake((x), (y), (w), (h))
/// CGSize
#define Size(w, h) CGSizeMake((w), (h))
/// CGPoint
#define Point(x, y) CGPointMake((x), (y))
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
/////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - USER相关
#define User_m_id [User sharedUser].userInfo.cis_id
//#define User_m_id @"8"
#define User_is_login [User sharedUser].isLogin
#define USER [User sharedUser]
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

/////////////////////////////////////////////////////////////////////////////////////////////

//提示
#define SVShowError(message) [SVProgressHUD showError:(message)]
#define SVShowSuccess(message)[SVProgressHUD showSuccess:(message)]
#define SVFail SVShowError(@"网络连接失败");

///////////////////////////////////////////////////////////////////////////////////////

//弱self
#define WeakSelf __weak typeof(self) wself = self;
//一般使用RAC自带的@weakify @strongify 自带缓存池
//弱引用
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
//强引用
#define strongify(object) __typeof__(object) object = weak##_##object;

////////////////////////////////////////////////////////////////////////////////////////

//block运行
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;


/// 验证是文字是否输入
///
/// @param __Text    文字长度
/// @param __Message 错误提示
    #define JYVerifyText(__TextLength, __Message)\
    if (!__TextLength) {\
    SVShowError(__Message);\
    return;\
    }

/// 验证手机正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyPhone(__Phone, __Message)\
if (![__Phone validateMobile]) {\
SVShowError(__Message);\
return;\
}

/// 验证邮箱正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyEmail(__Email, __Message)\
if (![__Email validateEmail]) {\
SVShowError(__Message);\
return;\
}

/// 验证密码正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyPassword(__Password, __Message)\
if (![__Password validatePassword]) {\
SVShowError(__Message);\
return;\
}

/// 验证条件
#define JYAssert(Condition, Message)\
if (!(Condition)) {\
    SVShowError(Message);\
    return;\
}




#define JYReleaseView(__View) { \
    [(__View) removeFromSuperview];\
    (__View) = nil;}
///////////////////////////////////////////////////////////////////////

//懒加载相关宏
#define JYLazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);

#define JYLazyArray(_array)    \
return !(_array) ? (_array) = [NSArray array] : (_array);

#define JYLazyMutableDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSMutableDictionary dictionary] : (_dictionary);

#define JYLazyDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSDictionary dictionary] : (_dictionary);




//图片 URL
#define PlaceHolderString @"placeholderImage.jpg"
#define ImageWithName(nameString) [UIImage imageNamed:nameString]
#define UrlWithString(urlSring) [NSURL URLWithString:urlSring]
//tableview停止刷新
#define JYEndRefreshing(__ScrollView)\
if ([__ScrollView.mj_footer isRefreshing]) {\
[__ScrollView.mj_footer endRefreshing];\
}\
if ([__ScrollView.mj_header isRefreshing]) {\
[__ScrollView.mj_header endRefreshing];\
}


//是否第一次进入app 实际上可以不用CFBundleShortVersionString 只是为了不重复命名
#define  NOTFIRSTOPEN  [[NSUserDefaults standardUserDefaults]objectForKey:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
//是否登录
#define LOGIN [[NSUserDefaults standardUserDefaults]objectForKey:@"login"]
//广告图地址，（可写死，也可在进入app后调用接口获取，下次启动app生效）
#define ADIMAGEURL [[NSUserDefaults standardUserDefaults]objectForKey:@"adimageurl"]

#endif

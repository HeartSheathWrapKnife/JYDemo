//
//  TSTabBarController.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "TSTabBarController.h"
#import "TSNavigationController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

#import "JYTabBar.h"


@interface TSTaBar : UITabBar
@property (nonatomic,   weak) UIView * redPoint;

@end


@implementation TSTaBar


- (instancetype)initWithFrame:(CGRect)frame {
    if (![super initWithFrame:frame]) {
        return nil;
    }
    
    UIView * view = [UIView viewWithBgColor:[UIColor redColor] frame:CGRectZero];
    [self addSubview:view];
    self.redPoint = view;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger index = 0;
    for (UIView * view in self.subviews) {
        if (![view isKindOfClass:[UIControl class]]) {
            continue;
        }
        
        if (index == 2) {
            //            TSLog(view.subviews);
            for (UIView * v in view.subviews) {
                if ([v isKindOfClass:[UIImageView class]]) {
                    self.redPoint.frame = Rect(view.x + v.maxX + 2, v.y, 10, 10);
                    self.redPoint.cornerRadius = _redPoint.halfHeight;
                    break;
                }
            }
        }
        index++;
    }
}

@end

@implementation TSTabBarController
{
    RACDisposable * _d;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupChildController];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    @weakify(self);
    //    _d = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"pushToOrderList" object:nil] subscribeNext:^(id x) {
    //        @strongify(self);
    //        self.selectedIndex = 1;
    //    }];

}

//- (void)pushToOrderListAction {
//
//    self.selectedIndex = 1;
//}



#pragma mark - 初始化tabbaritem设置(字体颜色等)
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


///  设置子控制器数据
- (void)setupChildController {
    
    NSArray *selectImages = @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
    NSArray *normalImages = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
    NSArray *title = @[@"模块壹",@"模块贰",@"模块叁",@"模块肆"];
    NSArray *array = @[[OneViewController new],
                       [TwoViewController new],
                       [ThreeViewController new],
                       [FourViewController new],];
    
    for (int i = 0; i < title.count; i++) {
        
        [self setupChildVc:array[i] title:title[i] image:normalImages[i] selectedImage:selectImages[i]];
        
    }
    
    // 更换tabBar
    [self setValue:[[JYTabBar alloc] init] forKeyPath:@"tabBar"];

#warning 红点
    //    TSTaBar * ts_tabBar = [[TSTaBar alloc] init];
    //    [self setValue:ts_tabBar forKeyPath:@"tabBar"];
    //    _redPoint = ts_tabBar.redPoint;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
//    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    //如果不希望使用系统颜色，需要对图片加上属性UIImageRenderingModeAlwaysOriginal
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    TSNavigationController *nav = [[TSNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



///  其他初始化方式

//- (void)setupChildControllers {
//
//    NSArray *selectImages = @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
//    NSArray *normalImages = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
//    NSArray *title = @[@"抢单区",@"我的工单",@"消息通知",@"个人中心"];
//
//    NSMutableArray * items = [NSMutableArray arrayWithCapacity:title.count];
//    for (int i = 0; i < title.count; i++) {
//        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title[i] image:[UIImage imageNamed:normalImages[i]] selectedImage:[UIImage imageNamed:selectImages[i]]];
//        //        item.badgeValue = @"990";
//        [items addObject:item];
//    }
//
//    NSArray *views = @[[OneViewController new],
//                       [TwoViewController new],
//                       [ThreeViewController new],
//                       [FourViewController new],];
//
//
//    for (int i = 0; i < views.count; i++) {
//        UIViewController *vc = views[i];
//        vc.tabBarItem = items[i];
//    }
//
//
//    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
//    for (int i = 0; i < views.count; i++) {
//
//        TSNavigationController *nav = [TSNavigationController naviWithRootViewController:views[i]];
//        [viewControllers addObject:nav];
//    }
//    self.viewControllers = viewControllers;
//
//}


@end

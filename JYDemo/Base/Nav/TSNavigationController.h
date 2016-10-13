//
//  TSNavigationController.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSNavigationController : UINavigationController
///  截屏图片数组
@property (nonatomic, strong) NSMutableArray * screenShotArray;

+ (instancetype)naviWithRootViewController:(UIViewController *)aviewController;

@end

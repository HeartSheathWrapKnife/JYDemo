//
//  TSTabBarController.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCollectionLogTool.h"

@interface TSTabBarController : UITabBarController
///  小红点
@property (nonatomic,   weak, readonly) UIView * redPoint;

///  logView
@property (nonatomic, strong) SLLogView * logView;
@end

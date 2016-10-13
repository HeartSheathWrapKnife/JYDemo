//
//  TSBaseViewController.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "TSBaseViewController.h"

@interface TSBaseViewController ()

@end

@implementation TSBaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self initBaseView];
    
}

#pragma mark - 初始化UI
- (void)initBaseView {
    
    //添加左边、右边按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
    
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 13, 20)];
        [leftButton setImage:[UIImage imageNamed:@"2-1"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        
    }
}
- (void)leftButtonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
    TSLog(@"销毁了");
}

@end

//
//  RollingLableContentController.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "RollingLableContentController.h"
#import "YFRollingLabel.h"


@interface RollingLableContentController ()
// <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,   weak) UITableView * tableView;

@end

@implementation RollingLableContentController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
    
    [self _initNavigationBar];
}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
    NSArray *textArr = @[@"江南最大皮革厂",@"倒闭啦啦😝",@"老板欠下3.5个亿",@"带着小姨子",@"跑路啦啦啦啦"];
    YFRollingLabel *label = [[YFRollingLabel alloc]initWithFrame:Rect(0, 200, ScreenWidth, 50) textArray:textArr font:[UIFont systemFontOfSize:14] textColor:[UIColor blueColor]];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:label];
    
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"滚动文字栏" backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - Action


#pragma mark - 网络请求


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString * ID = @"<#String#>";
//    
//    <#tableviewcell#> * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        
//        cell = [[<#tableviewcell#> alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//    
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//}


#pragma mark - Private


#pragma mark - 懒加载



@end

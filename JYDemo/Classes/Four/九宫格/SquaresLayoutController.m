//
//  SquaresLayoutController.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "SquaresLayoutController.h"
#import "JYSquaresLayoutView.h"

@interface SquaresLayoutController ()
// <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,   weak) UITableView * tableView;

@end

@implementation SquaresLayoutController

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
    NSArray * array = @[@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/27/c0/16922592_1356570394404.jpg",@"http://p9.qhimg.com/t01665b2df63f2dc61b.jpg",@"http://b.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b18e853b981025aafa50f0680.jpg",@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/27/c0/16922592_1356570394404.jpg",@"http://p9.qhimg.com/t01665b2df63f2dc61b.jpg",@"http://b.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b18e853b981025aafa50f0680.jpg",@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/27/c0/16922592_1356570394404.jpg",@"http://p9.qhimg.com/t01665b2df63f2dc61b.jpg",@"http://b.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b18e853b981025aafa50f0680.jpg"];
    JYSquaresLayoutView *view = [[JYSquaresLayoutView alloc]initWithFrame:Rect(0, 200, ScreenWidth, 400) dataSource:array completeBlock:^(NSInteger index, NSArray *dataSource, NSIndexPath *indexpath) {
        TSLog2(@"点击的第%zd张图片",index);
    }];
    [self.view addSubview:view];
    
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"九宫格视图" backAction:^{
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

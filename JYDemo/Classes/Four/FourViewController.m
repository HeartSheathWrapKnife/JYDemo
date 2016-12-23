//
//  FourViewController.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "FourViewController.h"
#import "TextViewContentController.h"
#import "RollingLableContentController.h"
#import "SquaresLayoutController.h"

@interface FourViewController ()
 <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,   weak) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation FourViewController

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
    
    SetBackgroundGrayColor;
    
    [self _initView];
    
    [self _initNavigationBar];
}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
    self.dataSource = @[@"✅九宫格图片浏览 ❎从一张开始加",@"✅textview placeholder",@"✅滚动文字栏 rollinglabel",@"❎瀑布流",@"❎日历",@"",@""];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeigth-64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;//显示水平滑条
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    //tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//分割线
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
//    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"列表"];
    
    
}

#pragma mark - Action


#pragma mark - 网络请求


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SquaresLayoutController * controller = [[SquaresLayoutController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 1) {
        TextViewContentController * controller = [[TextViewContentController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 2) {
        RollingLableContentController * controller = [[RollingLableContentController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
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
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


@end

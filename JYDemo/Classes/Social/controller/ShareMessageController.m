//
//  ShareMessageController.m
//  SuperMali
//
//  Created by 李佳育 on 2016/11/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "ShareMessageController.h"

@interface ShareMessageController ()<UITextViewDelegate>
// <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,   weak) UITableView * tableView;
///   textView
@property (nonatomic, strong) UITextView * textView;

@end

@implementation ShareMessageController

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
    UILabel *label = [UILabel labelWithText:@"   转发理由" font:14 textColor:[UIColor darkGrayColor] frame:Rect(0, 64+10, ScreenWidth, 20)];
    [self.view addSubview:label];
    
    /** textView **/
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 64 + 30, kScreenWidth - 30, 0.35 * (kScreenWidth - 30))];
    textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    textView.cornerRadius = 5;
    textView.inputAccessoryView = [SLInputAccessoryView inputAccessoryView];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    self.textView = textView;
    [self.view addSubview:textView];
    
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"分享" rightTitle:@"发表" rightAction:^{
        @strongify(self);
        TSLog(@"发表");
        [self PostPostShareMessage];
    } backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - Action


#pragma mark - 网络请求

/**
 分享转发
 m_id	用户ID	必选	文本
 content	帖子内容	必选	文本
 forward_post_id	转发的帖子ID APP端根据 post_type 判断是 转发原创(post_id=>forward_post_id) 还是转发转帖(直接传 forward_post_id)	可选	文本
 图片 参数名 file_1 file_2 ......	可选	图片
 is_pic	是否传图了 0--否 1--是
 */
- (void)PostPostShareMessage {
    if (!self.textView.text.length) {
        SVShowError(@"内容不能为空");
        return;
    }
    NSString * url = @"Community/releasePost";
    TSParamter * params = [TSParamter new];
    params.m_id = User_m_id;
    params.content = self.textView.text;
    params.forward_post_id = self.forward_post_id;
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
        [hud removeFromSuperview];
        SLLog(request);
        if ([request[@"flag"] isEqualToString:@"error"]) {
            SVShowError(request[@"message"]);
            return;
        }
        SVShowSuccess(request[@"message"]);
        [self.navigationController popToRootViewControllerAnimated:YES];
        BLOCK_SAFE_RUN(self.block);
    } failBlock:^(NSError *error) {
        SLLog(error);
        [hud removeFromSuperview];
        SVFail;
    }];
    
}

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

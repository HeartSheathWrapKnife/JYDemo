//
//  SocialController.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/2.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "SocialController.h"
#import "ShareMessageController.h"
#import "MessageCell.h"
#import "CommentCell.h"

#import "MJRefresh.h"

@interface SocialController ()
 <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray <ConversationModel *>*dataSource;


/**
 是否正在刷新
 */
@property (nonatomic, assign,getter=isRefreshing) BOOL refreshing;
///   emptyView
@property (nonatomic, strong) UIView * emptyView;
///   page
@property (nonatomic, strong) NSString * page;
@end

@implementation SocialController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = @"1";
    
    [self _initView];
    
    [self _initNavigationBar];
}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
//    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeigth-64) style:UITableViewStylePlain];
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.showsVerticalScrollIndicator = NO;//显示水平滑条
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    //tableView.scrollEnabled = NO;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self PostSocialListData];
    self.tableView = [[UITableView alloc] initWithFrame:Rect(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(self.view);
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    [self loadMjRefresh];
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"社交页面"];
}

//加载footer header
- (void)loadMjRefresh {
#warning 这里要判断当前的index加载不同的数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
- (void)refreshData
{
    //p传1,取数据
    self.page = @"1";
    
    self.refreshing = YES;
    [self PostSocialListData];
    
}

- (void)loadMoreData {
    //取数据
    
    [self PostSocialListData];
    
}


#pragma mark - Action


#pragma mark - 网络请求
/**
 列表数据
 */
- (void)PostSocialListData {
    NSString * url = @"Community/getPosts";
    TSParamter * params = [TSParamter new];
    params.m_id = @"3";
    params.p = self.page;
    //    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
        JYEndRefreshing(self.tableView);
        //        [hud removeFromSuperview];
        SLLog(request);
        if ([request[@"flag"] isEqualToString:@"error"]) {
            SVShowError(request[@"message"]);
            return;
        }
        
        //如果正在刷新就删除数据源，不能先动数据源，以防崩溃（原因是正在调用indexpath的方法，同时数据源被改动了）
        if (self.isRefreshing) {
            self.dataSource = nil;
            [self.dataSource removeAllObjects];
            self.refreshing = NO;
        }
        //添加数据
        NSArray * array = [NSArray yy_modelArrayWithClass:[ConversationModel class] json:request[@"data"]];
        [self.dataSource addObjectsFromArray:array];
        
        //分页加一
        NSInteger a = [self.page integerValue];
        self.page = [NSString stringWithFormat:@"%ld",++a];
        if (self.dataSource.count) {
            self.emptyView.hidden = YES;
        } else {
            self.emptyView.hidden = NO;
        }
        [self.tableView reloadData];
    } failBlock:^(NSError *error) {
        SLLog(error);
        JYEndRefreshing(self.tableView);
        //        [hud removeFromSuperview];
        SVFail;
    }];
}


/**
 点赞
 m_id	用户ID	必选	文本
 post_id	帖子ID	必选	文本
 is_fab	点赞情况 0--未点赞 1--已点赞	必选	文本
 */
- (void)PostDoFabulous:(ConversationModel *)model {
    NSString * url = @"Community/doFabulous";
    TSParamter * params = [TSParamter new];
    params.m_id = User_m_id;
    params.post_id = model.post_id;
    params.is_fab = model.is_fab;
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
        [hud removeFromSuperview];
        SLLog(request);
        if ([request[@"flag"] isEqualToString:@"error"]) {
            SVShowError(request[@"message"]);
            return;
        }
        SVShowSuccess(request[@"message"]);
        model.is_fab = [NSString stringWithFormat:@"%zd",([model.is_fab integerValue]+1)%2];
        [self.tableView reloadData];
    } failBlock:^(NSError *error) {
        SLLog(error);
        [hud removeFromSuperview];
        SVFail;
    }];
}


/**
 评论
 m_id	用户ID	必选	文本
 post_id	帖子ID	必选	文本
 reply_comm_id	回复的评论ID	可选	文本
 content	评论内容	必选	文本
 */
//- (void)PostDoComment:(ConversationModel *)model {
//    NSString * url = @"Community/doComment";
//    TSParamter * params = [TSParamter new];
//    params.m_id = User_m_id;
//    params.post_id = model.post_id;
//    params.reply_comm_id = model.comments[0].reply_comm_id;
//    params.content = self.chatKeyBoard.
//    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
//    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
//        [hud removeFromSuperview];
//        SLLog(request);
//        if ([request[@"flag"] isEqualToString:@"error"]) {
//            SVShowError(request[@"message"]);
//            return;
//        }
//
//    } failBlock:^(NSError *error) {
//        SLLog(error);
//        [hud removeFromSuperview];
//        SVFail;
//    }];
//
//}


/**
 收藏
 m_id	用户ID	必选	文本
 post_id	帖子ID	必选	文本
 is_coll	收藏情况 0--未收藏 1--已收藏	必选	文本
 */
- (void)PostDoCollect:(ConversationModel *)model {
    NSString * url = @"Community/postCollection";
    TSParamter * params = [TSParamter new];
    params.m_id = User_m_id;
    params.post_id = model.post_id;
    params.is_coll = model.is_coll;
    
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
        [hud removeFromSuperview];
        SLLog(request);
        if ([request[@"flag"] isEqualToString:@"error"]) {
            SVShowError(request[@"message"]);
            return;
        }
        SVShowSuccess(request[@"message"]);
        model.is_coll = [NSString stringWithFormat:@"%zd",([model.is_coll integerValue]+1)%2];
        [self.tableView reloadData];
    } failBlock:^(NSError *error) {
        SLLog(error);
        [hud removeFromSuperview];
        SVFail;
    }];
    
}


/**
 删除
 m_id	用户ID	必选	文本
 post_id	帖子ID	必选	文本
 */
- (void)PostDoDelete:(NSInteger)index {
    NSString * url = @"Community/doDelete";
    TSParamter * params = [TSParamter new];
    params.m_id = User_m_id;
    params.post_id = self.dataSource[index].post_id;
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [TSNetworking POSTWithURL:url paramsModel:params completeBlock:^(NSDictionary * request) {
        [hud removeFromSuperview];
        SLLog(request);
        if ([request[@"flag"] isEqualToString:@"error"]) {
            SVShowError(request[@"message"]);
            return;
        }
        SVShowSuccess(request[@"message"]);
        [self.tableView.mj_header beginRefreshing];
    } failBlock:^(NSError *error) {
        SLLog(error);
        [hud removeFromSuperview];
        SVFail;
    }];
    
}

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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.dataSource[indexPath.row].cell_height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"messageCellID";
    
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ConversationModel * model = self.dataSource[indexPath.row];
    model.indexPath = indexPath;
    cell.model = model;
    
    @weakify(self);
    //评论
    cell.CommentBtnClickBlock = ^(UIButton *commentBtn,NSIndexPath * indexPath)
    {
        @strongify(self);
        //不是点击cell进行回复，则置空replayTheSeletedCellModel，因为这个时候是点击评论按钮进行评论，不是回复某某某
//        self.replayTheSeletedCellModel = nil;
//        self.seletedCellHeight = 0.0;
//        self.needUpdateOffset = YES;
//        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论 %@",model.nickname];
//        self.history_Y_offset = [commentBtn convertRect:commentBtn.bounds toView:weakWindow].origin.y;
//        self.currentIndexPath = indexPath;
//        [self.chatKeyBoard keyboardUpforComment];
    };
    
    cell.LikebtnClickBlock = ^(UIButton *likeBtn,NSIndexPath * indexPath){
        TSLog(@"赞");
        likeBtn.selected = !likeBtn.selected;
        [self PostDoFabulous:self.dataSource[indexPath.row]];
    };
    
    cell.ShareBtnClickBlock = ^(UIButton *shareBtn,NSIndexPath * indexPath){
        TSLog(@"分享");
        shareBtn.selected = !shareBtn.selected;
        ShareMessageController * controller = [[ShareMessageController alloc] init];
        controller.forward_post_id = model.forward_post_id;
        @weakify(self);
        [controller setBlock:^(){
            @strongify(self);
            [self.tableView.mj_header beginRefreshing];
        }];
        
        [self.navigationController pushViewController:controller animated:YES];
    };
    cell.CollectBtnClickBlock = ^(UIButton *colectBtn,NSIndexPath * indexPath){
        TSLog(@"收藏");
        colectBtn.selected = !colectBtn.selected;
        [self PostDoCollect:self.dataSource[indexPath.row]];
    };
    
    cell.DeleteBtnClickBlock = ^(UIButton *colectBtn,NSIndexPath * indexPath){
        TSLog(@"删除");
        [TSGlobalTool alertWithTitle:@"确定删除此条动态?" message:@"是否删除" cancelButtonTitle:@"取消" OtherButtonsArray:@[@"确定"] clickAtIndex:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self PostDoDelete:indexPath.row];
            }
        }];
        
    };
    
    
    //更多
    cell.MoreBtnClickBlock = ^(UIButton *moreBtn,MessageCell * cell)
    {
//        [self.chatKeyBoard keyboardDownForComment];
//        self.chatKeyBoard.placeHolder = nil;
        model.isExpand = !model.isExpand;
//        model.shouldUpdateCache = YES;
        NSIndexPath * path = [self.tableView indexPathForCell:cell];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    //点击九宫格
//    cell.tapImageBlock = ^(NSInteger index,NSArray *dataSource,NSIndexPath *indexpath){
//        [weakSelf.chatKeyBoard keyboardDownForComment];
//    };
    
    //点击文字
    cell.TapTextBlock=^(UILabel *desLabel){
        @strongify(self);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:desLabel.text delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    };

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

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
- (NSMutableArray<ConversationModel *> *)dataSource {
    JYLazyMutableArray(_dataSource);
}
///  空视图
- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [UIView viewWithBgColor:RGBColor(245, 245, 245) frame:Rect(0, 0, kScreenWidth, kScreenHeigth - 64)];
        _emptyView.centerX = ScreenWidth/2;
        UILabel *label = [UILabel labelWithText:@"暂无数据" font:14 textColor:[UIColor lightGrayColor] frame:CGRectMake(0, 0, kScreenWidth, 30)];
        label.center = _emptyView.center;
        label.textAlignment = NSTextAlignmentCenter;
        [_emptyView addSubview:label];
        [self.tableView addSubview:_emptyView];
    }
    return _emptyView;
}



@end

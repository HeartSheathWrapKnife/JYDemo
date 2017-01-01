//
//  TSShoppingCartViewController.m
//  Supermarket
//
//  Created by Hangshao on 16/9/1.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import "TSShoppingCartViewController.h"
#import "ShopCartCell.h"
#import "ShopCartModel.h"
#import "ShopCartToolView.h"

@interface TSShoppingCartViewController ()
 <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,   weak) UITableView * tableView;

//是否处于编辑
@property (nonatomic, assign ,getter=isEdit) BOOL edit;
///   全选按钮
@property (nonatomic, strong) UIButton * selectedAllBtn;
///   下一步按钮 删除或结算
@property (nonatomic, strong) UIButton * nextBtn;
///   总价
@property (nonatomic, strong) UILabel * totalPrice;
///   合计：（显示用）
@property (nonatomic, strong) UILabel * totalShow;
@property (nonatomic, strong) ShopCartToolView * toolView;
///   空视图
@property (nonatomic, strong) UIView * emptyView;
///   modelArr
@property (nonatomic, strong) NSMutableArray<ShopCartModel *> * modelsArr;
@end

@implementation TSShoppingCartViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SetBackgroundGrayColor;
    
    self.edit = NO;//默认处于不是编辑的状态
    
    [self _initView];
    
    [self _initNavigationBar];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 初始化UI

/// 初始化view
- (void)_initView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeigth - 64 - 50 - 62) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;//显示水平滑条
    tableView.delegate = self;
    tableView.dataSource = self;
    //tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //加载工具条
    [self loadShopToolView];
    
    //刷新价格
    [self calculateShopCart];
    
}

/// 初始化NavigaitonBar
- (void)_initNavigationBar
{
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"购物车" rightTitle:@"编辑" rightAction:^{
        @strongify(self);
        TSLog(@"编辑");
        self.edit = !self.isEdit;
        self.ts_navgationBar.rightButton.title = self.isEdit ? @"完成" : @"编辑";
        self.nextBtn.title = self.isEdit?@"删除":@"去结算";
        self.totalPrice.hidden = self.totalShow.hidden = self.isEdit?YES:NO;
        [self.tableView reloadData];
        
    }];
}

///    下方工具条
- (void)loadShopToolView {
    ShopCartToolView *toolView = [ShopCartToolView creatViewFromNib];
    toolView.frame = Rect(0, kScreenHeigth - 50 - 62, kScreenWidth, 62);
    //事件
    [toolView.selectAllBtn addTarget:self action:@selector(selectAllBtnAction:)];
    [toolView.nextBtn addTarget:self action:@selector(nextBtnAction)];
    //关联
    self.totalPrice = toolView.totalPriceLabel;
    self.totalShow = toolView.totalLabel;
    self.selectedAllBtn = toolView.selectAllBtn;
    self.nextBtn = toolView.nextBtn;
    [self.view addSubview:toolView];
    self.toolView = toolView;
}

#pragma mark - Action
//点击了全选
- (void)selectAllBtnAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    for (int i = 0; i < self.modelsArr.count; i ++) {
        self.modelsArr[i].selected = sender.isSelected;
    }
    //计算总价
    [self calculateShopCart];
    [self.tableView reloadData];
}

//下一步
- (void)nextBtnAction {
    //是否编辑状态
    if (self.isEdit) {
        //删除
        TSLog(@"删除");
        //将状态为选中的模型加入set 然后移除 从新计算价格并刷新列表
        NSMutableIndexSet * set = [[NSMutableIndexSet alloc] init];
        for (int i = 0; i < self.modelsArr.count; i ++) {
            if (self.modelsArr[i].isSelected == YES) {
                [set addIndex:i];
            }
        }
        [self.modelsArr removeObjectsAtIndexes:set];
        [self calculateShopCart];
        [self.tableView reloadData];
    } else {
        //结算
        TSLog(@"结算");
        if (!self.modelsArr.count) {
            SVShowError(@"未选中任何商品!");
            return;
        }
    }
}
#pragma mark - 网络请求

/**
 获取购物车数据
 */
- (void)getShopCartData {
    ///   初始化的数据   假数据
    for (int i = 0 ; i <10 ; i ++) {
        ShopCartModel *model = [ShopCartModel new];
        model.number = 1;
        model.GoodName = [NSString stringWithFormat:@"商品第%zd个的名字",i];
        model.GoodSize = @"规格描述";
        model.GoodPrice = @"5";
        model.GoodDescription = @"描述";
        model.selected = YES;
        [self.modelsArr addObject:model];
    }
    self.modelsArr.count ? (self.emptyView.hidden = YES):(self.emptyView.hidden = NO);
    self.modelsArr.count ? (self.toolView.hidden = NO):(self.toolView.hidden = YES);
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 125;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"shopCartCellID";
    ShopCartCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[ShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = RGBColor(245, 245, 245);
    }
    
    cell.model = self.modelsArr[indexPath.row];
    //处理回调
    @weakify(self)
    [cell setBlock:^(){
        @strongify(self)
        //重新计算价格
        [self calculateShopCart];
        //刷新tableview
        [self.tableView reloadData];
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLog(@"点击");
}


#pragma mark - Private
///  计算价格
- (void)calculateShopCart {
    TSLog(@"计算价格");
    float price = 0;
    BOOL selectAll = YES;
    for (int i = 0; i < self.modelsArr.count; i ++) {
        //计算价格
        if (self.modelsArr[i].isSelected == YES) {
            price += self.modelsArr[i].number * [self.modelsArr[i].GoodPrice floatValue];
//            self.selectedAllBtn.selected = YES;
            TSLog(price);
        } else {
            //判断是否全选
            selectAll = NO;
            
        }
    }
    if (selectAll) {
        self.selectedAllBtn.selected = YES;
    }else {
        self.selectedAllBtn.selected = NO;
    }
    self.totalPrice.text = [NSString stringWithFormat:@"￥%.2f元",price];
}


#pragma mark - 懒加载

- (NSMutableArray *)modelsArr {
    if (!_modelsArr) {
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
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

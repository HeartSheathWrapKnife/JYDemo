//
//  OneViewController.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "OneViewController.h"
#import "ListCell.h"
#import "XHLaunchAd.h"
#import "JYScrollView.h"
#import "YFRollingLabel.h"

@interface OneViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

///   modules模块数组
@property (nonatomic, strong) NSArray * modules;

///   轮播
@property (nonatomic, strong) JYScrollView * banner;

@end

@implementation OneViewController

static NSString * const ListCellID = @"ListCell";

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self _initBanner];
    [self _initView];
    
//    [self _initBanner];///
    
    [self _initNavigationBar];

}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
    SetBackgroundGrayColor;
    [self _initBanner];
    self.modules = @[@"模块1",@"模块2",@"模块3",@"模块4",@"模块5",@"模块6",@"模块7",@"模块8",@"模块9",@"模块10",@"模块11",@"模块12",@"模块13"];
    //collectionView layout
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = Size(kScreenWidth, kScreenHeigth);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumLineSpacing 行间距
//    layout.minimumInteritemSpacing 列间距
//    如果是水平滚动   行和列对应改变
    layout.minimumLineSpacing = 0;
    
    //collectionView
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:Rect(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor grayColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellWithReuseIdentifier:ListCellID];
    [self.view addSubview:collectionView];
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    @weakify(self);
    self.ts_navgationBar = [TSNavigationBar navWithTitle:@"一" rightTitle:@"演示" rightAction:^{
        @strongify(self);
        TSLog(@"点击演示");
    }];
    
}

//加载轮播图
- (void)_initBanner {
    NSArray * array = @[@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/27/c0/16922592_1356570394404.jpg",@"http://p9.qhimg.com/t01665b2df63f2dc61b.jpg",@"http://b.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b18e853b981025aafa50f0680.jpg"];
    NSArray * titleArr = @[@"photo0  aaaaaaaaaaaa",@"photo1  bbbbbbbbbbbb",@"photo2    cccccccccccccc"];
    
    _banner = [[JYScrollView alloc] initWithFrame:Rect(0, 50, kScreenWidth, Fit375(230))];
//    [self.banner bannerWithArray:array imageType:JYImageURLType placeHolder:@"placeholderImage.jpg" tapAction:^(NSInteger index) {
//        TSLog(index);
//    }];
    [_banner bannerWithArray:array titleArr:titleArr imageType:JYImageURLType placeHolder:@"placeholderImage.jpg" tapAction:^(NSInteger index) {
        TSLog2(@"click %zd",index);
    }];
    _banner.timeInterval = 4;
    [self.view addSubview:_banner];
}

///  加载全局广告通知栏
- (void)loadNotification {
    UIView * backLabel = [[UILabel alloc]initWithFrame:Rect(0, Fit375(210), kScreenWidth, 20)];
    backLabel.backgroundColor = HexColor(@"b9edd4");
    backLabel.alpha = 0.6;
    [self.view addSubview:backLabel];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:Rect(2, Fit375(212), 15, 15)];
    [icon setImage:ImageWithName(@"icon_announcement")];
    [self.view addSubview:icon];
    
    NSString *string = @"通知内容：1234567 76543211dfdfadfdfkajdlfkjadlfjlkajflkajlkfjdl";
    CGFloat textWidth = [NSString getStringRect:string fontSize:13 width:MAXFLOAT].width;
    CGFloat bannarW = kScreenWidth - 30;
    if (textWidth > bannarW) {
        NSArray *textArray = @[string];
        YFRollingLabel * _label = [[YFRollingLabel alloc] initWithFrame:CGRectMake(icon.maxX + 5, Fit375(210), bannarW, 20)  textArray:textArray font:[UIFont systemFontOfSize:13] textColor:[UIColor whiteColor]];
        _label.backgroundColor = [UIColor clearColor];
        _label.speed = 0.8;
        [_label setOrientation:RollingOrientationLeft];
        [self.view addSubview:_label];
    } else {
        UILabel * title = [UILabel labelWithText:string font:13 textColor:[UIColor whiteColor] frame:CGRectMake(icon.maxX + 5, Fit375(210), bannarW, 20)];
        [self.view addSubview:title];
    }
    
}

#pragma mark - Action


#pragma mark - 网络请求

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modules.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ListCellID forIndexPath:indexPath];
    cell.module = self.modules[indexPath.item];
//    TSLog2(@"%zd-- %@",indexPath.item,cell);
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //
    TSLog2(@"处于模块%zd，进行网络请求",(int)(scrollView.contentOffset.x / scrollView.frame.size.width));
    
}

#pragma mark - Private


#pragma mark - 懒加载



@end

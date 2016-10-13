//
//  FirstGuideViewController.m
//  JYDemo
//
//  Created by 李佳育 on 2016/9/29.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "FirstGuideViewController.h"
#import "SMPageControl.h"

@interface FirstGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView     *scrollView;
@property(nonatomic,strong)SMPageControl        *pageControl;
@end

@implementation FirstGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(3*_scrollView.bounds.size.width, _scrollView.bounds.size.height);
        for (int i = 0; i< 3; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
            imageV.contentMode = 2;
            imageV.clipsToBounds = YES;
            imageV.image = [UIImage imageNamed:[@"new_feature_" stringByAppendingFormat:@"%d",i+1]];
            imageV.backgroundColor = [UIColor colorWithRed:arc4random()%1 green:arc4random()%1 blue:arc4random()%1 alpha:arc4random()%1];
            [_scrollView addSubview:imageV];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(2.5*_scrollView.bounds.size.width- 60, _scrollView.bounds.size.height-80, 120, 40);
        [button setTitle:@"立即体验" forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        button.tintColor = [UIColor whiteColor];
        ViewBorderRadius(button,4,2,[UIColor whiteColor]);
        [button addTarget:self action:@selector(lookApp) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    return _scrollView;
}

- (SMPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2.f-30, kScreenHeigth-50, 60, 30)];
        _pageControl.pageIndicatorImage = [UIImage imageNamed:@"point1"];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorImage =  [UIImage imageNamed:@"point"];
    }
    return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.hidden = scrollView.contentOffset.x>1.5*scrollView.bounds.size.width;
    self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}
//进入app
- (void)lookApp{
    
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //写入持久化
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:nowVersion];
    
    //进入登录页面
    [(AppDelegate *)([UIApplication sharedApplication].delegate) showLoginViewController];
}
@end

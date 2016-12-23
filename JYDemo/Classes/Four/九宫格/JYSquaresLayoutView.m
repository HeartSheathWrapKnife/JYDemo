//
//  JYSquaresLayoutView.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "JYSquaresLayoutView.h"
#import "UIImageView+WebCache.h"

@implementation JYSquaresLayoutView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock {
    self = [super initWithFrame:frame];
    if (self) {
        for (NSUInteger i=0; i<dataSource.count; i++) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(GAP+([JYSquaresLayoutView imageWidth]+GAP)*(i%3),floorf(i/3.0)*([JYSquaresLayoutView imageHeight]+GAP),[JYSquaresLayoutView imageWidth], [JYSquaresLayoutView imageHeight])];
            if ([dataSource[i] isKindOfClass:[UIImage class]]) {
                iv.image = dataSource[i];
            }else if ([dataSource[i] isKindOfClass:[NSString class]]){
                [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
                [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            self.dataSource = dataSource;
            self.tapBlock = tapBlock;// 一定要给self.tapBlock赋值
            iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
            iv.tag = i;
            [self addSubview:iv];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
            [iv addGestureRecognizer:singleTap];
        }
    }
    return self;

}

- (void)JYSquaresLayoutView:(JYSquaresLayoutView *)jySquaresLayoutView DataSource:(NSArray *)dataSource completeBlock:(TapBlcok)tapBlock
{
    for (NSUInteger i=0; i<dataSource.count; i++) {
        UIImageView *iv = [UIImageView new];
        if ([dataSource[i] isKindOfClass:[UIImage class]]) {
            iv.image = dataSource[i];
        }else if ([dataSource[i] isKindOfClass:[NSString class]]){
            [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
            [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        jySquaresLayoutView.dataSource = dataSource;
        jySquaresLayoutView.tapBlock = tapBlock;
        iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
        iv.tag = i;
        [jySquaresLayoutView addSubview:iv];
        //九宫格的布局
        CGFloat  Direction_X = (([JYSquaresLayoutView imageWidth]+GAP)*(i%3));
        CGFloat  Direction_Y  = (floorf(i/3.0)*([JYSquaresLayoutView imageHeight]+GAP));
        
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jySquaresLayoutView).offset(Direction_X);
            make.top.mas_equalTo(jySquaresLayoutView).offset(Direction_Y);
            make.size.mas_equalTo(CGSizeMake([JYSquaresLayoutView imageWidth], [JYSquaresLayoutView imageHeight]));
        }];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:jySquaresLayoutView action:@selector(tapImageAction:)];
        [iv addGestureRecognizer:singleTap];
    }
 
}
#pragma mark 配置图片的宽高
+(CGFloat)imageWidth{
    return ([UIScreen mainScreen].bounds.size.width-4*GAP)/3;
}
+(CGFloat)imageHeight{
    return ([UIScreen mainScreen].bounds.size.width-4*GAP)/3;
}
-(void)tapImageAction:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = (UIImageView *)tap.view;
    //图片浏览器
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = tapView.tag;
    photoBrowser.imageCount = _dataSource.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
    //回调
    if (self.tapBlock) {
        self.tapBlock(tapView.tag,self.dataSource,self.indexpath);
    }
}
#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.dataSource[index];
    return [NSURL URLWithString:urlString];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
@end

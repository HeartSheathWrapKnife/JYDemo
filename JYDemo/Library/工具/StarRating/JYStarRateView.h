//
//  JYStarRateView.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYStarRateView;
@protocol JYStarRateViewDelegate <NSObject>
@optional

- (void)starRateView:(JYStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface JYStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<JYStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end

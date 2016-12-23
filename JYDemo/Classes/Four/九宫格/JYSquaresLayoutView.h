//
//  JYSquaresLayoutView.h
//  JYDemo
//
//  Created by 李佳育 on 2016/12/22.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

//间隔
#define GAP 5
//点击block
typedef void (^TapBlcok)(NSInteger index,NSArray *dataSource,NSIndexPath *indexpath);

@interface JYSquaresLayoutView : UIView<SDPhotoBrowserDelegate>
/**
 *  数据源，dataSource中可以放UIImage对象和NSString，NSURL
 */
@property (nonatomic, retain)NSArray * dataSource;
/**
 选择的indePath
 */
@property (nonatomic, copy)NSIndexPath  *indexpath;
/**
 *  TapBlcok
 */
@property (nonatomic, copy)TapBlcok  tapBlock;

/**
 创建视图

 @param frame frame
 @param dataSource 数据源
 @param tapBlock block点击
 @return JYSquaresLayoutView对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock;

//图片宽高
+(CGFloat)imageWidth;
+(CGFloat)imageHeight;
@end

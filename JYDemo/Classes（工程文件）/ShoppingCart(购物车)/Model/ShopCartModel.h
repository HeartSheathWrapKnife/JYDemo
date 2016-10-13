//
//  ShopCartModel.h
//  Supermarket
//
//  Created by 李佳育 on 16/9/18.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject

@property (nonatomic,   copy) NSString * GoodName;//名字
@property (nonatomic,   copy) NSString * GoodDescription;//描述
@property (nonatomic,   copy) NSString * GoodSize;//规格
@property (nonatomic,   copy) NSString * GoodPrice;//单价价格
//@property (nonatomic, assign) float subTotal;//此行的总价格 = 数量x单价
@property (nonatomic, assign ,getter=isSelected) BOOL selected;//当前商品状态(是否选中)
@property (nonatomic, assign) NSInteger number;//购买数量（可以改动）

@end

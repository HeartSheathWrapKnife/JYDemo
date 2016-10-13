//
//  ShopCartCell.h
//  Supermarket
//
//  Created by 李佳育 on 16/9/18.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"

typedef void(^setActionBlock)();

@interface ShopCartCell : UITableViewCell
///   加减按钮
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *decreaseBtn;
///   model
@property (nonatomic, strong) ShopCartModel * model;

@property (nonatomic,   copy) setActionBlock block;

//@property (nonatomic,   copy) void (^block)(MenuButtonModel *model);
@end

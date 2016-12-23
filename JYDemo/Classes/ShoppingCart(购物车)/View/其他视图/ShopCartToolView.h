//
//  ShopCartToolView.h
//  Supermarket
//
//  Created by 李佳育 on 16/9/26.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartToolView : UIView
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

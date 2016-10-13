//
//  ShopCartCell.m
//  Supermarket
//
//  Created by 李佳育 on 16/9/18.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import "ShopCartCell.h"


@interface ShopCartCell()

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIImageView *selectedImg;
@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;

@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *price;


@end

@implementation ShopCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShopCartCell" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)setModel:(ShopCartModel *)model {
    _model = model;
    self.name.text = model.GoodName;
    self.subTitle.text = model.GoodDescription;
    self.price.text =[NSString stringWithFormat:@"￥%.2f",[model.GoodPrice floatValue]];
    self.number.text = [NSString stringWithFormat:@"%zd",model.number];
    if (model.isSelected == YES) {
        self.selectedImg.highlighted = YES;
    } else {
        self.selectedImg.highlighted = NO;
    }
//    model.isSelected == YES ? (self.selectedImg.highlighted = YES):(self.selectedImg.highlighted = NO);
    [self.addBtn addTarget:self action:@selector(plusAciotn)];
    [self.decreaseBtn addTarget:self action:@selector(reduceAction)];
    [self.selectedBtn addTarget:self action:@selector(selectedBtnAction)];
}
//+
- (void)plusAciotn {
    self.model.number += 1;
    BLOCK_SAFE_RUN(self.block);
}
//-
- (void)reduceAction {
    if (self.model.number <= 1) {
        return;
    }
    self.model.number -= 1;
    BLOCK_SAFE_RUN(self.block);
}
//选择按钮
- (void)selectedBtnAction {
    self.model.selected = !self.model.isSelected;
    BLOCK_SAFE_RUN(self.block);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

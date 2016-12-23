//
//  CommentCell.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/2.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "CommentCell.h"
#import "MessageCell.h"
//////////////////////////////////////
#define kGAP 10
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define kAvatar_Size 40

#define kTabBarHeight       49
#define kNavbarHeight       64

#define kAlmostZero         0.0000001

#import "Masonry.h"

#import "UIImageView+WebCache.h"

#import "YYText.h"
#import "YYTextView.h"
#import "YYLabel.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "UIControl+YYAdd.h"


@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _initCellView];
    }
    return self;
}

- (void)_initCellView {
    // contentLabel
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.backgroundColor  = [UIColor clearColor];
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP;
    
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(3.0);//cell上部距离为3.0个间隙
    }];
    
}
/**
 拼接字符
 
 @param model commentModel
 */
- (void)setModel:(CommentsModel *)model {
    _model = model;
    NSString *str  = nil;
    if (![model.reply_nickname isEqualToString:@""]&&!(model.reply_nickname ==nil)) {
        str= [NSString stringWithFormat:@"%@：%@//@%@：%@",
              model.nickname,model.content,model.reply_nickname,model.reply_content];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName
                     value:ThemeOrangeColor
                     range:NSMakeRange(0, model.nickname.length+1)];
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor lightGrayColor]
                     range:NSMakeRange(model.nickname.length + model.content.length +1 , model.reply_nickname.length+4)];
        self.contentLabel.attributedText = text;
        
    }else{
        str= [NSString stringWithFormat:@"%@：%@",
              model.nickname, model.content];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName
                     value:ThemeOrangeColor
                     range:NSMakeRange(0, model.nickname.length+1)];
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor lightGrayColor]
                     range:NSMakeRange(model.reply_nickname.length , model.reply_content.length)];
        self.contentLabel.attributedText = text;
        
    }
    
    //重新赋值高度
    [self layoutIfNeeded];
    model.cell_height = self.contentLabel.maxY +3;

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

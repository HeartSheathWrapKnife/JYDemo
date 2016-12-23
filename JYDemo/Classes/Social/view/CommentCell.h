//
//  CommentCell.h
//  JYDemo
//
//  Created by 李佳育 on 2016/12/2.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationModel.h"

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

///   model
@property (nonatomic, strong) CommentsModel * model;
@end

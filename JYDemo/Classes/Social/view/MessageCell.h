//
//  MessageCell.h
//  JYDemo
//
//  Created by 李佳育 on 2016/12/2.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationModel.h"


@interface MessageCell : UITableViewCell
///   model
@property (nonatomic, strong) ConversationModel * model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIView *jggView;

/**
 *  评论按钮的block
 */
@property (nonatomic, copy)void(^CommentBtnClickBlock)(UIButton *commentBtn,NSIndexPath * indexPath);
/**
 *  点赞按钮的block
 */
@property (nonatomic, copy)void(^LikebtnClickBlock)(UIButton *commentBtn,NSIndexPath * indexPath);

/**
 *  转发按钮的block
 */
@property (nonatomic, copy)void(^ShareBtnClickBlock)(UIButton *commentBtn,NSIndexPath * indexPath);

/**
 *  收藏按钮的block
 */
@property (nonatomic, copy)void(^CollectBtnClickBlock)(UIButton *commentBtn,NSIndexPath * indexPath);

/**
 *  更多按钮的block
 */
@property (nonatomic, copy)void(^MoreBtnClickBlock)(UIButton *moreBtn,MessageCell * cell);

/**
 删除
 */
@property (nonatomic,   copy) void (^DeleteBtnClickBlock)(UIButton *deleteBtn,NSIndexPath * indexPath);

/**
 *  点击图片的block
 */
//@property (nonatomic, copy)TapBlcok tapImageBlock;

/**
 *  点击文字的block
 */
@property (nonatomic, copy)void(^TapTextBlock)(UILabel *desLabel);

@end

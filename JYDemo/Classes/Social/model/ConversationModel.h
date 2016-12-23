//
//  ConversationModel.h
//  SuperMali
//
//  Created by 李佳育 on 2016/11/19.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ForwardModel;
@class PicturesModel;
@class CommentsModel;

//通用会话模型11.19

@interface ConversationModel : NSObject

///发布说说的展开状态
@property (nonatomic, assign) BOOL isExpand;
//高度
@property (nonatomic, assign) float cell_height;
@property (nonatomic, strong) NSIndexPath * indexPath;

//"post_id":帖子ID
@property (nonatomic,   copy) NSString * post_id;
//"m_id":用户ID
@property (nonatomic,   copy) NSString * m_id;
//"post_type":帖子类型  1--原创 2--转发
@property (nonatomic,   copy) NSString * post_type;
//"forward_post_id":转自帖子ID
@property (nonatomic,   copy) NSString * forward_post_id;
//"forward_m_id":转自用户ID
@property (nonatomic,   copy) NSString * forward_m_id;
//"content":内容
@property (nonatomic,   copy) NSString * content;
//"pictures":[{abs_url}],图片
@property (nonatomic, strong) NSArray <PicturesModel *>* pictures;
//"forward_times":转发次数
@property (nonatomic,   copy) NSString * forward_times;
//"comment_times":评价次数
@property (nonatomic,   copy) NSString * comment_times;
//"fabulous_times":赞次数
@property (nonatomic,   copy) NSString * fabulous_times;
//"collection_times":收藏次数
@property (nonatomic,   copy) NSString * collection_times;
//"create_time":会话创建时间
@property (nonatomic,   copy) NSString * create_time;
//"nickname":昵称
@property (nonatomic,   copy) NSString * nickname;
//"head":头像
@property (nonatomic,   copy) NSString * head;
//"fuzzy_date":日期
@property (nonatomic,   copy) NSString * fuzzy_date;
//"is_coll":是否 收藏 0--否 1--赞
@property (nonatomic,   copy) NSString * is_coll;
//"is_fab":是否 赞 0--否  1--赞
@property (nonatomic,   copy) NSString * is_fab;
//"forward":{
//}
@property (nonatomic, strong) ForwardModel * forward;
//"comments":[{
//}]
@property (nonatomic, strong) NSMutableArray <CommentsModel *>* comments;
@end

/**
 图片数组
 */
@interface PicturesModel : NSObject
@property (nonatomic,   copy) NSString * ID;
//abs_url
@property (nonatomic,   copy) NSString * abs_url;
@end

/**
 转发信息
 */
@interface ForwardModel : NSObject
//    "forward_nickname":转自帖子用户昵称
@property (nonatomic,   copy) NSString * forward_nickname;
//    "forward_content":转自帖子内容
@property (nonatomic,   copy) NSString * forward_content;
//    "forward_pictures":[{abs_url}]转自帖子图片
@property (nonatomic,   copy) NSArray <PicturesModel *>* forward_pictures;
@end

/**
 回复
 */
@interface CommentsModel : NSObject
@property (nonatomic, assign) BOOL isExpand;
//高度
@property (nonatomic, assign) float cell_height;
//"p_comm_id":评价ID
@property (nonatomic,   copy) NSString * p_comm_id;
//"m_id":用户ID
@property (nonatomic,   copy) NSString * m_id;
//"nickname":用户昵称
@property (nonatomic,   copy) NSString * nickname;
//"post_id":帖子ID
@property (nonatomic,   copy) NSString * post_id;
//"reply_m_id":回复用户ID
@property (nonatomic,   copy) NSString * reply_m_id;
//"reply_comm_id":回复评价ID
@property (nonatomic,   copy) NSString * reply_comm_id;
//"content":回复内容
@property (nonatomic,   copy) NSString * content;
//"reply_nickname":回复的用户昵称
@property (nonatomic,   copy) NSString * reply_nickname;
//"reply_content":回复的评价内容
@property (nonatomic,   copy) NSString * reply_content;

@end


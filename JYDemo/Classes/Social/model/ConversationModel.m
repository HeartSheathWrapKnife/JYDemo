//
//  ConversationModel.m
//  SuperMali
//
//  Created by 李佳育 on 2016/11/19.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "ConversationModel.h"

@implementation ConversationModel
//+(NSDictionary *)mj_objectClassInArray {
//    return @{@"pictures":[PicturesModel class],@"comments":[CommentsModel class]};
//}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pictures":[PicturesModel class],@"comments":[CommentsModel class]};
}
@end

@implementation PicturesModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation ForwardModel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"forward_pictures":[PicturesModel class]};
}
@end

@implementation CommentsModel

@end

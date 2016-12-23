//
//  TSParamter.m
//  晟轩生鲜
//
//  Created by 李佳育 on 15/11/13.
//  Copyright © 2015年 Seven Lv. All rights reserved.
//

#import "TSParamter.h"

@implementation TSParamter
+ (NSDictionary*)replacedKeyFromPropertyName {
    return @{@"NEW_account" : @"new_account",@"NEW_password":@"new_password"};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.token = TokenCJML;
        self.terminal = @"2";
    }
    return self;
}
@end

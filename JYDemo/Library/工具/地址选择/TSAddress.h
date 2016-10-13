//
//  TSAddress.h
//  RunningMan
//
//  Created by Seven Lv on 16/1/16.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAddress : NSObject

@end

@interface TSProvince : NSObject

@property (nonatomic,   copy) NSString * province_id;
@property (nonatomic, strong) NSArray  * cities;
@property (nonatomic,   copy) NSString * provinceName;

@end

@interface TSCity : NSObject

@property (nonatomic,   copy) NSString * city_id;
@property (nonatomic, strong) NSArray  * districts;
@property (nonatomic,   copy) NSString * cityName;
@end

@interface TSDistrict : NSObject
@property (nonatomic,   copy) NSString * districtName;
@property (nonatomic,   copy) NSString * district_id;
@end


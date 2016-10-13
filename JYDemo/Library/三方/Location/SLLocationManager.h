//
//  SLLocationTool.h
//  NBG
//
//  Created by Seven Lv on 16/3/28.
//  Copyright © 2016年 Seven Lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface SLLocationManager : NSObject

+ (instancetype)sharedManager;

///  定位
///
///  @param complete 定位完成的block
- (void)startLocation:(void(^)(NSString *cityName, CLLocationCoordinate2D coordinate))complete;

///  是否可用
@property (nonatomic, assign, readonly ,getter=isAvailable) BOOL available;

@end

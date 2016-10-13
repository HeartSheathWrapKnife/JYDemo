//
//  SLLocationTool.m
//  NBG
//
//  Created by Seven Lv on 16/3/28.
//  Copyright © 2016年 Seven Lv. All rights reserved.
//

#import "SLLocationManager.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface SLLocationManager () <BMKLocationServiceDelegate>
//@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,   copy) void(^complete)(NSString *cityName, CLLocationCoordinate2D coordinate);
@property (nonatomic, strong) BMKLocationService * locationManager;
@end

static SLLocationManager *_manager = nil;

@implementation SLLocationManager



+ (instancetype)sharedManager
{
    if (_manager == nil) {
        _manager = [[self alloc] init];
    }
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

///  定位
- (void)startLocation:(void(^)(NSString *cityName, CLLocationCoordinate2D coordinate))complete {
    
    
//    if (![CLLocationManager locationServicesEnabled]) {
//        NSString * message = @"定位服务不可用，是否前往开启定位服务？";
//        [TSGlobalTool alertWithTitle:@"提示" message:message cancelButtonTitle:@"取消" OtherButtonsArray:@[@"确定"] clickAtIndex:^(NSInteger buttonIndex) {
//            if (buttonIndex == 1) {
//                NSURL * url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }];
//        return;
//    }
    
    self.complete = complete;
    [self.locationManager startUserLocationService];
    
}

#pragma mark CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [manager stopUpdatingLocation];
    
    _available = YES;
    
    // 1.取出位置对象
    CLLocation *loc = [locations firstObject];
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    __block NSString *city = nil;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0)  {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            USER.locationCity = city;
            // 发送结果
            !self.complete ?nil: self.complete(city, coordinate);
            self.complete = nil;
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[@"lng"] = @(coordinate.longitude);
            dict[@"lat"] = @(coordinate.latitude);
            dict[@"city"] = city;
            SLLog(city);
//            BOOL su = [User saveUseDefaultsOjbect:dict forKey:kCityKey];
//            USER.location[@"lat"] = @(coordinate.latitude);
//            USER.location[@"lng"] = @(coordinate.longitude);
//            SLLog2(@"saveUseDefaultsOjbect---%d", su);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    
    _available = NO;
    switch([error code]) {
        case kCLErrorDenied: {
            //Access denied by user prefs:root=LOCATION_SERVICES
            NSString * message = @"用户未授权，是否前往开启定位授权？";
            [TSGlobalTool alertWithTitle:@"提示" message:message cancelButtonTitle:@"取消" OtherButtonsArray:@[@"确定"] clickAtIndex:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    NSURL * url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
            break;
        case kCLErrorLocationUnknown:
        default: {
            
            errorString = @"定位失败";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorString delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
    }
    
}

#pragma mark - 百度地图代理

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    [self.locationManager stopUserLocationService];
    
    // 1.取出位置对象
    CLLocation *loc = [userLocation location];
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    __block NSString *city = nil;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0)  {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            USER.locationCity = city;
            // 发送结果
            !self.complete ? : self.complete(city, coordinate);
            self.complete = nil;
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[@"lng"] = @(coordinate.longitude);
            dict[@"lat"] = @(coordinate.latitude);
            dict[@"city"] = city;
            SLLog(city);
//            BOOL su = [User saveUseDefaultsOjbect:dict forKey:kCityKey];
//            USER.location[@"lat"] = @(coordinate.latitude);
//            USER.location[@"lng"] = @(coordinate.longitude);
//            SLLog2(@"saveUseDefaultsOjbect---%d", su);
        }
    }];

}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSString *errorString;
    [self.locationManager stopUserLocationService];
    
    _available = NO;
    switch([error code]) {
        case kCLErrorDenied: {
            //Access denied by user prefs:root=LOCATION_SERVICES
            NSString * message = @"用户未授权，是否前往开启定位授权？";
            [TSGlobalTool alertWithTitle:@"提示" message:message cancelButtonTitle:@"取消" OtherButtonsArray:@[@"确定"] clickAtIndex:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    NSURL * url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
            break;
        case kCLErrorLocationUnknown:
        default: {
            
            errorString = @"定位失败";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorString delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
    }
}

- (BMKLocationService *)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[BMKLocationService alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}
@end

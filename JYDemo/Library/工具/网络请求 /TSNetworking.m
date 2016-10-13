//
//  TSNetworking.m
//  TSNetworking
//
//  Created by Seven Lv on 15/12/22.
//  Copyright © 2015年 Seven. All rights reserved.
//

#import "TSNetworking.h"
NSString * const kAPIBaseURL = @"http://wash-cis.toocms.com/";


static TSHTTPSessionManager *_manager = nil;
@implementation TSHTTPSessionManager

+ (instancetype)sharedManager
{
    if (_manager == nil) {
        _manager = [[self alloc] init];
    }
    return _manager;
}
- (instancetype)init
{
    return [super initWithBaseURL:[NSURL URLWithString:kAPIBaseURL]
             sessionConfiguration:nil];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

@end

@implementation TSNetworking
#pragma mark - Public

+ (void)GETWithURL:(NSString *)urlString
            params:(NSDictionary *)params
     completeBlock:(void (^)(id))success
         failBlock:(void (^)(NSError *))failure
{
    TSHTTPSessionManager * manager = [TSHTTPSessionManager sharedManager];
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    TSLog2(@"请求参数：\n%@\nURL:%@", params,urlString);
    [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
      
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud removeFromSuperview];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud removeFromSuperview];
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)POSTWithURL:(NSString *)urlString
             params:(NSDictionary *)params
      completeBlock:(void (^)(id))success
          failBlock:(void (^)(NSError *))failure
{
    TSHTTPSessionManager * manager = [TSHTTPSessionManager sharedManager];
    
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    TSLog2(@"请求参数：\n%@\nURL:%@", params,urlString);
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud removeFromSuperview];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud removeFromSuperview];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTImageWithURL:(NSString *)urlString
                  params:(NSDictionary *)params
                   image:(UIImage *)image
              imageParam:(NSString *)imageParam
           completeBlock:(void (^)(id))success
               failBlock:(void (^)(NSError *))failure
{
    TSHTTPSessionManager * manager = [TSHTTPSessionManager sharedManager];
    
    TSLog(params);
    MBProgressHUD * hud = [MBProgressHUD showMessage:nil];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 文件二进制数据
        NSData * data = UIImageJPEGRepresentation(image, 0.1);
        // 文件名
        NSString * fileName = [self getfileNameWithIndex:0];
        
        [formData appendPartWithFileData:data name:imageParam fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud removeFromSuperview];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud removeFromSuperview];
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  获取文件的mineType（文件需要在mainBundle中）
 *
 *  @param fileName 文件名（含拓展名）
 *
 *  @return mineType
 */
+ (NSString *)getFileMineType:(NSString *)fileName {
    
//    NSURL * url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
//    
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    
//    __block NSURLResponse * res = nil;
//    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        res = response;
//    }];
//    
//    return res.MIMEType;
    
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse * response = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    return response.MIMEType;
}

+ (void)GETWithURL:(NSString *)urlString
       paramsModel:(id)params
     completeBlock:(void (^)(id))success
         failBlock:(void (^)(NSError *))failure
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    [self GETWithURL:urlString
              params:[params keyValues]
       completeBlock:success
           failBlock:failure];
#pragma clang diagnostic pop
}

+ (void)POSTWithURL:(NSString *)urlString
        paramsModel:(id)params
      completeBlock:(void (^)(id))success
          failBlock:(void (^)(NSError *))failure
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    
    [self POSTWithURL:urlString
               params:[params keyValues]
        completeBlock:success
            failBlock:failure];
#pragma clang diagnostic pop
    

}

+ (void)POSTImageWithURL:(NSString *)urlString
             paramsModel:(id)params
                   image:(UIImage *)image
              imageParam:(NSString *)imageParam
           completeBlock:(void (^)(id))success
               failBlock:(void (^)(NSError *))failure
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    [self POSTImageWithURL:urlString
                    params:[params keyValues]
                     image:image
                imageParam:imageParam
             completeBlock:success
                 failBlock:failure];
#pragma clang diagnostic pop
}

+ (void)POSTImagesWithURL:(NSString *)urlString
              paramsModel:(id)params
                   images:(NSArray *)images
               imageParam:(NSString *)imageParam
            completeBlock:(void (^)(id))success
                failBlock:(void (^)(NSError *))failure
{
    TSHTTPSessionManager * manager = [TSHTTPSessionManager sharedManager];
    
    TSLog(params);
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            
            UIImage * image = images[i];
            // 文件二进制数据
            NSData * data = UIImageJPEGRepresentation(image, 0.1);
            // 文件名
            NSString * fileName = [self getfileNameWithIndex:i + 1];
            
            // 图片对应的参数
            NSString * imageP = [NSString stringWithFormat:@"%@%d", imageParam, i];
            // 拼接图片数据
            [formData appendPartWithFileData:data name:imageP fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - Private
/**
 *  产生图片名字
 */
+ (NSString *)getfileNameWithIndex:(int)index
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMddHHmmss";
    NSString * date = [format stringFromDate:[NSDate date]];
    return [date stringByAppendingFormat:@"%@%d.jpg",[date MD5String], index];
}


@end

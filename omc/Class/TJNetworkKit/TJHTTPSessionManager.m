//
//  TJHTTPSessionManager.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJHTTPSessionManager.h"
#import "TJURLConfigurator.h"

static TJHTTPSessionManager *sharedInstance = nil;

@implementation TJHTTPSessionManager
{
    NSInteger _requestCount;
}


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[TJHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:[TJURLConfigurator shareConfigurator].baseURL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        sharedInstance.defaulRequesetSerializer = [AFHTTPRequestSerializer serializer];
        
        sharedInstance.requestSerializer = sharedInstance.defaulRequesetSerializer;
        
        sharedInstance.requestSerializer.timeoutInterval = 60;
        
    });
    return sharedInstance;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    _requestCount += 1;
    
    [self setNetworkActivityIndicatorVisible];
    
    return  [super POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        _requestCount -= 1;
        
        [self setNetworkActivityIndicatorVisible];
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        _requestCount -= 1;
        
        [self setNetworkActivityIndicatorVisible];
        
        if (failure) {
            failure(task, error);
        }
        
    }];
}



- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    _requestCount += 1;
    
    [self setNetworkActivityIndicatorVisible];
    
    return  [super GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        _requestCount -= 1;
        
        [self setNetworkActivityIndicatorVisible];
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        _requestCount -= 1;
        
        [self setNetworkActivityIndicatorVisible];
        
        if (failure) {
            failure(task, error);
        }
        
    }];
    
}


//设置网络菊花
- (void)setNetworkActivityIndicatorVisible {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = _requestCount ? YES : NO;
}
@end

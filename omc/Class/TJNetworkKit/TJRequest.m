//
//  TJRequest.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJURLConfigurator.h"
#import "TJTokenManager.h"
#import "TJToolKit.h"
#import "TJRequest.h"
#import "TJSettingTask.h"
@interface TJRequest ()

/**
 *  网络请求结束后请求结果的分析
 *
 *  @param params         传给服务端的参数
 *  @param task           NSURLSessionDataTask实例
 *  @param responseObject 服务端返回的数据
 *  @param error          网络请求失败的错误信息
 *  @param successBlock   接口获取数据成功的回调
 *  @param failureBlock   接口获取数据失败的回调
 */
- (void)requestFinishedWithParams:(NSDictionary *)params task:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error SuccessBlock:(TJRequestFinishedBlock)successBlock failureBlock:(TJRequestFinishedBlock)failureBlock;

@end

@implementation TJRequest
#pragma mark - Lifecycle
- (void)dealloc {
    
//    NSLog(@"TJRequest Dealloc");
}


+ (void)initialize {
    
    [super initialize];
    
    TJHTTPSessionManager * manager = [TJHTTPSessionManager sharedInstance];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
}



- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _requestURL = [[TJURLConfigurator shareConfigurator] requestURL];
    }
    
    return self;
}

#pragma mark - Public Methods
- (void)startWithURLString:(NSString *)urlString
                    Params:(id)params
              successBlock:(TJRequestFinishedBlock)successBlock {
    
    [self startWithURLString:urlString
                      Params:params
                successBlock:successBlock
                failureBlock:^(TJResult *result) {
        
    }];
}
- (void)startWithURLString:(NSString *)urlString
                    Params:(id)params
              successBlock:(TJRequestFinishedBlock)successBlock
              failureBlock:(TJRequestFinishedBlock)failureBlock {
    
    if (self.task) {
        
        [self cancel];
    }
    
    
    // 设置Header
    TJHTTPSessionManager * manager = [TJHTTPSessionManager sharedInstance];
    if (self.header) {
        for (NSString *httpHeaderField in self.header.allKeys) {
            NSString *value = self.header[httpHeaderField];
            [manager.defaulRequesetSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    manager.requestSerializer = manager.defaulRequesetSerializer;
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    
    
    
    
#if TH_REQUEST_HEADER_ENABLE
    
    NSLog(@"============= HEADER =============\n\n%@\n\n", headerInfo);
    
#endif
    
    
    if (self.requestType == TJHTTPReuestTypeNone) {
        
        self.requestType = TJHTTPReuestTypePOST;
    }
    
    
    switch (self.requestType) {
            
        case TJHTTPReuestTypeNone:
        {
            
        }
            break;
            
        case TJHTTPReuestTypeOPTIONS:
        {
            
        }
            break;
            
        case TJHTTPReuestTypeHEAD:
        {
            self.task = [manager HEAD:urlString parameters:params success:^(NSURLSessionDataTask *task) {
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:nil SuccessBlock:successBlock failureBlock:failureBlock];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
        }
            break;
            
        case TJHTTPReuestTypeGET:
        {
           self.task = [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
                
            }];

        }
            break;
            
        case TJHTTPReuestTypePOST:
        {
            
#if THRunTestMode
            
            NSDate * timeoutDate = [NSDate dateWithTimeIntervalSinceNow:10];
            
            __block BOOL responseHasArrived = NO;
            
#endif

            self.task = [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
#if THRunTestMode
                
                responseHasArrived = YES;
#endif
                
                [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
#if THRunTestMode
                
                responseHasArrived = YES;
#endif
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
            
            
#if THRunTestMode
            
            while (responseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0)) {
                
                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
            }
            
            
            if (responseHasArrived == NO) {
                NSLog(@"服务超时");
            }
            
#endif
        }
            break;
            
        case TJHTTPReuestTypePUT:
        {
            self.task = [manager PUT:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
        }
            break;
            
        case TJHTTPReuestTypeDELETE:
        {
            self.task = [manager DELETE:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
        }
            break;
            
        case TJHTTPReuestTypeTRACE:
        {
            
        }
            break;
            
        case TJHTTPReuestTypeCONNECT:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)cancel {
    
    if (self.task) {
        
        [self.task cancel];
    }
    
    self.task = nil;
}

- (void)uploadWithURLString:(NSString *)urlString
                     images:(NSDictionary *)images
                     Params:(id)params
              progressBlock:(void(^)(NSProgress *progress))progressBlock
               successBlock:(TJRequestFinishedBlock)successBlock
               failureBlock:(TJRequestFinishedBlock)failureBlock {
    
    if (self.task) {
        
        [self cancel];
    }
    
    TJHTTPSessionManager *manager = [TJHTTPSessionManager sharedInstance];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    //设置超时 和token
    manager.requestSerializer.timeoutInterval = 30;
    

    NSString * cookieValue = [NSString stringWithFormat:@"Bearer %@", [TJTokenManager sharedInstance].token];
    [manager.requestSerializer setValue:cookieValue forHTTPHeaderField:@"Authorization"];
    
    self.task = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        if (images) {
            NSArray *allKeys = [images allKeys];
            [allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *imageKey = obj;
                NSData *imageData = [images valueForKey:imageKey];
                [formData appendPartWithFileData:imageData name:imageKey fileName:imageKey mimeType:@"image/jpeg"];
            }];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
        
    }];
}

#pragma mark - Private Methods
#pragma mark 网络请求结束后请求结果的分析
- (void)requestFinishedWithParams:(NSDictionary *)params task:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error SuccessBlock:(TJRequestFinishedBlock)successBlock failureBlock:(TJRequestFinishedBlock)failureBlock {
    
    
//    TJRequestLog(@"======================     REQUEST      ======================\n\n%@\n\n%@\n\n", self.requestURL, params);
    
    
    NSInteger responseCode  = error.code;
    NSHTTPURLResponse * response = (NSHTTPURLResponse*)task.response;
    NSInteger statusCode = response.statusCode;
    
    
    
    if (statusCode == TJStatusCodeTypeRequsetSuccess) {
        
//        TJRequestLog(@"====================== RESPONSE SUCCESS ======================\n\n%@\n\n", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            TJResult * result = [TJResult resultFromResponseObject:responseObject];
            
            if (result.success) {
                
                successBlock(result);
                
            } else {
                
                if (result.errcode == TJResponseCodeError) {
                    
                    // 判断服务器是否处于维护中
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"TJServerIsMaintainedNotificationName" object:nil userInfo:nil];
                    
                }
                
                // 服务器未返回错误问题
                if ([StringUtil isEmpty:result.message]) {
                    
                    result.message = @"服务端发生异常，请稍后再试";
                }
                
                //token超时
                if (result.errcode == TJResponseCodeTokenTimeout && [[TJTokenManager sharedInstance]isLogin]) {
//                    //刷新token
                    [TJSettingTask refreshTokenWithSuccessBlock:^(TJResult *result) {
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            
                            //重新请求
                            NSURLSession *session = [NSURLSession sharedSession];
                            
                            
                            NSMutableDictionary *allHTTPHeaderFields =  task.originalRequest.allHTTPHeaderFields.mutableCopy;
                            
                            [allHTTPHeaderFields setValue:[NSString stringWithFormat:@"Bearer %@", [TJTokenManager sharedInstance].token] forKey:@"Authorization"];
                            
                            NSMutableURLRequest *request = task.originalRequest.mutableCopy;
                            
                            request.allHTTPHeaderFields = allHTTPHeaderFields.copy;
                            
                            __block NSURLSessionDataTask *newTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                id responseObject = data;
                                if (data) {
                                    
                                    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                    
                                    responseObject = jsonDict;
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [self requestFinishedWithParams:params task:newTask responseObject:responseObject error:error SuccessBlock:successBlock failureBlock:failureBlock];
                                });
                            }];
                            [newTask resume];
                        });
                    } failureBlock:^(TJResult *result) {
                        
                    }];
                   
                    return;
                    
                }
                
                if (result.errcode == TJResponseCodeRefreshTokenTimeout && [[TJTokenManager sharedInstance]isLogin]) {
                    result.message = @"您登录已超时，请重新登录";
                    
                    [[TJTokenManager sharedInstance] logout];
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController popToRootViewControllerAnimated:YES];
                    
                }
                
                failureBlock(result);
            }
        }
        
    } else if (statusCode == TJStatusCodeTypeSessionTimeOut) {
        
        // 网络请求失败
//        THRequestLog(@"====================== RESPONSE TOKEN TIMEOUT ======================\n\n");
//        

        
        TJResult * result = [TJResult new];
        result.errcode = statusCode;
        result.message = @"您登录已超时，请重新登录";

        
        failureBlock(result);
        return;
        
    } else  {
        
        // 网络请求失败
//        THRequestLog(@"====================== RESPONSE FAILURE ======================\n\n%d\n\n", (int)error.code);
        
        if (error) {
            
            switch (responseCode) {
                    
                case kCFURLErrorTimedOut:
                case kCFURLErrorBadServerResponse: {
                    
                    TJResult * result = [TJResult new];
                    result.errcode = responseCode;
                    result.message = @"网络请求超时";
                    failureBlock(result);
                    break;
                }
                    
                case kCFURLErrorCannotConnectToHost:
                case kCFURLErrorNotConnectedToInternet: {
                    //网络无法连接
                    TJResult * result = [TJResult new];
                    result.errcode = responseCode;
                    result.message = @"网络异常，请稍后再试";
                    failureBlock(result);
                    
                    break;
                }
                    
                case kCFURLErrorCancelled: {
                    // 用户手动取消不做任何处理
                    return;
                    break;
                }
                    
                default: {
                    
                    TJResult * result = [TJResult new];
                    result.errcode = responseCode;
                    result.message = @"服务端发生异常，请稍后再试";
                    failureBlock(result);
                    
                    break;
                }
            }
            
        } else {
            
            TJResult * result = [TJResult resultFromResponseObject:responseObject];
            result.message = @"服务端发生异常，请稍后再试";
            failureBlock(result);
        }
    }
}
@end

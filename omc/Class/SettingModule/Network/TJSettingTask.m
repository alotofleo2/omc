//
//  TJSettingTask.m
//  omc
//
//  Created by 方焘 on 2018/3/6.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingTask.h"
#import "TJSettingDefines.h"

@implementation TJSettingTask
#pragma mark 登录接口
+ (TJRequest *)loginWithUserName:(NSString *)userName
                        password:(NSString *)password
                    SuccessBlock:(void (^)(TJResult *result))successBlock
                    failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    
    NSDictionary * params = @{@"username" : userName ?: @"",
                              @"password" : password ?: @"",
                              };
    [request startWithURLString:kSetting_login Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

#pragma mark 刷新token
+ (TJRequest *)refreshTokenWithSuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    
    NSDictionary * params = @{
                              
                              };
    [request startWithURLString:kSetting_login Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
#pragma mark 退出登录
+ (TJRequest *)logoutWithSuccessBlock:(void (^)(TJResult *result))successBlock
                         failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    
    [request startWithURLString:kSetting_logout Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
#pragma mark 获取用户资料
+ (TJRequest *)getPersonalDataWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                  failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    
    [request startWithURLString:kSetting_personals Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

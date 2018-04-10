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
    
    
    NSDictionary * params = @{@"longToken" : [TJTokenManager sharedInstance].longToken ?: @""
                              };
    [request startWithURLString:KSetting_refreshToken Params:params successBlock:^(TJResult *result) {
         [[TJTokenManager sharedInstance] updateTokenWithInfo:result.data];
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

#pragma mark 发送验证码
+ (TJRequest *)getAuthCodeWithPhone:(NSString *)phone
                               type:(NSString *)type
                       SuccessBlock:(void (^)(TJResult *result))successBlock
                       failureBlock:(TJRequestFinishedBlock)failureBlock{
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    NSDictionary * params = @{@"phone" : phone ?: @"",
                              @"use"  : type ?:@""
                              };
    [request startWithURLString:kSetting_authCode Params:params successBlock:^(TJResult *result) {

        if (successBlock) successBlock(result);

    } failureBlock:^(TJResult *result) {

        if (failureBlock) failureBlock(result);

    }];
    
    return request;
}
#pragma mark 忘记密码
+ (TJRequest *)forgetPasswordWithPhone:(NSString *)phone
                              authCode:(NSString *)authCode
                           newPassword:(NSString *)newPassword
                          SuccessBlock:(void (^)(TJResult *result))successBlock
                          failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    NSDictionary * params = @{@"phone" : phone ?: @"",
                              @"code"  : authCode ?:@"",
                              @"newPwd"      : newPassword ?: @""
                              };
    [request startWithURLString:kSetting_forgets Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

#pragma mark 修改手机号
+ (TJRequest *)changePhoneNumberWithNewphone:(NSString *)newPhone
                                    authCode:(NSString *)authCode
                                SuccessBlock:(void (^)(TJResult *result))successBlock
                                failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    NSDictionary * params = @{@"newPhone" : newPhone ?: @"",
                              @"code"  : authCode ?:@"",
                              };
    [request startWithURLString:KSetting_changePhoneNumber Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

#pragma mark 获取消息接口
+ (TJRequest *)getMessageWithPageNumber:(NSInteger)pageNumber
                           SuccessBlock:(void (^)(TJResult *result))successBlock
                           failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    NSDictionary * params = nil;
    if (pageNumber > 0) {
        params = @{@"page" : @(pageNumber).stringValue,
                   };
    }
    [request startWithURLString:KSetting_notices Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

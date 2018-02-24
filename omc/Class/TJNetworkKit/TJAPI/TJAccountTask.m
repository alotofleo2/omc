//
//  TJAccountTask.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/16.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJAccountTask.h"
#import "TJAccountDefines.h"
#import "TJDeviceInfo.h"
#import "TJPageManager.h"
#import "MJExtension.h"


@implementation TJAccountTask

//#pragma mark 短信验证码
//+ (TJRequest *)sendDynamicCodeMessageWithPhoneNumber:(NSString *)phoneNumber
//                                      messageType:(TJMessageCodeType)messageType
//                                     successBlock:(void(^)(TJResult *result))successBlock
//                                     failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    NSDictionary * params = @{@"phone":phoneNumber,
//                              };
//    
//    NSString *url = nil;
//    
//    switch (messageType) {
//        case TJMessageCodeTypeRegister:
//            url = kTJAccount_sendRegistCode;
//            break;
//        case TJMessageCodeTypeForgetPassword:
//            url = kTJAccount_sendForgetCode;
//            break;
//            
//        default:
//            break;
//    }
//    
//    [request startWithURLString:url Params:params successBlock:^(TJResult *result) {
//        
//        
//        if (successBlock) successBlock(result);
//        [TJAlertUtil showNotificationWithTitle:@"成功" message:@"验证码发送成功" type:TJMessageNotificationTypeSuccess];
//        
//    } failureBlock:^(TJResult *result) {
//        
//        [TJAlertUtil showNotificationWithTitle:@"错误" message:result.message type:TJMessageNotificationTypeError];
//        
//        
//        if (failureBlock) failureBlock(result);
//    }];
//    
//    return request;
//}
//
//#pragma mark 注册
//+ (TJRequest *)registWithPhoneNumber:(NSString *)phoneNumber
//                          verifiCode:(NSString *)verifiCode
//                            password:(NSString *)password
//                        successBlock:(void(^)(TJResult *result))successBlock
//                        failureBlock:(TJRequestFinishedBlock)failureBlock {
//    
//    
//    //密码加密
//    password = [password md5Password];
//    
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    //参数插入系统信息
//    NSMutableDictionary *deviceInfo = [[TJDeviceInfo generateDeviceInfo] mutableCopy];
//    
//    NSDictionary *params = @{@"phone":phoneNumber,
//                             @"code":verifiCode,
//                             @"password":password,
//                             @"device":@"IOS",
//                             @"device_id":[UIDevice currentDevice].identifierForVendor.UUIDString,
//                                    };
//    [deviceInfo addEntriesFromDictionary:params];
//    
//    params = deviceInfo.copy;
//    
//    //开始请求
//    [request startWithURLString:kTJAccount_register Params:params successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//    
//}
//
//
//#pragma mark 登录
//+ (TJRequest *)loginWithPhoneNumber:(NSString *)phoneNumber
//                           password:(NSString *)password
//                       successBlock:(void(^)(TJResult *result))successBlock
//                       failureBlock:(TJRequestFinishedBlock)failureBlock {
//    
//    TJRequest *request = [[TJRequest alloc]init];
//    request.requestType = TJHTTPReuestTypePOST;
//    
//    //密码加密
//    password = [password md5Password];
//    
//    NSDictionary * params = @{@"phone":phoneNumber,
//                              @"password":password,
//                              @"device":@"IOS",
//                              @"device_id":[UIDevice currentDevice].identifierForVendor.UUIDString,
//                              };
//    
//    [request startWithURLString:kTJAccount_login Params:params successBlock:^(TJResult *result) {
//        
//        [[TJTokenManager sharedInstance] updateTokenWithInfo:result.data];
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//       
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//
//
//
//
//
//#pragma mark 忘记密码API
//+ (TJRequest *)forgetPasswordWithPhoneNumber:(NSString *)phoneNumber
//                                  verifiCode:(NSString *)verifiCode
//                                    password:(NSString *)password
//                                successBlock:(void (^)(TJResult *result))successBlock
//                                failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    //密码加密
//    password = [password md5Password];
//    
//    NSDictionary * params = @{@"phone":phoneNumber?:@"",
//                              @"code":verifiCode?:@"",
//                              @"password":password?:@"",
//                              @"device":@"IOS",
//                              @"device_id":[UIDevice currentDevice].identifierForVendor.UUIDString,
//                              };
//    
//    [request startWithURLString:kTJAccount_forget Params:params successBlock:^(TJResult *result) {
//        
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//
//
//#pragma mark 刷新token
//+ (TJRequest *)refreshTokenWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                               failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    NSDictionary * params = @{
//                              @"access_token":[TJTokenManager sharedInstance].accessToken,
//                              @"refresh_token":[TJTokenManager sharedInstance].refreshToken,
//                              };
//    
//    [request startWithURLString:kTJAccount_refreshToken Params:params successBlock:^(TJResult *result) {
//        
//        [[TJTokenManager sharedInstance] updateTokenWithInfo:result.data];
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//
//#pragma mark 退出登录
//+ (TJRequest *)logoutWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                         failureBlock:(TJRequestFinishedBlock)failureBlock {
//    
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    [request startWithURLString:kTAccount_logout Params:nil successBlock:^(TJResult *result) {
//        
//        
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//#pragma mark 获取用户信息
//+ (TJRequest *)getUserInfoWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock {
//    
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    [request startWithURLString:kTAccount_info Params:nil successBlock:^(TJResult *result) {
//        
//        [[TJUserModel sharedInstance]updateUserInfo:result.data];
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark 获取首页信息
//+ (TJRequest *)getCreditListWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                                failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    [request startWithURLString:kTAccount_allReports Params:nil successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark 上传通讯录
//+ (TJRequest *)uploadAddresstWithAddressJsonString:(NSString *)string
//                                          isUpdate:(BOOL)isupdate
//                                      successBlock:(void (^)(TJResult *result))successBlock
//                                      failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypePOST;
//    
//    NSDictionary * params = @{
//                              @"addressBook":string ?: @"",
//                              @"update":@(isupdate),
//                              };
//    
//    [request startWithURLString:kTAccount_address_upload Params:params successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark 检查报告状态
///**
// *  检查报告状态
// */
//+ (TJRequest *)checkReporttWithAuId:(NSInteger)auid
//                           reportId:(NSString *)reportId
//                       successBlock:(void (^)(TJResult *result))successBlock
//                       failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    NSDictionary * params = @{
//                              @"auId":[NSString stringWithFormat:@"%05ld", (long)auid],
//                              @"reportId": reportId?:@"",
//                              };
//    
//    [request startWithURLString:kTAccount_checkReport Params:params successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark 查询消息API
//+ (TJRequest *)getMessagePageWithPageIndex:(NSInteger)pageIndex
//                                  pageSize:(NSInteger)pageSize
//                              successBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    NSDictionary * params = @{
//                              @"pageIndex":[NSString stringWithFormat:@"%lu", pageIndex],
//                              @"pageSize": [NSString stringWithFormat:@"%lu", pageSize],
//                              };
//    
//    [request startWithURLString:kTAccount_messgae_page Params:params successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark alpha计算点击
//+ (TJRequest *)calculateAlphaSuccessBlock:(void (^)(TJResult *result))successBlock
//                             failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    
//    [request startWithURLString:kTAccount_calculateAlpha Params:nil successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
//
//#pragma mark alpha报告
//+ (TJRequest *)alphaReportWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock {
//    TJRequest *request = [[TJRequest alloc]init];
//    
//    request.requestType = TJHTTPReuestTypeGET;
//    
//    
//    [request startWithURLString:kTAccount_searchAlpha_report Params:nil successBlock:^(TJResult *result) {
//        
//        if (successBlock) successBlock(result);
//        
//    } failureBlock:^(TJResult *result) {
//        
//        if (failureBlock) failureBlock(result);
//        
//    }];
//    
//    return request;
//}
@end

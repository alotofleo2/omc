//
//  TJAccountTask.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/16.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJRequest.h"

typedef void (^TJRequestFinishedBlock)(TJResult * result);

/**
 *  发送短信验证码的类型
 */
typedef NS_ENUM(NSInteger, TJMessageCodeType) {
    
    /**
     *  注册
     */
    TJMessageCodeTypeRegister = 1001,
    /**
     *  快速登录
     */
    TJMessageCodeTypeFastLogin,
    /**
     *  手机绑定
     */
    TJMessageCodeTypeMobileBiding,
    /**
     *  忘记登录密码
     */
    TJMessageCodeTypeForgetPassword,
    /**
     *  修改密码
     */
    TJMessageCodeTypeChangePassword,

};

/**
 *  账号API类
 */
@interface TJAccountTask : NSObject

///**
// *  验证码API
// */
//+ (TJRequest *)sendDynamicCodeMessageWithPhoneNumber:(NSString *)phoneNumber
//                                         messageType:(TJMessageCodeType)messageType
//                                        successBlock:(void(^)(TJResult *result))successBlock
//                                        failureBlock:(TJRequestFinishedBlock)failureBlock;
//
//
///*
// *  注册API
// */
//+ (TJRequest *)registWithPhoneNumber:(NSString *)phoneNumber
//                          verifiCode:(NSString *)verifiCode
//                            password:(NSString *)password
//                        successBlock:(void(^)(TJResult *result))successBlock
//                        failureBlock:(TJRequestFinishedBlock)failureBlock;
//
//
///**
// *  登录API
// */
//+ (TJRequest *)loginWithPhoneNumber:(NSString *)phoneNumber
//                            password:(NSString *)password
//                        successBlock:(void(^)(TJResult *result))successBlock
//                        failureBlock:(TJRequestFinishedBlock)failureBlock;
//
//
///**
// *  忘记密码API
// */
//+ (TJRequest *)forgetPasswordWithPhoneNumber:(NSString *)phoneNumber
//                                  verifiCode:(NSString *)verifiCode
//                                    password:(NSString *)password
//                                successBlock:(void(^)(TJResult *result))successBlock
//                                failureBlock:(TJRequestFinishedBlock)failureBlock;
//
//
///**
// *  刷新token
// */
//+ (TJRequest *)refreshTokenWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                               failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  退出系统
// */
//+ (TJRequest *)logoutWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                         failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  获取用户信息
// */
//+ (TJRequest *)getUserInfoWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  获取首页信息
// */
//+ (TJRequest *)getCreditListWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                                failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  上传通讯录
// */
//+ (TJRequest *)uploadAddresstWithAddressJsonString:(NSString *)string
//                                          isUpdate:(BOOL)isupdate
//                                      successBlock:(void (^)(TJResult *result))successBlock
//                                      failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  检查报告状态
// */
//+ (TJRequest *)checkReporttWithAuId:(NSInteger)auid
//                           reportId:(NSString *)reportId
//                       successBlock:(void (^)(TJResult *result))successBlock
//                       failureBlock:(TJRequestFinishedBlock)failureBlock;
//
//
// /**
//  查询消息
//
//  @param pageIndex 查询页数(默认第一页)
//  @param pageSize 每页显示数量(默认20条)
//  
//  */
//
//+ (TJRequest *)getMessagePageWithPageIndex:(NSInteger)pageIndex
//                                  pageSize:(NSInteger)pageSize
//                              successBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  alpha计算点击
// */
//+ (TJRequest *)calculateAlphaSuccessBlock:(void (^)(TJResult *result))successBlock
//                             failureBlock:(TJRequestFinishedBlock)failureBlock;
//
///**
// *  alpha报告
// */
//+ (TJRequest *)alphaReportWithSuccessBlock:(void (^)(TJResult *result))successBlock
//                              failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

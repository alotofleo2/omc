//
//  TJSettingTask.h
//  omc
//
//  Created by 方焘 on 2018/3/6.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TJRequestFinishedBlock)(TJResult * result);
@interface TJSettingTask : NSObject

/**
 登录接口

 @param userName 用户名
 @param password 密码
 */
+ (TJRequest *)loginWithUserName:(NSString *)userName
                        password:(NSString *)password
                    SuccessBlock:(void (^)(TJResult *result))successBlock
                    failureBlock:(TJRequestFinishedBlock)failureBlock;

//刷新token
+ (TJRequest *)refreshTokenWithSuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock;

//退出登录
+ (TJRequest *)logoutWithSuccessBlock:(void (^)(TJResult *result))successBlock
                         failureBlock:(TJRequestFinishedBlock)failureBlock;

//获取用户资料
+ (TJRequest *)getPersonalDataWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                  failureBlock:(TJRequestFinishedBlock)failureBlock;
/**
 发送验证码

 @param phone 电话号码
 @param type 验证码类型 (forget, )
 */
+ (TJRequest *)getAuthCodeWithPhone:(NSString *)phone
                               type:(NSString *)type
                      SuccessBlock:(void (^)(TJResult *result))successBlock
                      failureBlock:(TJRequestFinishedBlock)failureBlock;


/**
 忘记密码

 @param phone 电话号码
 @param authCode 验证码
 @param newPassword 新密码

 */
+ (TJRequest *)forgetPasswordWithPhone:(NSString *)phone
                              authCode:(NSString *)authCode
                           newPassword:(NSString *)newPassword
                          SuccessBlock:(void (^)(TJResult *result))successBlock
                          failureBlock:(TJRequestFinishedBlock)failureBlock;
/**
 修改手机号
 
 @param newPhone 电话号码
 @param authCode 验证码

 
 */
+ (TJRequest *)changePhoneNumberWithNewphone:(NSString *)newPhone
                                    authCode:(NSString *)authCode
                                SuccessBlock:(void (^)(TJResult *result))successBlock
                                failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

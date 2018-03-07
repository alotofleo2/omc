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


@end

//
//  TJInputChecker.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/30.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJInputChecker : NSObject

/**
 *  检测登录密码是否符合规范（使用时检测）
 *
 *  @param  loginPassword 登录密码
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkLoginPassword:(NSString *)loginPassword;


/**
 *  检测登录密码和确认登录密码（设置或重置）是否符合规范
 *
 *  @param  loginPassword            登录密码
 *
 *  @param  confirmLoginpassword     确认登录密码
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkLoginPassword:(NSString *)loginPassword confirmLoginPassword:(NSString *)confirmLoginpassword;


/**
 *  检测交易密码是否符合规范（使用时检测）
 *
 *  @param  tradePassword  交易密码
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkTradePassword:(NSString *)tradePassword;

/**
 *  检测登录密码和确认登录密码（设置或重置）是否符合规范
 *
 *  @param  tradePassword             交易密码
 *
 *  @param  confirmTradepassword      确认交易密码
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkTradePassword:(NSString *)tradePassword confirmTradePassword:(NSString *)confirmTradepassword;


/**
 *  验证手机号是否符合规范
 *
 *  @param  phoneNumber  手机号
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;


/**
 *  验证短信验证是否符合规范
 *
 *  @param  smsverifyCode  短信验证码
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkSMSVerifyCode:(NSString *)smsverifyCode;


/**
 *  验证身份证号是否符合规范
 *
 *  @param  idCardNumber   身份证号
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkIDCardNumber:(NSString *)idCardNumber;


/**
 *  检测银行卡号是否符合规范
 *
 *  @param bankCardNumber 银行卡号
 *
 *  @return 是否符合规范
 */
+ (BOOL)checkBankCardNumber:(NSString *)bankCardNumber;



/**
 *  检测真实姓名输入是否符合规范
 *
 *  @param truxeName 真实姓名
 *
 *  @return 是否符合规范
 */
+ (BOOL)checkTrueName:(NSString *)truxeName;


/**
 *  验证邮箱是否符合规范
 *
 *  @param  mailBox    邮箱
 *
 *  @return 是否符合规范
 */

+ (BOOL)checkMailBox:(NSString *)mailBox;

@end

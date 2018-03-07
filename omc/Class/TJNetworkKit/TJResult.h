//
//  TJResult.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  请求成功
 */
#define TJResponseCodeSuccess 200

/**
 *  服务器错误
 */
#define TJResponseCodeError  500

/**
 *  Token超时
 */
#define TJResponseCodeTokenTimeout          401

/**
 *  Token刷新时超时
 */
#define TJResponseCodeRefreshTokenTimeout   407


/**
 *  Token为空
 */
#define TJResponseCodeTokenEmpty            40010

/**
 *  Token刷新时为空
 */
#define TJResponseCodeRefreshTokenEmpty     40011

/**
 *  用户名为空
 */
#define TJResponseCodeuserNameEmpty         40012

/**
 *  密码为空
 */
#define TJResponseCodePasswordEmpty         40013

/**
    设备号为空
 */
#define TJResponseCodeDeviceIdEmpty         40014

/**
    验证码为空
 */
#define TJResponseCodeverifiCodeEmpty       40016

/**
    手机号为空
 */
#define TJResponseCodePhoneNumberEmpty      40017



@interface TJResult : NSObject


/**
 *  请求操作相应码
 */
@property (nonatomic, assign) NSInteger  errcode;


/**
 *  请求状态的附带消息
 */
@property (nonatomic, copy) NSString * message;


/**
 *  服务端返回的数据
 */
@property (nonatomic, copy) NSDictionary * data;


+ (id)resultFromResponseObject:(NSDictionary *)responseObject;

- (BOOL)success;
@end

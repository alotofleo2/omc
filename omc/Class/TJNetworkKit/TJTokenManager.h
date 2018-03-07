//
//  TJTokenManager.h
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/4/18.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJBaseSharedInstance.h"


#define TJ_TOKEN_SIGN  @"token"
#define TJ_REFRESHTOKEN @"longToken"
#define TJ_TOKENTYPE @"token_type"
#define TJEXPIRESTIME @"expires_in"
@interface TJTokenManager : TJBaseSharedInstance

@property (nonatomic, strong) NSString *token;

@property (nonatomic, copy) NSString *longToken;

@property (nonatomic, copy) NSString *tokenType;

@property (nonatomic, copy) NSString *expiresTime;

/**
 是否登录状态
 */
- (BOOL)isLogin;


/**
 检查登录状态,如果未登录拉起登录
 */
- (BOOL)checkLogin;
/**
 *  登出
 */
- (void)logout;

- (void)updateTokenWithInfo:(NSDictionary *)info;

/**
 http Header 设置token

 @param token token
 @param typeName token的类型(格式所需)
 */
- (void)setCookieToken:(NSString *)token typeName:(NSString *)typeName;

/**
 http Header 设置version
 */
- (void)setCookieVersion:(NSString *)version;

- (NSString *)getWebCookieString;


@end

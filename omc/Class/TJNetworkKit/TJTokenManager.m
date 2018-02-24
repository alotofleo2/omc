//
//  TJTokenManager.m
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/4/18.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import "TJTokenManager.h"
#import "TJRouteManager.h"


@implementation TJTokenManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        self.accessToken = [userDefaults objectForKey:TJ_TOKEN_SIGN];
        self.refreshToken = [userDefaults objectForKey:TJ_REFRESHTOKEN];
        self.tokenType = [userDefaults objectForKey:TJ_TOKENTYPE];
        self.expiresTime = [userDefaults objectForKey:TJEXPIRESTIME];

        
        if (self.accessToken.length > 0 && self.tokenType.length > 0) {
            [self setCookieToken:self.accessToken typeName:self.tokenType];
        }
    }
    return self;
}

#pragma mark - Public Methods
#pragma mark 判断是否已登录
- (BOOL)isLogin {

    if (self.accessToken.length > 0) {
        
        return YES;
    } else {

        return NO;
    }
    
}

- (BOOL)checkLogin {
    if (self.isLogin) {
        
        return YES;
    } else {
        
//        [[TJRouteManager sharedInstance]parseWithUrl:url_TJ_to_login];

        return NO;
    }
}
- (void)updateTokenWithInfo:(NSDictionary *)info {
    /**
     *  token
     */
    if (![StringUtil isEmpty:[info objectForKey:TJ_TOKEN_SIGN]]) {
        self.accessToken= [info objectForKey:TJ_TOKEN_SIGN];
    }
    /**
     *  刷新token
     */
    if (![StringUtil isEmpty:[info objectForKey:TJ_REFRESHTOKEN]]) {
        self.refreshToken= [info objectForKey:TJ_REFRESHTOKEN];
    }
    /**
     *  cookie所需type
     */
    if (![StringUtil isEmpty:[info objectForKey:TJ_TOKENTYPE]]) {
        self.tokenType= [info objectForKey:TJ_TOKENTYPE];
    }
    /**
     *  token 到期时间
     */
    if (![StringUtil isEmpty:[[info objectForKey:TJEXPIRESTIME] stringValue]]) {
        self.expiresTime= [[info objectForKey:TJEXPIRESTIME] stringValue];
    }
    
    [self setCookieToken:self.accessToken typeName:self.tokenType];
    
    [self setLocalToken];
}



#pragma mark 登出
- (void)logout {
//    self.accessToken = @"";
//    self.refreshToken = @"";
//    self.tokenType = @"";
//    self.expiresTime = @"";
//    [self removeToken];
//
//    [self setCookieToken:self.accessToken typeName:self.tokenType];
//
//    [[TJUserModel sharedInstance] logout];
//
//    [[NSNotificationCenter defaultCenter]postNotificationName:TJLogoutNotificationName object:nil];
//    [TJProgressHUD showWithTitle:@"登录退出"];
}


#pragma mark 移除token
- (void)removeToken {
    
    // 清除所有的Token
    [self removeLocalToken];
    
}


- (NSString *)getWebCookieString {
   
    NSMutableString *cookieString = [[NSMutableString alloc]init];
    
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"token",self.accessToken];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"proUniId", [TJUserDefaultsManager proUniId]];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",TJ_REFRESHTOKEN,self.refreshToken];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",TJ_TOKENTYPE,self.tokenType];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"phone",[TJUserDefaultsManager username]];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"VersionName",[TJUserDefaultsManager currentVersion]];
    return cookieString.copy;
}


#pragma mark 本地缓存token
- (void)setLocalToken {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.accessToken forKey:TJ_TOKEN_SIGN];
    [userDefaults setValue:self.refreshToken forKey:TJ_REFRESHTOKEN];
    [userDefaults setValue:self.tokenType forKey:TJ_TOKENTYPE];
    [userDefaults setValue:self.expiresTime forKey:TJEXPIRESTIME];
    [userDefaults synchronize];
}

#pragma mark 在cookie中设置token
- (void)setCookieToken:(NSString *)token typeName:(NSString *)typeName {
    
    NSString * cookieValue = [NSString stringWithFormat:@"%@ %@", typeName, token];
    [[TJHTTPSessionManager sharedInstance].requestSerializer setValue:cookieValue forHTTPHeaderField:@"Authorization"];
}
#pragma mark 在cookie中设置version
- (void)setCookieVersion:(NSString *)version {
    [[TJHTTPSessionManager sharedInstance].requestSerializer setValue:version forHTTPHeaderField:@"VersionName"];
}

#pragma mark 移除本地缓存的token
- (void)removeLocalToken {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:@"" forKey:TJ_TOKEN_SIGN];
    [userDefaults setValue:@"" forKey:TJ_REFRESHTOKEN];
    [userDefaults setValue:@"" forKey:TJ_TOKENTYPE];
    [userDefaults setValue:@"" forKey:TJEXPIRESTIME];
    [userDefaults synchronize];
}

#pragma mark private
- (void)didLogout {
    [self logout];
//    [[TJUserModel sharedInstance]logout];
    
}

@end

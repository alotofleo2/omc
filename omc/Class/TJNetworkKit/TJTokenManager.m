//
//  TJTokenManager.m
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/4/18.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import "TJTokenManager.h"
#import "TJRouteManager.h"
#import "TJUserModel.h"

@implementation TJTokenManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        self.token = [userDefaults objectForKey:TJ_TOKEN_SIGN];
        self.longToken = [userDefaults objectForKey:TJ_REFRESHTOKEN];
        self.tokenType = [userDefaults objectForKey:TJ_TOKENTYPE];
        self.expiresTime = [userDefaults objectForKey:TJEXPIRESTIME];

        
        if (self.token.length > 0) {
            [self setCookieToken:self.token typeName:nil];
        }
    }
    return self;
}

#pragma mark - Public Methods
#pragma mark 判断是否已登录
- (BOOL)isLogin {

    if (self.token.length > 0) {
        
        return YES;
    } else {

        return NO;
    }
    
}

- (BOOL)checkLogin {
    if (self.isLogin) {
        
        return YES;
    } else {
        
        [[TJPageManager sharedInstance] presentViewControllerWithName:@"TJLoginViewController" params:nil inNavigationController:YES animated:YES];

        return NO;
    }
}
- (void)updateTokenWithInfo:(NSDictionary *)info {
    /**
     *  token
     */
    if (![StringUtil isEmpty:[info objectForKey:TJ_TOKEN_SIGN]]) {
        self.token= [info objectForKey:TJ_TOKEN_SIGN];
    }
    /**
     *  刷新token
     */
    if (![StringUtil isEmpty:[info objectForKey:TJ_REFRESHTOKEN]]) {
        self.longToken= [info objectForKey:TJ_REFRESHTOKEN];
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
    
    [self setCookieToken:self.token typeName:self.tokenType];
    
    [self setLocalToken];
}



#pragma mark 登出
- (void)logout {

    self.token = @"";
    self.longToken = @"";
    [self removeToken];
    [self setCookieToken:self.token typeName:self.tokenType];

    [[TJUserModel sharedInstance] logout];

    [[NSNotificationCenter defaultCenter]postNotificationName:TJLogoutNotificationName object:nil];
    [TJAlertUtil toastWithString:@"登录退出"];
}


#pragma mark 移除token
- (void)removeToken {
    
    // 清除所有的Token
    [self removeLocalToken];
    
}


- (NSString *)getWebCookieString {
   
    NSMutableString *cookieString = [[NSMutableString alloc]init];
    
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"token",self.token];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",TJ_REFRESHTOKEN,self.longToken];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",TJ_TOKENTYPE,self.tokenType];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"phone",[TJUserDefaultsManager username]];
    [cookieString appendFormat:@"document.cookie = '%@=%@';",@"VersionName",[TJUserDefaultsManager currentVersion]];
    return cookieString.copy;
}


#pragma mark 本地缓存token
- (void)setLocalToken {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.token forKey:TJ_TOKEN_SIGN];
    [userDefaults setValue:self.longToken forKey:TJ_REFRESHTOKEN];
    [userDefaults setValue:self.tokenType forKey:TJ_TOKENTYPE];
    [userDefaults setValue:self.expiresTime forKey:TJEXPIRESTIME];
    [userDefaults synchronize];
}

#pragma mark 在cookie中设置token
- (void)setCookieToken:(NSString *)token typeName:(NSString *)typeName {
    
    NSString * cookieValue = [NSString stringWithFormat:@"Bearer %@", token];
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

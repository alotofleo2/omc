//
//  TJUserDefaultsManager.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.

#import "TJUserDefaultsManager.h"
static NSString * const HEADER_UNIQUE_KEY = @"identifier";
static NSString * const ACCOUNT_REMEMBER_KEY = @"isRemember";
static NSString * const LOGIN_USERNAME = @"login_username_new";
static NSString * const LOGIN_NICKNAME = @"login_nickname_new";
static NSString * const LOGIN_USERINFO = @"login_userInfo_new";
static NSString * const AVATAR_URL = @"avatar_url";
static NSString * const LOGIN_PHONE_NUMBER = @"login_phone_number_new";
static NSString * const BACKGROUND_TIME = @"background_time";
static NSString * const APP_NEED_UPDATE = @"app_need_update";
static NSString * const APP_IS_VERIFY = @"app_is_verify";
static NSString * const APP_UPDATE_URL = @"app_update_url";
static NSString * const GESTURE_PASSWORD_PROMPTED = @"gesture_password_prompted";
static NSString * const GESTURE_PASSWORD_ERROR_COUNT = @"gesture_password_error_count";
static NSString * const GUIDE_FINSHED = @"guide_finshed";
static NSString * const PUSH_NOTIFICATION = @"push_notification";
static NSString * const RECOMMEND_SUBJECT_INFO = @"recommend_subject_info";
static NSString * const USER_FUND_INFO = @"user_fund_info";
static NSString * const INDUSTRY_NEWS_ID = @"industry_news_id";
static NSString * const CURRENT_TIME_INTERVAL = @"current_time_interval";
static NSString * const INVEST_SUBJECT_INFO = @"inveset_subject_info";
static NSString * const IMGBANNER_SUBJECT_INFO = @"imgbanner_subject_info";
static NSString * const USER_CENTER_ICON_CACHE = @"user_center_icon_cache";

// 启动图
static NSString * const LACUCH_SCREEN_INFO =  @"lauch_screen_info";
/**
 *  TabBar显示数据
 */
static NSString * const TABBAR_ITEM_ARRAY = @"tabbar_item_array";

//指纹登录密码
static NSString *const FINGERPRINT_LOGIN_PASSWORD = @"fingerPrintLoginPassword";

@implementation TJUserDefaultsManager

#pragma mark 清除用户状态信息
+(void)clearUserStateInfo
{
    [TJUserDefaultsManager setFingerPrintLoginPassword:NO];
    
}

#pragma mark 设置设备标识符
+ (void)setDeviceIdentifier:(NSString *)deviceIdentifier
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:deviceIdentifier forKey:HEADER_UNIQUE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取设备标识符
+ (NSString *)deviceIdentifier
{
    if (![[NSUserDefaults standardUserDefaults] secureStringForKey:HEADER_UNIQUE_KEY])
    {
        return @"";
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:HEADER_UNIQUE_KEY];
}




// 设置记住账号
+ (void)setRememberAccount:(BOOL)enable
{
    [[NSUserDefaults standardUserDefaults] setSecureBool:enable forKey:ACCOUNT_REMEMBER_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 获取记住账号配置
+ (BOOL)rememberAccount
{
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:ACCOUNT_REMEMBER_KEY];
}


#pragma mark 保存登录账号
+ (void)setUsername:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:username forKey:LOGIN_USERNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 获取登录账号
+ (NSString *)username
{
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:LOGIN_USERNAME];
}


#pragma mark 保存登录密码
+ (void)setLoginPassword:(NSString *)loginPassword
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:loginPassword forKey:LOGIN_NICKNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 获取登录密码
+ (NSString *)loginPassword
{
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:LOGIN_NICKNAME];
}
#pragma mark 保存登录用户信息
+ (void)setLoginUserInfo:(NSDictionary *)loginUserInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:loginUserInfo forKey:LOGIN_USERINFO];
}

#pragma mark 获取登录用户信息
+ (NSDictionary *)getLoginUserInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERINFO];
}

#pragma mark 设置用户头像URL地址
+ (void)setAvatarURL:(NSString *)avatarURL
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:avatarURL forKey:AVATAR_URL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取用户头像URL地址
+ (NSString *)avatarURL
{
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:AVATAR_URL];
}


#pragma mark 设置应用是否需要更新
+ (void)setAppNeedUpdate:(BOOL)state
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:[NSNumber numberWithBool:state] forKey:APP_NEED_UPDATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark 获取应用是否需要更新的状态
+ (BOOL)appNeedUpdate
{
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:APP_NEED_UPDATE];
}

/**
 *  设置应用是否需要更新
 */
+ (void)setAppIsverify:(BOOL)state {
    [[NSUserDefaults standardUserDefaults] setSecureObject:[NSNumber numberWithBool:state] forKey:APP_IS_VERIFY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}

/**
 *  获取应用是否需要更新的状态
 */
+ (BOOL)appIsverify {
    
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:APP_IS_VERIFY];
}

/**
 *  设置应用更新的URL地址
 */
+ (void)setUpdateURL:(NSString *)updateURL {

    [[NSUserDefaults standardUserDefaults] setSecureObject:updateURL forKey:APP_UPDATE_URL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取应用更新的URL地址
 */
+ (NSString *)updateURL {
    
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:APP_UPDATE_URL];
}

//设置当前时间
+ (void)setCurrentTimeInterval:(double)currentTimeInterval;
{
    [[NSUserDefaults standardUserDefaults] setSecureDouble:currentTimeInterval forKey:CURRENT_TIME_INTERVAL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获取当前时间
+ (double)currentTimeInterval
{
    return [[NSUserDefaults standardUserDefaults] secureDoubleForKey:CURRENT_TIME_INTERVAL];
}

#pragma mark 设置后台在线时间
+ (void)setBackgroundTime:(NSString *)minute;
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:minute forKey:BACKGROUND_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 获取后台在线时间
+ (NSString *)backgroundTime
{
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:BACKGROUND_TIME];
}


#pragma mark 设置手势密码
+ (void)setGesturePassword:(NSString *)gesturePassword
{
    [[NSUserDefaults standardUserDefaults] setSecureObject:gesturePassword forKey:LOGIN_PHONE_NUMBER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取手势密码
+ (NSString *)gesturePassword
{
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:LOGIN_PHONE_NUMBER];
}


#pragma mark 设置是否已提示过用户也是手势密码
+ (void)setGesturePasswordPrompted:(BOOL)prompted
{
    [[NSUserDefaults standardUserDefaults] setSecureBool:prompted forKey:GESTURE_PASSWORD_PROMPTED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取是否已提示过用户也是手势密码
+ (BOOL)gesturePasswordPrompted
{
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:GESTURE_PASSWORD_PROMPTED];
}


#pragma mark 设置手势密码剩余输入次数
+ (void)setGesturePasswordErrorCount:(NSInteger)count
{
    [[NSUserDefaults standardUserDefaults] setSecureInteger:count forKey:GESTURE_PASSWORD_ERROR_COUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取手势密码剩余输入次数
+ (NSInteger)gesturePasswordErrorCount
{
    return [[NSUserDefaults standardUserDefaults] secureIntegerForKey:GESTURE_PASSWORD_ERROR_COUNT];
}


#pragma mark  重设手势密码剩余输入次数
+ (void)resetGesturePasswordErrorCount
{
    [[NSUserDefaults standardUserDefaults] setSecureInteger:5 forKey:GESTURE_PASSWORD_ERROR_COUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark 产品号
+ (NSString *)proUniId {
    return @"dfd8f91e6f074eb17582c38a81463845";
}

#pragma mark 设置引导是否已完成
+ (void)setGuideFinshed:(BOOL)finished
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [[NSUserDefaults standardUserDefaults] setSecureBool:finished forKey:app_build];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取引导是否已完成
+ (BOOL)guideFinshed
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:app_build];
}


#pragma mark 设置引导是否已完成
+ (void)setUserCenterGuideFinshed:(BOOL)finished
{
    /*
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     // app版本  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
     // app build版本
     NSString *userCenterapp_build = [infoDictionary objectForKey:@"CFBundleVersion"];
     
     userCenterapp_build  = [userCenterapp_build stringByAppendingString:@"_"];*/
    [[NSUserDefaults standardUserDefaults] setSecureBool:finished forKey:@"userCenterapp_build"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取引导是否已完成
+ (BOOL)userCenterguideFinshed
{
    /* NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     // app版本  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
     // app build版本
     NSString *userCenterapp_build = [infoDictionary objectForKey:@"CFBundleVersion"];
     userCenterapp_build  = [userCenterapp_build stringByAppendingString:@"_"];*/
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:@"userCenterapp_build"];
}

#pragma mark app 是否是第一个安装
+(void)setAppfirstInstaller:(BOOL)first
{
    
    [[NSUserDefaults standardUserDefaults] setSecureBool:first forKey:@"firstInstaller"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(BOOL)appfirstInstaller
{
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:@"firstInstaller"];
}


#pragma mark  是否显示首页的引导图
+(void)setShowHomeUserGuiderView:(BOOL)show
{
    [[NSUserDefaults standardUserDefaults] setSecureBool:show forKey:@"showHomeUserGuiderView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)showHomeUserGuiderView
{
    return [[NSUserDefaults standardUserDefaults] secureBoolForKey:@"showHomeUserGuiderView"];
}
#pragma mark 当前版本号
+ (NSString *)currentVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

#pragma mark 设置公告的版本号
+ (void)setNoticeVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setSecureObject:version forKey:@"NoticeVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 获取公告的版本号
+ (NSString *)noticeVersion {
    
    return [[NSUserDefaults standardUserDefaults] secureStringForKey:@"NoticeVersion"];
}
#pragma mark 检查版本号是否需要强制更新
+ (BOOL)checkVersionisUpdate {
    
    if ([self appNeedUpdate]) {
        
        [self showUpdateAlert];
        return YES;
    } else {
        return NO;
    }
    
}
#pragma mark 提示更新
+ (void)showUpdateAlert {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"米粒钱包有新内容发布,请更新后使用" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TJGCDManager asyncMainThreadBlock:^{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[TJUserDefaultsManager updateURL]]];
            
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[[TJPageManager sharedInstance] currentViewController] presentViewController:alertController animated:YES completion:nil];
}
/**
 *  获取启动图片的信息
 */
+ (void)setLauchScreenInfo:(NSDictionary *)lauchInfo;
{
    [[NSUserDefaults standardUserDefaults] setObject:lauchInfo forKey:LACUCH_SCREEN_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (NSDictionary *)getLauchScreenInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LACUCH_SCREEN_INFO];
}

#pragma mark 获取和设置是否设置了登录的指纹解锁密码
+(void)setFingerPrintLoginPassword:(BOOL)passWord;
{
    [[NSUserDefaults standardUserDefaults] setBool:passWord forKey:FINGERPRINT_LOGIN_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(BOOL)fingerPrintLoginPassword
{
    return  [[NSUserDefaults standardUserDefaults] boolForKey:FINGERPRINT_LOGIN_PASSWORD];
}


#pragma mark 设置TabBar显示数据
+ (void)setTabBarItemArray:(NSArray *)tabBarItemArray; {
    
    [[NSUserDefaults standardUserDefaults] setObject:tabBarItemArray forKey:TABBAR_ITEM_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark  获取TabBar显示数据
+ (NSArray *)tabBarItemArray {
    
    return [[NSUserDefaults standardUserDefaults] arrayForKey:TABBAR_ITEM_ARRAY];
}


#pragma mark  获取,设置客户端服务器的环境配置
+ (void)setAppServerEnvironMentType:(NSDictionary *)environMentTypeDict {
    
    [[NSUserDefaults standardUserDefaults] setObject:environMentTypeDict forKey:@"appServerEnvironMentType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (NSDictionary *)appServerEnvironMentType {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"appServerEnvironMentType"];
}


@end

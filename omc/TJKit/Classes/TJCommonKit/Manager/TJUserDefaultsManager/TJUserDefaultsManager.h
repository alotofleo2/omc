//
//  TJUserDefaultsManager.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  服务器的环境配置
 */
static NSString * const DEFAULT_SYSTEM_SERVER_ENVIRONMENTTYPE = @"defaultSystemtServerEnvironmentType";
static NSString * const CUSTOM__SERVER_ENVIRONMENTTYPE = @"customServerEnvironmentType";
#define RW_VERSION @"RWVERSION"
@interface TJUserDefaultsManager : NSObject

/**
 *  用户退出登录清空用户信息，包括是否设置手势密码，是否设置指纹解锁
 
 */
+ (void)clearUserStateInfo;

/**
 *  设置设备标识符
 */
+ (void)setDeviceIdentifier:(NSString *)deviceIdentifier;

/**
 *  获取设备标识符
 */
+ (NSString *)deviceIdentifier;

/**
 *  设置记住账号
 */
+ (void)setRememberAccount:(BOOL)enable;

/**
 *  获取记住账号配置
 */
+ (BOOL)rememberAccount;

/**
 *  保存登录账号
 */
+ (void)setUsername:(NSString *)username;


/**
 *  获取登录账号
 */
+ (NSString *)username;


/**
 *  保存登录密码
 *
 *  @param loginPassword 登录密码
 */
+ (void)setLoginPassword:(NSString *)loginPassword;


/**
 *  获取登录密码
 */
+ (NSString *)loginPassword;

/**
 *  获取登录用户信息
 */
+ (NSDictionary *)getLoginUserInfo;

/**
 *  保存登录用户信息
 *
 *  @param loginUserInfo 用户信息
 */
+ (void)setLoginUserInfo:(NSDictionary *)loginUserInfo;


/**
 *  设置用户头像URL地址
 *
 *  @param avatarURL 用户头像URL地址
 */
+ (void)setAvatarURL:(NSString *)avatarURL;


/**
 *  获取用户头像URL地址
 *
 *  @return 用户头像URL地址
 */
+ (NSString *)avatarURL;


/**
 *  设置应用是否需要更新
 */
+ (void)setAppNeedUpdate:(BOOL)state;

/**
 *  获取应用是否需要更新的状态
 */
+ (BOOL)appNeedUpdate;

/**
 *  设置应用是否需要更新
 */
+ (void)setAppIsverify:(BOOL)state;

/**
 *  获取应用是否需要更新的状态
 */
+ (BOOL)appIsverify;
/**
 *  设置应用更新的URL地址
 */
+ (void)setUpdateURL:(NSString *)updateURL;


/**
 *  获取应用更新的URL地址
 */
+ (NSString *)updateURL;



/**
 *  设置后台在线时间
 */
+ (void)setBackgroundTime:(NSString *)index;


/**
 *  获取后台在线时间
 */
+ (NSString *)backgroundTime;


/**
 *  设置手势密码
 *
 *  @param gesturePassword 手势密码
 */
+ (void)setGesturePassword:(NSString *)gesturePassword;


/**
 *  获取手势密码
 *
 *  @return gesturePassword
 */
+ (NSString *)gesturePassword;


/**
 *  设置是否已提示过用户也是手势密码
 *  YES: 已提示，用户登录后不需再加载设置手势密码界面
 *  NO:  未提示，用户注册后需要加载设置手势密码界面
 *
 *  @param prompted 是否已提示
 */
+ (void)setGesturePasswordPrompted:(BOOL)prompted;


/**
 *  获取是否已提示过用户也是手势密码
 *
 *  @return 是否已提示
 */
+ (BOOL)gesturePasswordPrompted;

/**
 *  设置手势密码剩余输入次数
 *
 *  @param count 剩余输入次数
 */
+ (void)setGesturePasswordErrorCount:(NSInteger)count;


/**
 *  获取手势密码剩余输入次数
 *
 *  @return 剩余输入次数
 */
+ (NSInteger)gesturePasswordErrorCount;


/**
 *  重设手势密码剩余输入次数
 */
+ (void)resetGesturePasswordErrorCount;

/**
 产品号
 */
+ (NSString *)proUniId;
/**
 *  设置引导是否已完成
 *
 *  @param finished 是否已完成
 */
+ (void)setGuideFinshed:(BOOL)finished;


/**
 *  获取引导是否已完成
 *
 *  @return 是否已完成
 */
+ (BOOL)guideFinshed;


/**
 *  设置我的泰和用户中心的引导启动
 *
 *
 */
+ (void)setUserCenterGuideFinshed:(BOOL)finished;

/**
 *
 *   获取我的泰和用户中心的引导启动
 *
 */
+ (BOOL)userCenterguideFinshed;

/**
 *  app 是否是第一个安装，如果app卸载重新安装，那么算安装两次
 *
 */
+(void)setAppfirstInstaller:(BOOL)first;

+(BOOL)appfirstInstaller;

/**
 *  是否显示首页的引导图
 *
 *  
 */
+(void)setShowHomeUserGuiderView:(BOOL)show;
+(BOOL)showHomeUserGuiderView;

/**
 *  获取和设置是否设置了登录的指纹解锁
 */
+ (void)setFingerPrintLoginPassword:(BOOL)passWord;

+ (BOOL)fingerPrintLoginPassword;

/**
 当前版本号
 */
+ (NSString *)currentVersion;
/**
 *  设置公告的版本号
 *
 *  @param version 公告的版本号
 */
+ (void)setNoticeVersion:(NSString *)version;


/**
 *  获取公告的版本号
 *
 *  @return 公告的版本号
 */
+ (NSString *)noticeVersion;

/**
 检查版本是否需要强制更新

 @return 是否需要
 */
+ (BOOL)checkVersionisUpdate;

/**
 弹更新提示窗
 */
+ (void)showUpdateAlert;
/**
 *  记录
 */
+ (void)setCurrentTimeInterval:(double)currentTimeInterval;

+ (double)currentTimeInterval;

/**
 *  获取启动图片的信息
 */
+(void)setLauchScreenInfo:(NSDictionary *)lauchInfo;

+(NSDictionary *)getLauchScreenInfo;


/**
 *  设置TabBar显示数据
 *
 *  @param tabBarItemArray TabBar显示数据
 */
+ (void)setTabBarItemArray:(NSArray *)tabBarItemArray;


/**
 *  获取TabBar显示数据
 *
 *  @return TabBar显示数据
 */
+ (NSArray *)tabBarItemArray;

/**
 *  获取,设置客户端服务器的环境配置
 */
+ (void)setAppServerEnvironMentType:(NSDictionary *)environMentTypeDict;


+ (NSDictionary *)appServerEnvironMentType;
@end

//
//  TJCommonKit.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#ifndef TJCommonKit_h
#define TJCommonKit_h
#import <Foundation/Foundation.h>

#import "Masonry.h"
#import "SDWebImageManager.h"
#import "TJAlertUtil.h"
#import "TJPageManager.h"
#import "TJButton.h"
#import "TJUserDefaultsManager.h"
#import "TJBannerView.h"
#import "TJBaseTableViewController.h"
#import "TJNavigationController.h"
#import "TJBaseWebViewController.h"
#import "TJAdaptiveManager.h"
#import "TJGCDManager.h"
#import "TJBaseSharedInstance.h"

#define TARGET_SYSTEM_VERSION [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] integerValue]

#define TARGET_IS_IOS12_OR_LATER    (TARGET_SYSTEM_VERSION >= 12)
#define TARGET_IS_IOS11_OR_LATER    (TARGET_SYSTEM_VERSION >= 11)
#define TARGET_IS_IOS10_OR_LATER    (TARGET_SYSTEM_VERSION >= 10)
#define TARGET_IS_IOS9_OR_LATER    (TARGET_SYSTEM_VERSION >= 9)
#define TARGET_IS_IOS8_OR_LATER    (TARGET_SYSTEM_VERSION >= 8)
#define TARGET_IS_IOS7_OR_LATER    (TARGET_SYSTEM_VERSION >= 7)
#define TARGET_IS_IOS6_OR_LATER    (TARGET_SYSTEM_VERSION >= 6)


/**
 *  判断设备是否是iPad
 */
#define DEVICE_IS_IPAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


/**
 *  判断设备是否是iPhone
 */
#define DEVICE_IS_IPHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


/**
 *  判断设备是否是Retina屏
 */
#define DEVICE_IS_RETINA            ([[UIScreen mainScreen] scale] >= 2.0)


/**
 *  设备屏幕的宽度
 */
#define DEVICE_SCREEN_WIDTH         ([[UIScreen mainScreen] bounds].size.width)


/**
 *  设备屏幕的高度
 */
#define DEVICE_SCREEN_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)

/**
 *  设备状态栏高度
 */
#define DEVICE_STATUSBAR_HEIGHT     ([[UIApplication sharedApplication] statusBarFrame].size.height)


/**
 *  设备屏幕的最大长度
 */
#define DEVICE_SCREEN_MAX_LENGTH    (MAX(DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT))


/**
 *  设备屏幕的最小长度
 */
#define DEVICE_SCREEN_MIN_LENGTH    (MIN(DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT))


/**
 *  设备屏幕基于iPhone4屏幕宽度的比例
 */
#define DEVICE_SCREEN_WIDTH_SCALE   DEVICE_SCREEN_WIDTH / 320.f

/**
 *  设备屏幕基于iPhone6屏幕宽度的比例
 */

#define DEVICE_SCREEN_WIDTH_SCALE_6   DEVICE_SCREEN_WIDTH / 375.f


/**
 *  设备屏幕基于iPhone6P屏幕宽度的比例
 */
#define DEVICE_SCREEN_WIDTH_SCALE_6P  DEVICE_SCREEN_WIDTH / 414.f

/**
 *  设备屏幕基于1080屏幕宽度的比例
 */
#define DEVICE_SCREEN_WIDTH_SCALE_1080  DEVICE_SCREEN_WIDTH / 1080.f


/**
 *  设备屏幕基于iPhone4屏幕高度的比例
 */
#define DEVICE_SCREEN_HEIGHT_SCALE  DEVICE_SCREEN_HEIGHT / 480.f

/**
 *  设备屏幕基于iPhone6屏幕高度的比例
 */
#define DEVICE_SCREEN_HEIGHT_SCALE_6  (DEVICE_SCREEN_HEIGHT == 812.f? 667.f : DEVICE_SCREEN_HEIGHT) / 667.f


/**
 *  设备屏幕基于iPhone6P屏幕高度的比例
 */
#define DEVICE_SCREEN_HEIGHT_SCALE_6P  DEVICE_SCREEN_HEIGHT / 736.f

/**
 *  设备屏幕基于1080屏幕高度的比例
 */
#define DEVICE_SCREEN_HEIGHT_SCALE_1080  DEVICE_SCREEN_HEIGHT / 1920.f

//距离基于6屏幕的比例字体比例
#define TJSystemWidth(x) floor(x * DEVICE_SCREEN_WIDTH_SCALE_6P)

#define TJSystemHeight(x) floor(x * DEVICE_SCREEN_HEIGHT_SCALE_6P)

//基于3倍6屏幕的比例
#define TJSystem3Xphone6Width(x) floor(x * DEVICE_SCREEN_WIDTH_SCALE_6 / 3)

#define TJSystem3Xphone6Height(x) floor(x * DEVICE_SCREEN_HEIGHT_SCALE_6 / 3)

//基于2倍6屏幕的比例
#define TJSystem2Xphone6Width(x) floor(x * DEVICE_SCREEN_WIDTH_SCALE_6 / 2)

#define TJSystem2Xphone6Height(x) floor(x * DEVICE_SCREEN_HEIGHT_SCALE_6 / 2)

//基于1080的屏幕比例
#define TJSystem1080Height(x) floor(x * DEVICE_SCREEN_HEIGHT_SCALE_1080 )

#define TJSystem1080Width(x) floor(x * DEVICE_SCREEN_WIDTH_SCALE_1080 )

/**
 *  设备的类型
 */
#define DEVICE_IS_IPHONE_4_OR_LESS  (DEVICE_IS_IPHONE && DEVICE_SCREEN_MAX_LENGTH < 568.0)
#define DEVICE_IS_IPHONE_5          (DEVICE_IS_IPHONE && DEVICE_SCREEN_MAX_LENGTH == 568.0)
#define DEVICE_IS_IPHONE_6          (DEVICE_IS_IPHONE && DEVICE_SCREEN_MAX_LENGTH == 667.0)
#define DEVICE_IS_IPHONE_6P         (DEVICE_IS_IPHONE && DEVICE_SCREEN_MAX_LENGTH == 736.0)
#define DEVICE_IS_IPHONE_X          (DEVICE_IS_IPHONE && DEVICE_SCREEN_MAX_LENGTH == 812.0)


/**
 *  设备默认的导航条高度
 */
#define DEVICE_NAVIGATIONBAR_HEIGHT    (               CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight([(UINavigationController *)[(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController viewControllers].firstObject navigationBar].frame))

/**
 *  设备默认的tabBar高度
 */
#define DEVICE_TABBAR_HEIGHT           (CGRectGetHeight([(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController tabBar].frame))


/**
 *  将Class转为String
 */
#define NSClassToString(className)  NSStringFromClass([className class])



#define BLOCK_WEAK_SELF    __weak __typeof(self) weakSelf = self;
#define BLOCK_STRONG_SELF  __strong __typeof(weakSelf) strongSelf = weakSelf;



#endif /* TJCommonKit_h */

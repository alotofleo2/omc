//
//  TJAdaptiveManager.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/5.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJAdaptiveManager : NSObject



+ (NSInteger)currentSystemVersion;


+ (BOOL)deviceIsIpad;
+ (BOOL)deviceIsIphone;
+ (BOOL)deviceIsRetina;


+ (BOOL)deviceIsIphone4OrLess;
+ (BOOL)deviceIsIphone5OrLess;
+ (BOOL)deviceIsIphone5;
+ (BOOL)deviceIsIphone6;
+ (BOOL)deviceIsIphone6p;
+ (BOOL)deviceIsIphoneX;



+ (CGFloat)deviceScreenWidth;
+ (CGFloat)deviceScreenHeight;


+ (CGFloat)deviceScreenMaxLength;
+ (CGFloat)deviceScreenMinLength;
+ (CGFloat)deviceScreenWidthScale;
+ (CGFloat)deviceScreenWidthScale6;
+ (CGFloat)deviceScreenHeightScale;
+ (CGFloat)deviceScreenHeightScale6;
+ (CGFloat)deviceNavigationBarHeight;
+ (CGFloat)deviceTabBarHeight;



/**
 *  适配的比例
 */
+ (CGFloat)adaptiveScale;


/**
 *  适配的比例
 */
+ (CGFloat)adaptiveScaleFloat:(CGFloat)value;


/**
 *  适配字体
 */
+ (UIFont *)adaptiveSystemFontSize:(CGFloat)systemFontSize;
+ (UIFont *)adaptiveBoldSystemFontSize:(CGFloat)systemFontSize;
+ (UIFont *)adaptiveFont:(NSString *)fontName fontSize:(CGFloat)fontSize;
+ (UIFont *)adaptiveNumberFont:(CGFloat)fontSize;
+ (UIFont *)adaptiveBoldNumberFont:(CGFloat)fontSize;


@end

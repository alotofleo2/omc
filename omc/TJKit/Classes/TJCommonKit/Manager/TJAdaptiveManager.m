//
//  TJAdaptiveManager.m
//  RiceWallet
//
//  Created by 方焘 on 2017/8/5.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJAdaptiveManager.h"

@implementation TJAdaptiveManager


+ (NSInteger)currentSystemVersion {
    
    return [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] integerValue];
}


+ (BOOL)deviceIsIpad {
    
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}


+ (BOOL)deviceIsIphone {
    
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}


+ (BOOL)deviceIsRetina {
    
    return [[UIScreen mainScreen] scale] >= 2;
}


+ (BOOL)deviceIsIphone4OrLess {
    
    return [self deviceIsIphone] && [self deviceScreenMaxLength] < 568.0;
}

+ (BOOL)deviceIsIphone5OrLess {
    
    return [self deviceIsIphone] && [self deviceScreenMaxLength] <= 568.0;
}

+ (BOOL)deviceIsIphone5 {
    
    return [self deviceIsIphone] && [self deviceScreenMaxLength]  == 568.0;
}


+ (BOOL)deviceIsIphone6 {
    
    return [self deviceIsIphone] && [self deviceScreenMaxLength]  == 667.0;
}


+ (BOOL)deviceIsIphone6p {
    
    return [self deviceIsIphone] && [self deviceScreenMaxLength]  == 736.0;
}
+ (BOOL)deviceIsIphoneX {
    return [self deviceIsIphone] && [self deviceScreenMaxLength]  == 812.0;
}

+ (CGFloat)deviceScreenWidth {
    
    return [[UIScreen mainScreen] bounds].size.width;
}


+ (CGFloat)deviceScreenHeight {
    
    return [[UIScreen mainScreen] bounds].size.height;
}


+ (CGFloat)deviceScreenMaxLength {
    
    return MAX([self deviceScreenWidth], [self deviceScreenHeight]);
}


+ (CGFloat)deviceScreenMinLength {
    
    return MIN([self deviceScreenWidth], [self deviceScreenHeight]);
}


+ (CGFloat)deviceScreenWidthScale {
    
    return [self deviceScreenWidth] / 320.f;
}


+ (CGFloat)deviceScreenWidthScale6 {
    
    return [self deviceScreenWidth] / 375.f;
}


+ (CGFloat)deviceScreenHeightScale {
    
    return [self deviceScreenHeight] / 480.f;
}


+ (CGFloat)deviceScreenHeightScale6 {
    
    return [self deviceScreenHeight] / 667.f;
}


+ (CGFloat)deviceNavigationBarHeight {
    
    return 64;
}


+ (CGFloat)deviceTabBarHeight {
    
    return 49;
}



+ (CGFloat)adaptiveScale {
    
    CGFloat scaleSize = 1.0;
    
    if ([self deviceIsIphone4OrLess] || [self deviceIsIphone5]) {
        
        return 0.85;
    }
    
    
    if ([self deviceIsIphone6p]) {
        
        scaleSize = 1.1;
    }
    
    
    return scaleSize;
}



/**
 *  适配的比例
 */
+ (CGFloat)adaptiveScaleFloat:(CGFloat)value {
    
    return value * [TJAdaptiveManager adaptiveScale];
}


+ (UIFont *)adaptiveSystemFontSize:(CGFloat)systemFontSize {
    
    return [UIFont systemFontOfSize:systemFontSize * [self adaptiveScale]];
}


+ (UIFont *)adaptiveBoldSystemFontSize:(CGFloat)systemFontSize {
    
    return [UIFont boldSystemFontOfSize:systemFontSize * [self adaptiveScale]];
}


+ (UIFont *)adaptiveFont:(NSString *)fontName fontSize:(CGFloat)fontSize {
    
    if (fontName.length == 0) {
        
        return nil;
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize * [self adaptiveScale]];
    return font;
}


+ (UIFont *)adaptiveNumberFont:(CGFloat)fontSize {
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize * [self adaptiveScale]];
    return font;
}


+ (UIFont *)adaptiveBoldNumberFont:(CGFloat)fontSize {
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize * [self adaptiveScale]];
    return font;
}



@end

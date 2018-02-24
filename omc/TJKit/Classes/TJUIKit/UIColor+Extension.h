//
//  UIColor+Extension.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF000000) >> 16))/255.0 green:((float)((rgbValue & 0xFF0000) >> 8))/255.0 blue:((float)(rgbValue & 0xFF00))/255.0 alpha:((float)(rgbValue & 0xFF))/255.0]


@interface UIColor (Extension)

/**
 *  将16进制色值代码转换为UIColor对象
 *
 *  @param hexString 16进制色值，如"#DCDCDC"
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;



/**
 *  青绿色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)turquoiseColor;

/**
 *  青绿色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)greenSeaColor;


/**
 *  淡绿色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)emerlandColor;

/**
 *  淡绿色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)nephritisColor;


/**
 *  淡蓝色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)peterRiverColor;

/**
 *  淡蓝色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)belizeHoleColor;


/**
 *  淡紫色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)amethystColor;

/**
 *  淡紫色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)wisteriaColor;


/**
 *  淡黑色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)wetAsphaltColor;

/**
 *  淡黑色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)midnightBlueColor;


/**
 *  淡黄色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)sunflowerColor;

/**
 *  淡黄色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)tangerineColor;


/**
 *  橙色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)carrotColor;

/**
 *  橙色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)pumpkinColor;


/**
 *  淡红色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)alizarinColor;

/**
 *  淡红色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)pomegranateColor;


/**
 *  白色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)cloudsColor;

/**
 *  白色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)silverColor;


/**
 *  青灰色normal
 *
 *  @return UIColor对象
 */
+ (UIColor *)concreteColor;

/**
 *  青灰色highlight
 *
 *  @return UIColor对象
 */
+ (UIColor *)asbestosColor;


/**
 *  白烟色
 *
 *  @return UIColor对象
 */
+ (UIColor *)whiteSmokeColor;


/**
 *  淡灰色
 *
 *  @return UIColor对象
 */
+ (UIColor *)gainsboroColor;


/**
 *  金额的默认颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)amountColor;


/**
 *  利率的默认颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)rateColor;


/**
 *  默认灰色字体颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)textGrayColor;


/**
 *  深灰色字体颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)textDarkGrayColor;


/**
 *  导航条默认背景颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)navigationBarBackgroundColor;

/**
 *  确认按钮普通状态下的背景色
 *
 *  @return UIColor对象
 */
+ (UIColor *)confirmButtonNormalColor;


/**
 *  确认按钮高亮状态下的背景色
 *
 *  @return UIColor对象
 */
+ (UIColor *)confirmButtonHighlightedColor;


/**
 *  确认按钮失效状态下的背景色
 *
 *  @return UIColor对象
 */
+ (UIColor *)confirmButtonDisabledColor;


/**
 *  发送验证码按钮普通状态下的背景色
 *
 *  @return UIColor对象
 */
+ (UIColor *)verificationCodeButtonNormalColor;


/**
 *  发送验证码按钮高亮状态下的背景色
 *
 *  @return UIColor对象
 */
+ (UIColor *)verificationCodeButtonHighlightedColor;


/**
 *  界面默认背景颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *)viewBackgroundColor;



@end


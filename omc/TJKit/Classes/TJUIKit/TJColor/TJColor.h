//
//  TJColor.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  主要字段、一级字段
 */
#define TJ229BED UIColorFromRGB(0x229bed)


/**
 *  正文、二级字段
 */
#define TJ525252 UIColorFromRGB(0x525252)


/**
 *  三级字段
 */
#define TJ808080 UIColorFromRGB(0x808080)
#define TJ00BAFE UIColorFromRGB(0x00bafe)

/**
 闪屏色
 */
#define TJ002094 UIColorFromRGB(0x002094)
/**
 *  边框色、提醒字体
 */
#define TJC9C9C9 UIColorFromRGB(0xC9C9C9)


/**
 *  背景色、其他
 */
#define TJF5F5F5 UIColorFromRGB(0xF5F5F5)
#define TJ00BAFF UIColorFromRGB(0x00BAFF)


/**
 *  背景色、其他
 */

#define TJMainBackgroundColor UIColorFromRGB(0xF4F4F4)



/**
 *  主色（首页导航条、圆环项目进度的背景色）
 */
#define TJ181D20  UIColorFromRGB(0x181d20)

#define TJ20282D  UIColorFromRGB(0x20282d)

/**
 *  着重字段、按钮色
 */
#define TJF25A2B UIColorFromRGB(0XF25A2B)


/**
 *  个别辅助色
 */
#define TJ1AD371 UIColorFromRGB(0X1AD371)



/**
 *  tableView 的分割线的颜色
 */
#define TJTABLEVIEW_SEPERATE_COLOR UIColorFromRGB(0XE4E4E4)



@interface TJColor : NSObject

/**
 *  将16进制色值代码转换为UIColor对象
 *
 *  @param hexString 16进制色值，如"#DCDCDC"
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;

@end

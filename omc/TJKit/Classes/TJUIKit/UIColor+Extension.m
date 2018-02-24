//
//  UIColor+Extension.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)


#pragma mark 将16进制色值代码转换为UIColor对象
+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    if ([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark 青绿色normal
+ (UIColor *)turquoiseColor
{
    return RGB(26, 188, 156);
}


#pragma mark 青绿色highlight
+ (UIColor *)greenSeaColor
{
    return RGB(22, 160, 133);
}


#pragma mark 淡绿色normal
+ (UIColor *)emerlandColor
{
    return RGB(46, 204, 113);
}


#pragma mark 淡绿色highlight
+ (UIColor *)nephritisColor
{
    return RGB(39, 174, 96);
}


#pragma mark 淡蓝色normal
+ (UIColor *)peterRiverColor
{
    return RGB(52, 152, 219);
}


#pragma mark 淡蓝色highlight
+ (UIColor *)belizeHoleColor
{
    return RGB(41, 128, 185);
}


#pragma mark 淡紫色normal
+ (UIColor *)amethystColor
{
    return RGB(155, 89, 182);
}


#pragma mark 淡紫色highlight
+ (UIColor *)wisteriaColor
{
    return RGB(142, 68, 173);
}


#pragma mark 淡黑色highlight
+ (UIColor *)wetAsphaltColor
{
    return RGB(52, 73, 94);
}


#pragma mark 淡黑色highlight
+ (UIColor *)midnightBlueColor
{
    return RGB(44, 62, 80);
}


#pragma mark 淡黄色normal
+ (UIColor *)sunflowerColor
{
    return RGB(241, 196, 15);
}


#pragma mark 淡黄色highlight
+ (UIColor *)tangerineColor
{
    return RGB(243, 156, 18);
}


#pragma mark 橙色normal
+ (UIColor *)carrotColor
{
    return RGB(230, 126, 34);
}


#pragma mark 橙色highlight
+ (UIColor *)pumpkinColor
{
    return RGB(211, 84, 0);
}


#pragma mark 淡红色normal
+ (UIColor *)alizarinColor
{
    return RGB(231, 76, 60);
}


#pragma mark 淡红色highlight
+ (UIColor *)pomegranateColor
{
    return RGB(192, 57, 43);
}


#pragma mark 白色normal
+ (UIColor *)cloudsColor
{
    return RGB(236, 240, 241);
}


#pragma mark 白色highlight
+ (UIColor *)silverColor
{
    return RGB(189, 195, 199);
}


#pragma mark 青灰色normal
+ (UIColor *)concreteColor
{
    return RGB(149, 165, 166);
}

#pragma mark 青灰色highlight
+ (UIColor *)asbestosColor
{
    return RGB(127, 140, 141);
}


#pragma mark 白烟色
+ (UIColor *)whiteSmokeColor
{
    return RGB(225.f, 225.f, 230.f);
}


#pragma mark 淡灰色
+ (UIColor *)gainsboroColor
{
    return RGB(220.f, 220.f, 220.f);
}


#pragma mark 金额的默认颜色
+ (UIColor *)amountColor
{
    return RGB(252.f, 78.f, 8.f);
}


#pragma mark 利率的默认颜色
+ (UIColor *)rateColor
{
    return RGB(212.f, 0.f, 17.f);
}


#pragma mark 默认灰色字体颜色
+ (UIColor *)textGrayColor
{
    return RGB(157.f, 157.f, 157.f);
}


#pragma mark 深灰色字体颜色
+ (UIColor *)textDarkGrayColor
{
    return RGB(74.f, 74.f, 74.f);
}


#pragma mark 导航条默认背景颜色
+ (UIColor *)navigationBarBackgroundColor
{
    return [UIColor colorFromHexCode:@"#016723"];
}


#pragma mark 确认按钮普通状态下的背景色
+ (UIColor *)confirmButtonNormalColor
{
    return RGB(207.f, 28.f, 32.f);
}


#pragma mark 确认按钮高亮状态下的背景色
+ (UIColor *)confirmButtonHighlightedColor
{
    return [UIColor colorFromHexCode:@"#ca2929"];
}


#pragma mark 确认按钮失效状态下的背景色
+ (UIColor *)confirmButtonDisabledColor
{
    return RGB(174.f, 174.f, 174.f);
}


#pragma mark 发送验证码按钮普通状态下的背景色
+ (UIColor *)verificationCodeButtonNormalColor
{
    return RGB(253.f, 180.f, 49.f);
}


#pragma mark 发送验证码按钮高亮状态下的背景色
+ (UIColor *)verificationCodeButtonHighlightedColor
{
    return RGB(177.f, 118.f, 21.f);
}


#pragma mark 界面默认背景颜色
+ (UIColor *)viewBackgroundColor
{
    return [UIColor colorFromHexCode:@"#f8f8f8"];
}


@end

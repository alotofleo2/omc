//
//  StringUtil.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil
#pragma mark Public Methods
+ (BOOL)isEmpty:(NSString *)string {
    
    if (string == nil || string.length == 0 || [string isEqual:[NSNull null]]) {
        
        return YES;
    }
    
    return NO;
}

#pragma makrk 判断字符串是否是纯数字
+ (BOOL)isIntOrFloatOrDouble:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];

    NSString *result = nil;
    if ([scan scanCharactersFromSet:[NSCharacterSet letterCharacterSet]
                         intoString:&result]) {
        
        return NO;
        
    } else return YES;
    
}

#pragma mark 判断是否是字母(大小写)数组的组合
+ (BOOL)isLetterOrInt:(NSString *)string {
    NSMutableCharacterSet *base = [NSMutableCharacterSet lowercaseLetterCharacterSet]; //字母
    NSCharacterSet *decimalDigit = [NSCharacterSet decimalDigitCharacterSet];   //十进制数字
    [base formUnionWithCharacterSet:decimalDigit];
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    NSString *result = nil;
    if ([scan scanCharactersFromSet:base
                         intoString:&result]) {
        
        return NO;
        
    } else return YES;
}

#pragma mark 判断字符串是否是手机号码
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber
{
    if ([StringUtil isEmpty:mobileNumber]) {
        
        return NO;
    }
    NSString *phoneRegex = @"^(1[3|4|5|7|8])\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNumber];

}


#pragma mark 判断字符串是否是电话号码
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber
{
    if ([StringUtil isEmpty:telephoneNumber]) {
        
        return NO;
    }
    
    NSString * mobileFormat = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    
    if ([regexMobile evaluateWithObject:telephoneNumber]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

#pragma mark 检测是否是验证码

+ (BOOL)checkCode:(NSString *)astr
{
    NSScanner* scan = [NSScanner scannerWithString:astr];
    int val;
    if([scan scanInt:&val] && [scan isAtEnd] && astr.length == 6) {
        return YES;
    }else return NO;
}


#pragma mark 检测是否密码

+ (BOOL)checkPwd:(NSString *)aStr
{
    
    if (aStr.length >= 6 && aStr.length <= 16) {
        return YES;
    }else
        return NO;
}

#pragma mark 检测是否是身份证号码

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
}


#pragma mar 四舍五入

+(NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}


#pragma mark 投资金额

+(NSString *)dealInvestAmount:(double)amount
{
    NSString * remainingAmount;
    NSString * unit;
    if (amount < 10000)
    {
        remainingAmount = [NSString stringWithFormat:@"%0.2f", amount];
        unit = @"元";
    } else {
        remainingAmount = [NSString stringWithFormat:@"%0.2f", amount / 10000];
        unit = @"万";
    }
    return [NSString stringWithFormat:@"%@%@", remainingAmount, unit];
}

#pragma mark 处理投资份额
+(NSString *)dealCreditorAmount:(NSInteger)amount;
{
    
    NSString * remainingAmount;
    NSString * unit;
    if (amount < 10000)
    {
        remainingAmount = [NSString stringWithFormat:@"%zd", (long)amount];
        unit = @"份";
    } else {
        remainingAmount = [NSString stringWithFormat:@"%.2f",amount / 10000.0];
        unit = @"万份";
    }
    return [NSString stringWithFormat:@"%@%@", remainingAmount, unit];
    
}


#pragma mark 格式化所有带标签的文本
+(NSString *)filterHTML:(NSString *)html
{
    
    //    html = [html stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
    //
    //    html = [html stringByReplacingOccurrencesOfString:@"<h5>" withString:@"\n\n"];
    html = [[[html stringByReplacingOccurrencesOfString:@"</p><h5>" withString:@"\n\n"] stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"</h5><p>" withString:@"\n"];
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
    
    
}

@end

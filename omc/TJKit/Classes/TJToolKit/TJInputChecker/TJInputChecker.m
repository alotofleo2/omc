//
//  TJInputChecker.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/30.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJInputChecker.h"
#import "TJInputLimit.h"
#import "StringUtil.h"



/*
 *  交易密码的输入长度
 */
#define TRADEPASSWORD_LENGHT     6

@implementation TJInputChecker

#pragma mark  检测登录密码是否符合规范（使用时检测）

+ (BOOL)checkLoginPassword:(NSString *)loginPassword {
    
    //  登录密码输入为空
    if ([StringUtil isEmpty:loginPassword]) {
//        [THAlertUtil toastFromKey:@"login_password_is_null"];
        return NO;
    }
    
    //  密码长度不符合规定
    if ([loginPassword length] < INPUT_PASSWORD_MIN_LENGTH  ||
        [loginPassword length] > INPUT_PASSWORD_MAX_LENGTH ) {
//        [THAlertUtil toastFromKey:@"login_password_length_error"];
        return NO;
    }
    
    if (![StringUtil isLetterOrInt:loginPassword]) {
        return NO;
    }
    
    return YES;
}

#pragma mark 检测登录密码和确认登录密码（设置或重置）是否符合规范

+ (BOOL)checkLoginPassword:(NSString *)loginPassword confirmLoginPassword:(NSString *)confirmLoginpassword {
    
    //  登录新密码检测
    if (![self checkLoginPassword:loginPassword] ) {
        return NO;
    }
    
    //  登录确认密码检测
    if (![self checkLoginPassword:confirmLoginpassword] ) {
        return NO;
    }
    
    //  判断登录新密码与确认密码是否一致
    if (![loginPassword isEqualToString:confirmLoginpassword]) {
//        [THAlertUtil toastFromKey:@"register_password_twice_inconsistent"];
        return NO;
    }
    
    return YES;
}

#pragma mark -  检测交易密码是否符合规范（使用时检测）
// 检验交易密码规范是按照6位数字密码（暂时这么规定）
+ (BOOL)checkTradePassword:(NSString *)tradePassword {
    
    // 判断交易密码是否为空
    if ([StringUtil isEmpty:tradePassword]){
//        [THAlertUtil toastFromKey:@"trading_password_is_null"];
        return NO;
    }
    
    // 判断交易密码的长度是否为规定的六位数字
    if ([tradePassword length] != TRADEPASSWORD_LENGHT){
        
//        [THAlertUtil toastFromKey:@"trading_password_length_error"];
        return NO;
    }
    
    return YES;
}

#pragma makr- 检测登录密码和确认登录密码（设置或重置）是否符合规范
// 检验交易密码规范是按照6位数字密码
+ (BOOL)checkTradePassword:(NSString *)tradePassword confirmTradePassword:(NSString *)confirmTradepassword {
    
    //  交易新密码检测
    if (![self checkLoginPassword:tradePassword] ) {
        return NO;
    }
    
    //  交易确认密码检测
    if (![self checkLoginPassword:confirmTradepassword] ) {
        return NO;
    }
    
    //  判断交易新密码与确认密码是否一致
    if (![tradePassword isEqualToString:confirmTradepassword]) {
//        [THAlertUtil toastFromKey:@"trade_password_twice_inconsistent"];
        return NO;
    }
    
    return YES;
}

#pragma mark 验证手机号是否符合规范
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    
    // 手机号未输入
    if ([StringUtil isEmpty:phoneNumber])
    {
//        [THAlertUtil toastFromKey:@"phone_number_is_null"];
        return NO;
    }
    
    // 手机号长度不符合规定
    if ([phoneNumber length] != INPUT_PHONE_NUMBER_LENGTH)
    {
//        [THAlertUtil toastFromKey:@"phone_number_length_error"];
        return NO;
    }
    
    // 手机号格式错误
    if (![StringUtil checkMobileNumber:phoneNumber])
    {
//        [THAlertUtil toastFromKey:@"phone_number_format_error"];
        return NO;
    }
    
    if (![phoneNumber hasPrefix:@"1"]) {
        
        return NO;
    }
    
    return YES;
}


#pragma mark 验证短信验证是否符合规范
+ (BOOL)checkSMSVerifyCode:(NSString *)smsverifyCode {
    
    // 验证码未输入
    if ([StringUtil isEmpty:smsverifyCode])
    {
//        [THAlertUtil toastFromKey:@"verification_code_is_null"];
        return NO;
    }
    
    /*
     // 验证码长度不符合规定
     if ([smsverifyCode length] != INPUT_SMS_VERIFICATION_CODE_LENGTH)
     {
     [THAlertUtil toastFromKey:@"verification_code_error"];
     return NO;
     }
     */
    
    // 验证码格式不正确
    /*
     if (![self checkValidWithRegex:@"^[0-9]+$"]) // 已经限制验证码必须为数字 不需要判断验证码的格式
     {
     [AlertUtil toastFromKey:@"verification_code_format_error"];
     return NO;
     }
     */
    
    return YES;
}


#pragma mark 验证身份证号是否符合规范
+ (BOOL)checkIDCardNumber:(NSString *)idCardNumber {
    
    @try
    {
        if ([StringUtil isEmpty:idCardNumber]) {
            
//            [THAlertUtil toastFromKey:@"card_is_null"];
            return NO;
        }
        
        NSString * number = [idCardNumber uppercaseString];
        
        //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。
        if (![self checkValidWithRegex:@"^(\\d{14}|\\d{17})(\\d|[X])$" string:number]) //(\\d{15})|
        {
            NSLog(@"输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。");
//            [THAlertUtil toastFromKey:@"card_format_error"];
            return NO;
        }
        
        //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
        //下面分别分析出生日期和校验位
        NSInteger len = 0;
        
        len = [number length];
        
        if (len == 15)
        {
            //NSString * regexString = @"^(\\d{6})(\\d{2})(\\d{2})(\\d{2})(\\d{3})$";
            NSString * split1 = [number substringWithRange:NSMakeRange(0, 6)];
            NSString * split2 = [number substringWithRange:NSMakeRange(6, 2)];
            NSString * split3 = [number substringWithRange:NSMakeRange(8, 2)];
            NSString * split4 = [number substringWithRange:NSMakeRange(10, 2)];
//            NSString * split5 = [number substringWithRange:NSMakeRange(12, 3)];
            
//            NSLog(@"%@ %@ %@ %@ %@", split1, split2, split3, split4, split5);
            
            /*
             // 检查生日日期是否正确
             NSDate * birthDate = [self convertDateFromString:[NSString stringWithFormat:@"19%@%@%@", split2, split3, split4]];
             
             NSDateComponents * components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:birthDate];
             NSInteger year = [components year];
             NSInteger month = [components month];
             NSInteger day = [components day];
             */
            
            NSInteger year = [[NSString stringWithFormat:@"19%@", split2] integerValue];
            NSInteger month = [split3 integerValue];
            NSInteger day = [split4 integerValue];
            
            
            if (year == [[NSString stringWithFormat:@"19%@", split2] integerValue] && month == [split3 integerValue] && day == [split4 integerValue])
            {
                // 将15位身份证转成18位
                // 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
                int arrInt[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
                NSArray * arrCh = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                NSInteger nTemp = 0;
                
                //num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);
                number = [NSString stringWithFormat:@"%@19%@", split1, [number substringWithRange:NSMakeRange(6, [number length] - 6)]];
                
                for(NSInteger i = 0; i < 17; i ++)
                {
                    nTemp += [[number substringWithRange:NSMakeRange(i, 1)] integerValue] * arrInt[i];
                }
                
                number = [NSString stringWithFormat:@"%@%@", number, [arrCh objectAtIndex:nTemp % 11]];
                NSLog(@"15转18位身份证： %@", number);
                
            } else {
                
                NSLog(@"输入的身份证号里出生日期不对！");
//                [THAlertUtil toastFromKey:@"card_format_error"];
                return NO;
            }
        }
        
        
        len = [number length];
        
        if (len == 18)
        {
            //NSString * regexString = @"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})(\\d|[X])$";
            //NSArray * splitArray =[number componentsSeparatedByRegex:regexString];
            
//            NSString * split1 = [number substringWithRange:NSMakeRange(0, 6)];
            NSString * split2 = [number substringWithRange:NSMakeRange(6, 4)];
            NSString * split3 = [number substringWithRange:NSMakeRange(10, 2)];
            NSString * split4 = [number substringWithRange:NSMakeRange(12, 2)];
//            NSString * split5 = [number substringWithRange:NSMakeRange(14, 3)];
            NSString * split6 = [number substringWithRange:NSMakeRange(17, 1)];
            
//            NSLog(@"%@ %@ %@ %@ %@ %@", split1, split2, split3, split4, split5, split6);
            
            
            /*
             // 检查生日日期是否正确
             NSDate * birthDate = [self convertDateFromString:[NSString stringWithFormat:@"%@%@%@", split2, split3, split4]];
             
             NSDateComponents * components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:birthDate];
             
             NSInteger year = [components year];
             NSInteger month = [components month];
             NSInteger day = [components day];
             */
            
            NSInteger year = [split2 integerValue];
            NSInteger month = [split3 integerValue];
            NSInteger day = [split4 integerValue];
            
            
            if (year == [split2 integerValue] && month == [split3 integerValue] && day == [split4 integerValue])
            {
                // 检验18位身份证的校验码是否正确。
                // 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
                NSString * valnum;
                int arrInt[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
                NSArray * arrCh = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                
                NSInteger nTemp = 0;
                
                for(NSInteger i = 0; i < 17; i ++)
                {
                    //nTemp += num.substr(i, 1) * arrInt[i];
                    nTemp += [[number substringWithRange:NSMakeRange(i, 1)] integerValue] * arrInt[i];
                }
                
                valnum = [arrCh objectAtIndex:nTemp % 11];
                
                if (![valnum isEqualToString:split6])
                {
                    NSLog(@"18位身份证的校验码不正确！应该为：%@", valnum);
//                    [THAlertUtil toastFromKey:@"card_format_error"];
                    return NO;
                }
                
                return YES;
                
            } else {
                
                NSLog(@"输入的身份证号里出生日期不对！");
//                [THAlertUtil toastFromKey:@"card_format_error"];
                return NO;
            }
            
            return NO;
        }
        
    }
    @catch (NSException * exception) {
        
        NSLog(@"%@ %@", [exception name], [exception reason]);
//        [SVProgressHUD showImage:nil status:[exception reason]];
        [TJAlertUtil showNotificationWithTitle:@"错误" message:[exception reason]  type:TJMessageNotificationTypeError inViewController:nil];
    }
    @finally {
        
    }
    return NO;
}

+ (BOOL)checkValidWithRegex:(NSString *)regex string:(NSString *)string
{
    NSPredicate * regexString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regexString evaluateWithObject:string];
}

#pragma mark 检测银行卡号是否符合规范
+ (BOOL)checkBankCardNumber:(NSString *)bankCardNumber {
    
    // 判断输入的银行卡是否为空
    if ([StringUtil isEmpty:bankCardNumber]) {
//        [THAlertUtil toastFromKey:@"bankcard_is_null"];
        return NO;
    }
    
    // 判断银行卡输入的输入是否符合规范
    if (![self validateBankCardWith:bankCardNumber]){
//        [THAlertUtil toastFromKey:@"bankcard_format_error"];
        return NO;
    }
    
    return YES;
}

//验证银行卡是否输入正确
+ (BOOL)validateBankCardWith:(NSString *)bankCardNumber {
    
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

#pragma mark 检测真实姓名输入是否符合规范
+ (BOOL)checkTrueName:(NSString *)trueName {
    
    // 判断真实姓名是否为空
    if ([StringUtil isEmpty:trueName]) {
//        [THAlertUtil toastFromKey:@"name_is_null"];
        return NO;
    }
    
    
    if ([trueName length] < INPUT_NAME_MIN_LENGTH || [trueName length] > INPUT_NAME_MAX_LENGTH) {
        
//        [THAlertUtil toastFromKey:@"name_format_error"];
        return NO;
    }
    
    return YES;
}

// 判断真实姓名是否符合规范
+ (BOOL)validateUserName:(NSString *)username {
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:username];
    return B;
}


#pragma mark 验证邮箱是否符合规范
+ (BOOL)checkMailBox:(NSString *)mailBox {
    
    // 判断输入邮箱是否为空
    if ([StringUtil isEmpty:mailBox]){
        

        return NO;
    }
    
    // 判断邮箱的输入格式
    if (![self isEmail:mailBox]){

        return NO;
    }
    
    return YES;
}

// 判断邮箱是否符合规范
+ (BOOL)isEmail:(NSString *)email {
    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end

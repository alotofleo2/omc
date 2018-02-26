//
//  NSString+URL.m
//  RiceWallet
//
//  Created by 方焘 on 2017/8/2.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "NSString+URL.h"
#import "StringUtil.h"

@implementation NSString (URL)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"



- (NSString *)URLEncodedString {
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)URLDecodedString {
    
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    NSString * decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return decoded;
}
#pragma clang diagnostic pop
- (NSString *)URLQueryEncode{
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end

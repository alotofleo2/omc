//
//  AESUtil.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/30.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtil : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密

+ (NSString*)AES128Encrypt:(NSString *)plainText;

+ (NSString*)AES128Decrypt:(NSString *)encryptText;


@end

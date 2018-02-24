//
//  NSString+URL.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/2.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (URL)


- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

/**
 *  编码发起请求的url字符串
 *  @return 编码后url
 */
- (NSString *)URLQueryEncode;

@end

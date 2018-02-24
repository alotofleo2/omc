//
//  NSData+AES.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/30.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)
- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密
@end

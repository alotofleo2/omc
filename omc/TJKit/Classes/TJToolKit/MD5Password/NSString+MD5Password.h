//
//  NSString+MD5Password.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/18.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Password)

/**
 *  md5加密 拼接 tairancheng md5 再截取前20
 *
 *  @return 加密完的字符串
 */
- (NSString *)md5Password;
@end

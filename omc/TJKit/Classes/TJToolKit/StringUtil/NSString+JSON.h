//
//  NSString+JSON.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/16.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @return 解析结果字典
 */
- (NSDictionary *)dictionaryWithJsonString;


/**
 *  把格式化的JSON格式的字符串转换成基本数据对象
 *
 *  @return 解析结果对象
 */
- (id)JSONObjectWithString;


/**
 *  把字典转化为json字符串
 *
 *  @param dic 目标字典
 *
 *  
 */
+ (NSString *)getJsonStringWithDictionary:(NSDictionary *)dic;
@end

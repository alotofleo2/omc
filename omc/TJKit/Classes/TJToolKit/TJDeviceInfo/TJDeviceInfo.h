//
//  TJDeviceInfo.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJDeviceInfo : NSObject
/**
 *  生成Dictionary格式的设备信息
 *
 *  @return 生成的设备信息
 */
+ (NSDictionary *)generateDeviceInfo;
@end

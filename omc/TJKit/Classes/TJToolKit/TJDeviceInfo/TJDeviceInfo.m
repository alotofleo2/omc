//
//  TJDeviceInfo.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJDeviceInfo.h"
#import "sys/utsname.h"
#import <UIKit/UIKit.h>

@implementation TJDeviceInfo
+ (NSDictionary *)generateDeviceInfo {
    
    int scale = [[UIScreen mainScreen] scale];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    NSMutableDictionary * deviceInfo = [[NSMutableDictionary alloc] init];
    
    // 屏幕高度
    [deviceInfo setValue:[NSString stringWithFormat:@"%d", (int)(screenSize.height * scale)] forKey:@"screenheight"];
    
    // 屏幕宽度
    [deviceInfo setValue:[NSString stringWithFormat:@"%d", (int)(screenSize.width * scale)] forKey:@"screenwidth"];
    
    // 操作系统类型
    [deviceInfo setValue:@"I" forKey:@"ostype"];
    
    // 操作系统版本
    [deviceInfo setValue:[[UIDevice currentDevice] systemVersion] forKey:@"deviceVersion"];
    
    // 手机厂商
    [deviceInfo setValue:@"Apple" forKey:@"operator"];
    
    // 手机机型
    [deviceInfo setValue:[[UIDevice currentDevice] model] forKey:@"deviceModel"];
    
    NSString * appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    // 版本信息
    [deviceInfo setValue:appVersion forKey:@"clientVersion"];
    
    // 手机唯一标识码
    [deviceInfo setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"deviceImei"];
    
//    [deviceInfo setValue:@"0" forKey:@"version-state"];
    
    return deviceInfo;
}


+ (NSString*)getDeviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}
@end

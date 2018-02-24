//
//  TJNetworkKit.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#ifndef TJNetworkKit_h
#define TJNetworkKit_h
#import "TJRequest.h"
#import "TJResult.h"
#import "TJTokenManager.h"

/**
 *  运行测试用例模式（仅POST有效）
 */
#define THRunTestMode 0


/**
 *  是否打印网络请求的Header信息
 */
#define TH_REQUEST_HEADER_ENABLE 0


/**
 *  是否开启网络请求日志的打印
 */
#define REQUEST_LOG_ENABLE 1




#if REQUEST_LOG_ENABLE

#define TJRequestLog(...)  NSLog(__VA_ARGS__)

#else

#define TJRequestLog(...)

#endif

#endif /* TJNetworkKit_h */

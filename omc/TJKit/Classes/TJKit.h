//
//  TJKit.h
//  xianjindai
//
//  Created by 方焘 on 2017/6/30.
//  Copyright © 2017年 现金贷. All rights reserved.
//

#ifndef TJKit_h
#define TJKit_h
#import "TJCommonKit.h"
#import "TJToolKit.h"
#import "TJUIKit.h"
#ifdef DEBUG

/**
 *  Debug模式开启Settings Bundle功能
 *
 */
#define SettingsBundleEnable  1





#else

#define NSLog(...)
#define SettingsBundleEnable 0


#endif
#endif /* TJKit_h */

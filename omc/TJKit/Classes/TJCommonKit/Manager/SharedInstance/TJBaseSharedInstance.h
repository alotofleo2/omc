//
//  TJBaseSharedInstance.h
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/4/18.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJBaseSharedInstance : NSObject
/**
 *  单例模式
 *
 *  @return 单例对象
 */
+ (instancetype)sharedInstance;


/**
 *  单例模式
 *
 *  @return 单例对象
 */
+ (instancetype)defaultManager;


@end

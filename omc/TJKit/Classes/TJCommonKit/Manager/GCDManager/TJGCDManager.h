//
//  TJGCdManager.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/7.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^gblock)(void);

/**
 *  封装了GCD中书写繁琐的部分方法
 *   +(void)serialWithFirst... 串行队列
 *  +(void)asyncMainThreadBlock... 异步主线程
 */

@interface TJGCDManager : NSObject
/**
 *  串行队列
 */
+ (dispatch_queue_t)serialQueue;

/**
 *  GCD串行队列,顺序执行,两段block默认在主线程异步执行
 *  firstBlock 第一个需要执行的方法
 *  secondBlock 第二个需要执行的方法
 */
+(void)serialWithFirstBlock:(gblock)firstBlock secondBlock:(gblock)secondBlock;

/**  GCD主线程 */
+(void)asyncMainThreadBlock:(gblock)block;


/**
 *  分线程
 */
+(void)asyncGlobalQueueThreadBlock:(gblock)block;
@end

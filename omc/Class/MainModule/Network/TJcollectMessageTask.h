//
//  TJcollectMessageTask.h
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJcollectMessageTask : NSObject
/**
 第一次安装app下载量收集接口
 
 @param successBlock 成功回调
 @param failureBlock 失败回调
 
 */
+ (TJRequest *)uploadFirstDownloadAppWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                         failureBlock:(TJRequestFinishedBlock)failureBlock;
/**
 详情页停留时间收集接口
 
 @param successBlock 成功回调
 @param failureBlock 失败回调
 
 */
+ (TJRequest *)uploadProductDetailStayTimeWithPorductId:(NSString *)productId
                                               stayTime:(NSTimeInterval)stayTime
                                           successBlock:(void (^)(TJResult *result))successBlock
                                           failureBlock:(TJRequestFinishedBlock)failureBlock;

@end

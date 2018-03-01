//
//  TJHomeTask.h
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TJRequestFinishedBlock)(TJResult * result);
@interface TJHomeTask : NSObject

/**
 首页内容的请求

 @param successBlock 成功回调
 @param failureBlock 失败回调
 
 */
+ (TJRequest *)getHomeWithSuccessBlock:(void (^)(TJResult *result))successBlock
                              failureBlock:(TJRequestFinishedBlock)failureBlock;


/**
 获取首页分类内容

 @param primaryKey 分类的识别号
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (TJRequest *)getHomeContentWithPrimaryKey:(NSInteger)primaryKey
                               SuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

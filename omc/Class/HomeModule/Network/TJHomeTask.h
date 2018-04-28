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

/**
 获取搜索热门搜索关键字
 */
+ (TJRequest *)getSearchHotKeysWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                   failureBlock:(TJRequestFinishedBlock)failureBlock;

/**
 详情页数据请求
 
 @param productId 产品Id
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (TJRequest *)getProductDetialWithProductId:(NSString *)productId
                                    bannerId:(NSString *)bannerId
                                SuccessBlock:(void (^)(TJResult *result))successBlock
                                failureBlock:(TJRequestFinishedBlock)failureBlock;

/**
 详情页案例分页
 
 @param productId 产品Id
 @param pageNumber 分页数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (TJRequest *)getProductCaseWithProductId:(NSString *)productId
                                pageNumber:(NSInteger)pageNumber
                                SuccessBlock:(void (^)(TJResult *result))successBlock
                                failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

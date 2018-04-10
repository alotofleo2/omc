//
//  TJCategoryTask.h
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJCategoryTask : NSObject
/**
 分类列表的请求
 
 @param successBlock 成功回调
 @param failureBlock 失败回调
 
 */
+ (TJRequest *)getCategoryListWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                  failureBlock:(TJRequestFinishedBlock)failureBlock;

/**
 获取分类内容

 @param cateId 分类id
 @param keywords 关键字
 */
+ (TJRequest *)getCategoryContentWithCateId:(NSString *)cateId
                                   keywords:(NSString *)keywords
                                 pageNumber:(NSInteger)pageNumber
                               successBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock;

@end

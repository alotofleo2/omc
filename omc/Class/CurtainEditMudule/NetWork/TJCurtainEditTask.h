//
//  TJCurtainEditTask.h
//  omc
//
//  Created by 方焘 on 2018/4/3.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TJRequestFinishedBlock)(TJResult * result);
@interface TJCurtainEditTask : NSObject

/**
 获取窗帘素材
 
 @param productId 产品Id
 @param number 产品编号
 
 */
+ (TJRequest *)getMaterialsWithProductId:(NSString *)productId
                                  number:(NSString *)number
                             successBlock:(void (^)(TJResult *result))successBlock
                             failureBlock:(TJRequestFinishedBlock)failureBlock;


@end

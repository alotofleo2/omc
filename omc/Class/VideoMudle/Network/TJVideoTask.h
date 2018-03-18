//
//  TJVideoTask.h
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TJRequestFinishedBlock)(TJResult * result);
@interface TJVideoTask : NSObject
/**
 视频首页内容的请求
 
 @param successBlock 成功回调
 @param failureBlock 失败回调
 
 */
+ (TJRequest *)getVideoListWithSuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

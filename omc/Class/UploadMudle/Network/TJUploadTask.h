//
//  TJUplpadTask.h
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TJRequestFinishedBlock)(TJResult * result);
@interface TJUploadTask : NSObject
/**
 上传图片方法 默认POST
 */
+ (TJRequest *)uploadWithImages:(NSDictionary *)images
                  number:(NSString *)number
                describe:(NSString *)describe
           progressBlock:(void(^)(NSProgress *progress))progressBlock
            successBlock:(void (^)(TJResult *result))successBlock
            failureBlock:(TJRequestFinishedBlock)failureBlock;

/**
 获取上传列表

 @param type 列表类型 (false或者不传返回 已上传,  其他都返回 未通过)

 */
+ (TJRequest *)getUploadListWithType:(NSString *)type
                        successBlock:(void (^)(TJResult *result))successBlock
                        failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

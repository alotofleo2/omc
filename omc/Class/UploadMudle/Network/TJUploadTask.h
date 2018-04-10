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

 @param type 列表类型 参数或参数为0时，查询待审核的案例，传参为1时查询已通过的案例，传参为2时查询未通过的案例

 */
+ (TJRequest *)getUploadListWithType:(NSString *)type
                          pageNumber:(NSInteger)pageNumber
                        successBlock:(void (^)(TJResult *result))successBlock
                        failureBlock:(TJRequestFinishedBlock)failureBlock;

/**
 删除未通过上传的方法

 @param BuyrsShowId 主键(在获取列表时获取到)
 */
+ (TJRequest *)deleteUploadListItemWithBuyrsShowId:(NSString *)BuyrsShowId
                                      successBlock:(void (^)(TJResult *result))successBlock
                                      failureBlock:(TJRequestFinishedBlock)failureBlock;
@end

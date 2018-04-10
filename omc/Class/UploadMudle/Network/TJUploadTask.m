//
//  TJUplpadTask.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadTask.h"
#import "TJUploadDefines.h"

@implementation TJUploadTask

#pragma mark 上传图片方法 默认POST
+ (TJRequest *)uploadWithImages:(NSDictionary *)images
                  number:(NSString *)number
                describe:(NSString *)describe
           progressBlock:(void(^)(NSProgress *progress))progressBlock
            successBlock:(void (^)(TJResult *result))successBlock
            failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest * request = [[TJRequest alloc] init];
    NSDictionary * params = @{ @"number" : number ?: @"",
                               @"desc" : describe ?: @"" };
    
    [request uploadWithURLString:[NSString stringWithFormat:@"%@%@", [TJURLConfigurator shareConfigurator].baseURL, @"shows"] images:images Params:params progressBlock:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } successBlock:^(TJResult *result) {
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:^(TJResult *result) {
        if (failureBlock) {
            failureBlock(result);
        }
    }];
    
    
    
    return request;
}

+ (TJRequest *)getUploadListWithType:(NSString *)type
                          pageNumber:(NSInteger)pageNumber
                        successBlock:(void (^)(TJResult *result))successBlock
                        failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    NSDictionary * params = @{@"status" : type ?: @"",
                              @"per-page" : @"4",
                              @"page" : @(pageNumber).stringValue
                              };
    [request startWithURLString:kUpload_upload Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

/**
 删除未通过上传的方法
 
 @param BuyrsShowId 主键(在获取列表时获取到)
 */
+ (TJRequest *)deleteUploadListItemWithBuyrsShowId:(NSString *)BuyrsShowId
                                      successBlock:(void (^)(TJResult *result))successBlock
                                      failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeDELETE;
    

    [request startWithURLString:[NSString stringWithFormat:@"%@/%@",kUpload_delete, BuyrsShowId ?: @""] Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

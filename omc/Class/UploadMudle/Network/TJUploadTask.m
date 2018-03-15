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
                        successBlock:(void (^)(TJResult *result))successBlock
                        failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    NSDictionary * params = @{@"status" : type ?: @"" };
    [request startWithURLString:kUpload_upload Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

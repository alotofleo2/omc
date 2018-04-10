//
//  TJcollectMessageTask.m
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJcollectMessageTask.h"
#import "TJcollectMessageDefine.h"

@implementation TJcollectMessageTask
#pragma mark 第一次安装app下载量收集接口
+ (TJRequest *)uploadFirstDownloadAppWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                         failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    NSDictionary *params = @{@"model" : @"1", //1为Ios
                             @"device" : [[[UIDevice currentDevice] identifierForVendor] UUIDString]};
    
    
    [request startWithURLString:kCollectMessage_firstDownLoad Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

#pragma mark 详情页停留时间收集接口
+ (TJRequest *)uploadProductDetailStayTimeWithPorductId:(NSString *)productId
                                               stayTime:(NSTimeInterval)stayTime
                                           successBlock:(void (^)(TJResult *result))successBlock
                                           failureBlock:(TJRequestFinishedBlock)failureBlock {
    NSInteger integerTime = (NSInteger)stayTime;
    
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypePOST;
    
    NSDictionary *params = @{@"model" : @"1", //1为Ios
                             @"productId" : productId ?: @"",
                             @"pause" : @(integerTime)
                             };
    
    
    [request startWithURLString:kCollectMessage_productDetailStay Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

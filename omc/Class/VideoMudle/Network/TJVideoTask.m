//
//  TJVideoTask.m
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJVideoTask.h"
#import "TJVideoDefines.h"

@implementation TJVideoTask

#pragma mark 视频首页列表请求
+ (TJRequest *)getVideoListWithSuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    
    [request startWithURLString:kVideo_List Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

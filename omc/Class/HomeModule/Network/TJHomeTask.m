//
//  TJHomeTask.m
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeTask.h"
#import "TJHomeDefines.h"

@implementation TJHomeTask
#pragma mark 首页内容
+ (TJRequest *)getHomeWithSuccessBlock:(void (^)(TJResult *result))successBlock
                          failureBlock:(TJRequestFinishedBlock)failureBlock {
        TJRequest *request = [[TJRequest alloc]init];
    
        request.requestType = TJHTTPReuestTypeGET;
    
    
        [request startWithURLString:kHome_homes Params:nil successBlock:^(TJResult *result) {
    
            if (successBlock) successBlock(result);
    
        } failureBlock:^(TJResult *result) {
    
            if (failureBlock) failureBlock(result);
    
        }];
    
        return request;
}

#pragma mark  获取首页分类内容

+ (TJRequest *)getHomeContentWithPrimaryKey:(NSInteger)primaryKey
                               SuccessBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    
    [request startWithURLString:[NSString stringWithFormat:@"%@/%ld", kHome_homes, primaryKey] Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

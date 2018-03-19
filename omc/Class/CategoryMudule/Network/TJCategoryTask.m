//
//  TJCategoryTask.m
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryTask.h"
#import "TJCategoryDefines.h"

@implementation TJCategoryTask
#pragma mark 分类列表请求
+ (TJRequest *)getCategoryListWithSuccessBlock:(void (^)(TJResult *result))successBlock
                                  failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    
    [request startWithURLString:kCateGory_cates Params:nil successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}

#pragma mark 获取分类内容
+ (TJRequest *)getCategoryContentWithCateId:(NSString *)cateId
                                   keywords:(NSString *)keywords
                               successBlock:(void (^)(TJResult *result))successBlock
                               failureBlock:(TJRequestFinishedBlock)failureBlock{
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    NSDictionary *params = @{@"cateId" : cateId ?: @"",
                             @"keywords" : keywords ?: @""
                             };
    
    [request startWithURLString:kCateGory_products Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

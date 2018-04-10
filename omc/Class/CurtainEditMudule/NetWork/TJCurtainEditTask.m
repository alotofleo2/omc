//
//  TJCurtainEditTask.m
//  omc
//
//  Created by 方焘 on 2018/4/3.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditTask.h"
#import "TJCurtainEditDefines.h"

@implementation TJCurtainEditTask
#pragma mark  获取窗帘素材
+ (TJRequest *)getMaterialsWithProductId:(NSString *)productId
                                  number:(NSString *)number
                            successBlock:(void (^)(TJResult *result))successBlock
                            failureBlock:(TJRequestFinishedBlock)failureBlock {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    NSDictionary * params = @{@"parentCateId" : productId ?: @"" ,
                              @"number"       : number    ?: @""};
    [request startWithURLString:kCurtainEdit_materials Params:params successBlock:^(TJResult *result) {
        
        if (successBlock) successBlock(result);
        
    } failureBlock:^(TJResult *result) {
        
        if (failureBlock) failureBlock(result);
        
    }];
    
    return request;
}
@end

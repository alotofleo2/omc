//
//  TJCollectMessageManager.m
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCollectMessageManager.h"
#import "TJcollectMessageTask.h"

@implementation TJCollectMessageManager
- (void)uploadFirstDownloadApp {
    [TJcollectMessageTask uploadFirstDownloadAppWithSuccessBlock:^(TJResult *result) {
        NSLog(@"首次下载App统计成功");
    } failureBlock:^(TJResult *result) {
        NSLog(@"首次下载App统计失败");
    }];
}

- (void)uploadProductDetailStayTimeWithPorductId:(NSString *)productId stayTime:(NSTimeInterval)stayTime {
    [TJcollectMessageTask uploadProductDetailStayTimeWithPorductId:productId stayTime:stayTime successBlock:^(TJResult *result) {
        NSLog(@"productId%@详情页上传统计成功时间为:%lf", productId, stayTime);
    } failureBlock:^(TJResult *result) {
        NSLog(@"详情页上传统计失败,errorCode:%ld", result.errcode);
    }];
}
@end

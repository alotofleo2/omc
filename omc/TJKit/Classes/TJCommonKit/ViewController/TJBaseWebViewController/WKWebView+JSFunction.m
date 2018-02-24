//
//  WKWebView+JSFunction.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/28.
//  Copyright © 2016年 taofang. All rights reserved.

#import "WKWebView+JSFunction.h"

@implementation WKWebView (JSFunction)

- (void)runWebFunction:(NSString *)methodName
              argument:(NSString *)argument
                 error:(void (^)(NSString *))error {
    
    NSString *notNilArgument = ([argument length]==0)?@"":argument;
    
    // 调用JS方法，参数需要添加双引号
    notNilArgument = [NSString stringWithFormat:@"\"%@\"",notNilArgument];
    [self evaluateJavaScript:[NSString stringWithFormat:@"%@(%@)",methodName,notNilArgument] completionHandler:^(id info, NSError *error) {
    }];
}

@end

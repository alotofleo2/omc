//
//  WKWebView+JSFunction.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/28.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (JSFunction)

/**
 *  JS方法调用
 *
 *  @param methodName 方法名
 *  @param argument   入参，如果无入参传入nil
 *  @param error      错误信息
 */
- (void)runWebFunction:(NSString *)methodName
              argument:(NSString *)argument
                 error:(void (^)(NSString *))error;
@end
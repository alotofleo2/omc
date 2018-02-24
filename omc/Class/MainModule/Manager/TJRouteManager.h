//
//  TJRouteManger.h
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"

@interface TJRouteManager : TJBaseSharedInstance
- (void)parseWithUrl:(NSString *)url;

/**
 *  带控制器的解析页面处理方法
 *
 *   url
 *   controller
 */
- (void)parseWithUrl:(NSString *)url
    inViewController:(TJBaseWebViewController *)webViewController;
@end

//
//  TJBaseWebViewController.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/28.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseViewController.h"
#import "TJWebViewProgressView.h"
#import "WKWebView+JSFunction.h"
#import <WebKit/WebKit.h> 

@interface TJBaseWebViewController : TJBaseViewController <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

/**
 *  导航标题
 */
@property(nonatomic,strong) NSString * titleString;

/**
 *  需求请求加载的url
 */
@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, strong) UIColor *progressBarColor;

@property (nonatomic, weak) WKNavigation *backNavigation;

//setCookie可以重写
- (void)loadUrl:(NSString *)urlStr;

//设置返回按钮默认状态
- (void)setGoBack;
@end

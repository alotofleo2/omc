//
//  TJWebViewProgressView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/28.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TJWebViewProgressView : UIView

/**
 *  进度条的进度
 */
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, readonly) UIView *progressBarView;

@property (nonatomic, assign) NSTimeInterval barAnimationDuration;// default 0.5

@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration;// default 0.27
/**
 *  进度条的颜色
 */
@property (copy, nonatomic) UIColor *progressBarColor;


/**
 *  使用WKWebKit
 *
 *  @param webView WKWebView对象
 */
- (void)useWkWebView:(WKWebView *)webView;
@end

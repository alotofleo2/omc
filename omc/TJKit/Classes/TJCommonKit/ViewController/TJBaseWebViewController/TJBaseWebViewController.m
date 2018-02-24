//
//  TJBaseWebViewController.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/28.
//  Copyright © 2016年 taofang. All rights reserved.
//


#import "TJBaseWebViewController.h"
#import "TJWebViewProgressView.h"
#import "Masonry.h"

@interface TJBaseWebViewController ()

@property (nonatomic, assign) BOOL isFirstLoad;

@property (nonatomic, strong) TJWebViewProgressView *progressView;

@end

@implementation TJBaseWebViewController

#pragma mark - Lift Cycle

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.wkWebView removeObserver:self.progressView forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.titleString.length > 0) {
        
        self.navigationController.navigationItem.title = self.titleString;
    }
    
    [self setupWebView];
    
    [self loadUrl:self.urlStr];
    
    
}

#pragma mark - private
- (void)setupWebView {
    
    WKUserContentController* userContentController = [WKUserContentController new];
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: [NSString stringWithFormat:@"%@", [[TJTokenManager sharedInstance] getWebCookieString]] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    
    
    //添加webView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    WKProcessPool *processPool = [[WKProcessPool alloc]init];
    
    config.processPool = processPool;
    
    config.userContentController = userContentController;
    
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    
    self.wkWebView.UIDelegate = self;
    
    self.wkWebView.navigationDelegate = self;
    
    [self.view addSubview:self.wkWebView];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    
    // 创建进度条
    TJWebViewProgressView *progressView = [[TJWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 3)];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    
    self.progressView = progressView;
    
    [progressView useWkWebView:self.wkWebView];
    
    [self.view addSubview:progressView];
}

- (void)loadUrl:(NSString *)urlStr {
    if (urlStr) {

        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
}

- (void)setGoBack {
    BLOCK_WEAK_SELF
    if([self.wkWebView canGoBack]) {
        [self addNavBackButtonWithDefaultAction];
        self.backBlock = ^{
          weakSelf.backNavigation =  [weakSelf.wkWebView goBack];
        };
    } else {
        self.backBlock = nil;
        if (self.navigationController.viewControllers.count == 1) {
            
            self.backButton.hidden = YES;
        }
    }
}
#pragma mark - WKNavigationDelegate
#pragma  mark 加载过程
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    [self requestTableViewDataSource];
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

//页面加载完成之后调用
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self requestTableViewDataSourceSuccess:@[@1]];

    BLOCK_WEAK_SELF
    if (!self.backBlock) {
        [self setGoBack];
    }
    
    
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
        weakSelf.navigationItem.title = (NSString *)response;
        
    }];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
}


//页面加载失败后调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self requestTableViewDataSourceFailure];
}

#pragma mark 页面跳转
//接收到服务器跳转请求后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    
}

//收到响应后,决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//再发送请求之前,决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    
     
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate
//js的对话框是不能在iOS中显示的，要想显示这些对话框就需要调用iOS中的相应方法。
//警告框
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"runJavaScriptAlertPanelWithMessage");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        completionHandler();
        
    }]];
    [self presentViewController:alertController animated:YES completion:completionHandler];
}

//确认框
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:( WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"runJavaScriptConfirmPanelWithMessage");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
            completionHandler(YES);
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){

            completionHandler(NO);
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//输入框
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:( void (^)(NSString * _Nullable))completionHandler {
    
    NSLog(@"runJavaScriptTextInputPanelWithPrompt");
    completionHandler(@"Client Not handler");
}

#pragma mark 加载失败页的代理回调
- (void)reloadViewPressed {
    [self.wkWebView reload];
}

#pragma mark - setter
- (void)setProgressBarColor:(UIColor *)progressBarColor {
    _progressBarColor = progressBarColor;
    
    self.progressView.progressBarColor = progressBarColor;
}
@end

//
//  TJRequest.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "TJHTTPSessionManager.h"
#import "TJResult.h"

/**
 *  退出登录状态，发送退出登录和清除手势密码的通知名称
 */
static NSString * const TJLogoutAndCleanGesturePassword = @"TJLogoutAndCleanGesturePassword";


/**
 *  HTTP请求类型
 */
typedef NS_ENUM(NSUInteger, TJHTTPReuestType){
    /**
     *  无类型
     */
    TJHTTPReuestTypeNone,
    
    /**
     *  返回服务器针对特定资源所支持的HTTP请求方法。也可以利用向Web服务器发送'*'的请求来测试服务器的功能性。
     */
    TJHTTPReuestTypeOPTIONS,
    
    /**
     *  向服务器索要与GET请求相一致的响应，只不过响应体将不会被返回。这一方法可以在不必传输整个响应内容的情况下，就可以获取包含在响应消息头中的元信息。
     */
    TJHTTPReuestTypeHEAD,
    
    /**
     *  向特定的资源发出请求。
     */
    TJHTTPReuestTypeGET,
    
    
    /**
     *  向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的创建和/或已有资源的修改。
     */
    TJHTTPReuestTypePOST,
    
    
    /**
     *  向指定资源位置上传其最新内容。
     */
    TJHTTPReuestTypePUT,
    
    
    /**
     *  请求服务器删除Request-URI所标识的资源。
     */
    TJHTTPReuestTypeDELETE,
    
    
    /**
     *  回显服务器收到的请求，主要用于测试或诊断。
     */
    TJHTTPReuestTypeTRACE,
    
    
    /**
     *  HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器。
     */
    TJHTTPReuestTypeCONNECT,
};


typedef NS_ENUM(NSInteger, TJStatusCodeType) {
    
    
    /**
     *  请求成功
     */
    TJStatusCodeTypeRequsetSuccess = 200,
    
    /**
     *  请求超时
     */
    TJStatusCodeTypeRequsetTimeOut = -1001,
    
    /**
     *  Session超时
     */
    TJStatusCodeTypeSessionTimeOut = 405,
};


#define TJ_REQUSET_TIMEOUT_INTERVAL 30

#define kRequestURL @"clientInterface.do"


typedef void (^TJRequestFinishedBlock)(TJResult * result);

@interface TJRequest : NSObject

/**
 *  当前正在执行的操作
 */
@property (nonatomic, weak) NSURLSessionDataTask * task;


/**
 *   HTTP请求的类型
 */
@property (nonatomic, assign) TJHTTPReuestType requestType;


/**
 头部需要加入的参数
 */
@property (nonatomic, copy) NSDictionary *header;


/**
 *  请求地址
 */
@property (strong, readonly, nonatomic) NSString * requestURL;


- (void)startWithURLString:(NSString *)urlString
                    Params:(id)params
              successBlock:(TJRequestFinishedBlock)successBlock;

- (void)startWithURLString:(NSString *)urlString
                 Params:(id)params
           successBlock:(TJRequestFinishedBlock)successBlock
           failureBlock:(TJRequestFinishedBlock)failureBlock;


- (void)uploadWithURLString:(NSString *)urlString
                     images:(NSDictionary *)images
                     Params:(id)params
              progressBlock:(void(^)(NSProgress *progress))progressBlock
               successBlock:(TJRequestFinishedBlock)successBlock
               failureBlock:(TJRequestFinishedBlock)failureBlock;
/**
 *  取消当前正在执行的请求
 */
- (void)cancel;
@end

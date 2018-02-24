//
//  TJURLConfigurator.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  环境类型
 */
typedef NS_ENUM(NSInteger, TJEnvironmentType) {
    
    /**
     *  生产环境(线上)
     */
    TJEnvironmentTypeProduction = 0,
    
    /**
     *  准生产环境
     */
    TJEnvironmentTypeStaging,
    
    /**
     *  测试环境
     */
    TJEnvironmentTypeDebug,
    
    /**
     *  开发环境
     */
    TJEnvironmentTypeDevelopment,

};

@interface TJURLConfigurator : NSObject
/**
 *  网络请求的环境类型（默认为生产环境）
 */
@property (nonatomic, assign) TJEnvironmentType environmentType;


/**
 *  连接的服务器地址
 */
@property (nonatomic, copy, readonly) NSString *baseURL;


/**
 *  网络请求的地址，通过environmentType设置
 */
@property (nonatomic, copy, readonly) NSString *requestURL;

/**
 *  自定义服务器的环境配置
 */
@property (nonatomic,strong) NSString *customEnvironment;



/**
 *  单例模式
 *
 *  @return 实例化对象
 */
+ (instancetype)shareConfigurator;

//=======================url跳转==========

/**
 *  h5页面的地址
 */
@property (nonatomic, copy, readonly) NSString *prefixUrl;

// 跳转授信流程
@property (nonatomic, copy) NSString *creditListUrl;

// 跳转借款流程
@property (nonatomic, copy) NSString *borrowFlowUrl;

// 跳转还款流程
@property (nonatomic, copy) NSString *returnFlowUrl;

// 跳转到实名认证页面
@property (nonatomic, copy) NSString *certificationUrl;

// 跳转到芝麻信用
@property (nonatomic, copy) NSString *zhimaCreditUrl;

// 跳转到运营商认证页面
@property (nonatomic, copy) NSString *operateUrl;



// ===========我的
// 跳转借款记录
@property (nonatomic, copy) NSString *borrowListUrl;

// 跳转优惠券
@property (nonatomic, copy) NSString *couponUrl;

// 跳转有奖邀请
@property (nonatomic, copy) NSString *inviteUrl;

// 跳转到优惠券规则页面
@property (nonatomic, copy) NSString *useRuleUrl;

// 跳转到个人资料
@property (nonatomic, copy) NSString *userDataUrl;


// ===========协议
// 跳转会员服务协议
@property (nonatomic, copy) NSString *serverProtocolUrl;

// 米粒钱包自动签约授权书
@property (nonatomic, copy) NSString *autoSignProtocolUrl;

// 米粒用户信息查询授权书
@property (nonatomic, copy) NSString *userSearchSignProtocolUrl;
@end

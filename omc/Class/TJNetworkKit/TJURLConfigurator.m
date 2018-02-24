//
//  TJURLConfigurator.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJURLConfigurator.h"

@implementation TJURLConfigurator
#pragma mark - Lifecycle
- (void)dealloc {
    
}

- (id)init {
    
    if (self = [super init]) {
        
        self.environmentType = TJEnvironmentTypeProduction;
    }
    
    return self;
}


#pragma mark - Public Methods
+ (instancetype)shareConfigurator {
    static TJURLConfigurator * configurator;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        configurator = [[TJURLConfigurator alloc] init];
        
        
    });
    
    return configurator;
}

#pragma mark - getter

- (void)setEnvironmentType:(TJEnvironmentType)environmentType {
    
    _environmentType = environmentType;
    
    switch (environmentType) {
            
        case TJEnvironmentTypeProduction: {
            
            // 生产环境
            _baseURL = @"https://api.360mijin.com/";
            _prefixUrl = @"https://m.360mijin.com";
            break;
        }
            
        case TJEnvironmentTypeStaging: {
            
            // 准生产环境
            _baseURL =  @"http://192.168.16.174:8081/mili";
            _prefixUrl = @"http://192.168.16.174:8081/wallet";
            break;
        }
            
        case TJEnvironmentTypeDebug: {
            
            // 测试环境
            _baseURL = @"http://dev.whaledata.cn:81/mili/mili/";
            _prefixUrl = @"http://dev.whaledata.cn:81/wallet";
            break;
        }
            
        case TJEnvironmentTypeDevelopment: {
            
            // 开发环境

            _baseURL = @"http://10.200.150.5:4000";
            _prefixUrl = @"http://dev.whaledata.cn:81/wallet";
            break;
        }
            
        default:
            _baseURL = @"http://192.168.129.145:8090/app/";
            break;
    }
    
    [self setupUrl];
    // 网络请求的地址
    _requestURL = [NSString stringWithFormat:@"%@/clientInterface.do", _baseURL];
    

}


#pragma mark 自定义服务器的环境配置
- (void)setCustomEnvironment:(NSString *)customEnvironment {
    
    if ([customEnvironment hasPrefix:@"http"]) {
        
        _baseURL = customEnvironment;
        _requestURL = [NSString stringWithFormat:@"%@/clientInterface.do", customEnvironment];;
        
    } else {
        
        [self setEnvironmentType:TJEnvironmentTypeProduction]; // 默认读取生产环境

    }
    
}

- (void)setupUrl {

    //跳转授信流程
    self.creditListUrl = jointUrl(_prefixUrl, @"/auth.html?skip=true#/RealName");
    
    //跳转借款流程
    self.borrowFlowUrl = jointUrl(_prefixUrl, @"/app.html#/Borrow/Index");
    
    //跳转还款流程
    self.returnFlowUrl = jointUrl(_prefixUrl, @"/app.html#/Repayment/Index");
    
    //跳转到实名认证页面
    self.certificationUrl = jointUrl(_prefixUrl, @"/auth.html#/RealName");
    
    //跳转到芝麻信用
    self.zhimaCreditUrl = jointUrl(_prefixUrl, @"/auth.html#/ZM");
    
    //跳转到运营商认证页面
    self.operateUrl = jointUrl(_prefixUrl, @"/auth.html#/Operator");
    
    //跳转借款记录
    self.borrowListUrl = jointUrl(_prefixUrl, @"/mine.html#/order");
    
    //跳转优惠券
    self.couponUrl = jointUrl(_prefixUrl, @"/mine.html#/coupon");
    
    //跳转有奖邀请
    self.inviteUrl = jointUrl(_prefixUrl, @"/mine.html#/invite/");
    
    //跳转优惠券规则
    self.useRuleUrl = jointUrl(_prefixUrl, @"/mine.html#/coupon/rule");
    
    //跳转个人资料
    self.userDataUrl = jointUrl(_prefixUrl, @"/mine.html#/profile");
    
    //==================协议
    //跳转会员服务协议
    self.serverProtocolUrl = jointUrl(_prefixUrl, @"/mine.html#/agreement/1");
    
    //米粒钱包自动签约授权书
    self.autoSignProtocolUrl = jointUrl(_prefixUrl, @"/mine.html#/agreement/2");
    
    //米粒用户信息查询授权书
    self.userSearchSignProtocolUrl = jointUrl(_prefixUrl, @"/mine.html#/agreement/3");
}

// 拼接URL
NSString *jointUrl(NSString *prefixUrl, NSString *path) {
    
    return [NSString stringWithFormat:@"%@%@", prefixUrl, path];
};
@end

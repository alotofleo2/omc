//
//  TJAccountDefines.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/17.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJAccountDefines.h"


NSString* const kTJAccount_sendRegistCode               = @"regist_code";                   //发送注册短信验证码API
NSString* const kTJAccount_sendForgetCode               = @"forget_code";                   //发送忘记密码短信验证码API
NSString* const kTJAccount_register                     = @"register";                      //注册API
NSString* const kTJAccount_login                        = @"login";                         //登录API
NSString* const kTJAccount_forget                       = @"retrieve";                      //忘记密码API
NSString* const kTJAccount_refreshToken                 = @"refresh_token";                 //刷新tokenAPI
NSString* const kTAccount_logout                        = @"user/logout";                   //退出登录API
NSString* const kTAccount_info                          = @"user/info";                     //用户信息API
NSString* const kTAccount_allReports                    = @"user/allReports";               //首页信息API
NSString* const kTAccount_checkReport                   = @"user/checkReport";              //检查报告状态
NSString* const kTAccount_address_upload                = @"address_book/upload";           //上传通讯录API
NSString* const kTAccount_messgae_page                  = @"message/page";                  //查询消息API
NSString* const kTAccount_calculateAlpha                = @"user/calculateAlpha";           //alpha计算点击API
NSString* const kTAccount_searchAlpha_report            = @"user/queryAlphaReport";         //alpha报告API

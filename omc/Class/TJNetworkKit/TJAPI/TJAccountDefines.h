//
//  TJAccountDefines.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/17.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef GCAPIDefines_h
#define GCAPIDefines_h

extern NSString* const kTJAccount_sendRegistCode;           //发送注册短信验证码API
extern NSString* const kTJAccount_sendForgetCode;           //发送忘记密码短信验证码API
extern NSString* const kTJAccount_register;                 //注册API
extern NSString* const kTJAccount_login;                    //登录API
extern NSString* const kTJAccount_forget;                   //忘记密码API
extern NSString* const kTJAccount_refreshToken;             //刷新tokenAPI
extern NSString* const kTAccount_logout;                    //退出登录API
extern NSString* const kTAccount_info;                      //获取用户信息API
extern NSString* const kTAccount_allReports;                //获取首页信息API
extern NSString* const kTAccount_checkReport;               //查询报告状态
extern NSString* const kTAccount_address_upload;            //上传通讯录API
extern NSString* const kTAccount_messgae_page;              //查询消息API
extern NSString* const kTAccount_calculateAlpha;            //alpha计算API
extern NSString* const kTAccount_searchAlpha_report;        //alpha报告API
#endif



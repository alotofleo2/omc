//
//  TJInputLimit.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/23.
//  Copyright © 2016年 taofang. All rights reserved.
//

#ifndef TJInputLimit_h
#define TJInputLimit_h

// ------------------------ 输入框限制长度 -----------------------

/*
 账号             字母、数字，不允许包含特殊字符；唯一不可重复；3-15位字符；
 邮箱             邮箱格式必须输入正确；
 登录密码          密显；6-16位；字母、数字或符号；
 确认密码          密显；必须与“登录密码”一致；
 手机号码          11位数字；
 验证码            对应短信验证码，正确输入；
 */

/**
 *  用户名最小输入长度
 */
#define INPUT_USERNAME_MIN_LENGTH   3

/**
 *  用户名最大输入长度
 */
#define INPUT_USERNAME_MAX_LENGTH   15



/**
 *  密码最小输入长度
 */
#define INPUT_PASSWORD_MIN_LENGTH   6


/**
 *  密码最大输入长度
 */
#define INPUT_PASSWORD_MAX_LENGTH   20


/**
 *  手机号码输入长度
 */
#define INPUT_PHONE_NUMBER_LENGTH   11


/**
 *  短信验证码输入长度
 */
#define INPUT_SMS_VERIFICATION_CODE_LENGTH 6


/**
 *  邮箱最小输入长度
 */
#define INPUT_EMAIL_MIN_LENGTH   5

/**
 *  邮箱最大输入长度
 */
#define INPUT_EMAIL_MAX_LENGTH   30


/**
 *  姓名最小输入长度
 */
#define INPUT_NAME_MIN_LENGTH   2


/**
 *  姓名最大输入长度
 */
#define INPUT_NAME_MAX_LENGTH   15


/**
 *  身份证最小输入长度
 */
#define INPUT_ID_CARD_MIN_LENGTH   15

/**
 *  身份证最大输入长度
 */
#define INPUT_ID_CARD_MAX_LENGTH   18


/**
 *  银行卡卡号最大长度
 */
#define INPUT_BANK_CARD_MAX_LENGTH 30


/**
 *  金额最大输入长度
 */
#define INPUT_AMOUNT_MIN_LENGTH   9


/**
 *  邀请人最大输入长度
 */
#define INPUT_INVITER_MAX_LENGTH 30

#endif /* TJInputLimit_h */

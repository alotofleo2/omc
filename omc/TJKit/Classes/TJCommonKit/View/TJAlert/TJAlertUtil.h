//
//  TJAlertUtil.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/9/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TJMessageNotificationType) {
    TJMessageNotificationTypeMessage = 0,
    TJMessageNotificationTypeWarning,
    TJMessageNotificationTypeError,
    TJMessageNotificationTypeSuccess
};

/**
 *  提示语弹窗工具
 */
@interface TJAlertUtil : NSObject


/**
 *  根据标题内容弹出提示语
 *
 *  @param title   标题
 *  @param message 内容
 *  @param type    弹出类型
 */
+ (void)showNotificationWithTitle:(NSString*)title
                          message:(NSString *)message
                             type:(TJMessageNotificationType)type;

/**
 *  根据标题内容弹出提示语
 *
 *  @param title   标题
 *  @param message 内容
 *  @param type    弹出类型
 *  @param viewController   自定义弹窗在哪个控制器
 */
+ (void)showNotificationWithTitle:(NSString*)title
                          message:(NSString *)message
                             type:(TJMessageNotificationType)type
                 inViewController:(UIViewController *)viewController;


@end

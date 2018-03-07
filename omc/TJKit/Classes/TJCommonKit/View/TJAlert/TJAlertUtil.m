//
//  TJAlertUtil.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/9/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJAlertUtil.h"
#import "FTMessage.h"
#import "UIView+Toast.h"

@implementation TJAlertUtil

+ (void)showNotificationWithTitle:(NSString*)title
                          message:(NSString *)message
                             type:(TJMessageNotificationType)type {
    
    [self showNotificationWithTitle:title message:message type:type inViewController:nil];
}


+ (void)showNotificationWithTitle:(NSString*)title
                          message:(NSString *)message
                             type:(TJMessageNotificationType)type
                 inViewController:(UIViewController *)viewController {

    
    [FTMessage showTopNotificationWithTitle:title subtitle:message type:(NSInteger)type duration:3 imageName:nil];
    
}
+ (void)toastWithString:(NSString *)string {
    
    UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    [view makeToast:string duration:2 position:CSToastPositionCenter];
}
@end

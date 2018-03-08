//
//  TJProogressHUD.m
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProgressHUD.h"

@implementation TJProgressHUD
+ (void)show {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:1.f];
    [SVProgressHUD show];
}

+ (void)showWithTitle:(NSString *)title {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14.f]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.f];
    [SVProgressHUD showImage:[UIImage new] status:title];
}
+ (void)showWithTitle:(NSString *)title interval:(NSTimeInterval)interval {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14.f]];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
    [SVProgressHUD showImage:[UIImage new] status:title];
}
+ (void)dismiss {
    
    [SVProgressHUD dismiss];
}@end
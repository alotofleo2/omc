//
//  TJProogressHUD.h
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface TJProgressHUD : NSObject
+ (void)show;

+ (void)showWithTitle:(NSString *)title;
+ (void)showWithTitle:(NSString *)title interval:(NSTimeInterval)interval;
+ (void)dismiss;
@end

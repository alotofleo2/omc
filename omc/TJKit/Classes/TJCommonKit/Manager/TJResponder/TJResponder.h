//
//  TJResponder.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/2.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJResponder : UIResponder

/**
 *  App中最底层的UIWindow，弹出框、加载框等模态对话框都会用到
 */
@property (nonatomic, strong) UIWindow *window;


/**
 *  项目使用的主界面控制器（navigationController、tabBarController或viewController）
 */
@property (nonatomic, strong) UIViewController *rootViewController;

/**
 *  获取应用程序实例，单例模式
 *
 *  @return 应用程序实例对象
 */
+ (TJResponder *)sharedResponder;

@end

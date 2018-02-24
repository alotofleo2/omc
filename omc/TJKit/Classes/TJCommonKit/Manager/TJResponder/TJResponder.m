//
//  TJResponder.m
//  RiceWallet
//
//  Created by 方焘 on 2017/8/2.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJResponder.h"

@implementation TJResponder


#pragma mark - Class
#pragma mark 获取应用程序实例，单例模式
+ (TJResponder *)sharedResponder {
    
    return (TJResponder *)[UIApplication sharedApplication].delegate;
}



#pragma mark - Getter
- (UIWindow *)window {
    
    if (!_window) {
        
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return _window;
}


#pragma mark - Setter
- (void)setRootViewController:(UIViewController *)rootViewController {
    
    _rootViewController = rootViewController;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}

@end

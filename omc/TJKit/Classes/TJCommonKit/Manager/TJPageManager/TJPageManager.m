//
//  TJPageManager.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJNavigationController.h"
#import "TJPageManager.h"
#import "TJCommonKit.h"
#import "TJToolKit.h"


@interface TJPageManager ()

/**
 *  将params的数据赋值给viewController
 *
 *  @param viewController 被赋值的viewController
 *  @param params         赋值给viewController的数据
 */
- (void)updateViewController:(UIViewController *)viewController params:(NSDictionary *)params;


/**
 *  根据名称创建viewController，并将params的数据赋值给viewController
 *
 *  @param name   viewController的名称
 *  @param params 赋值给viewController的数据
 *
 *  @return 创建的viewController
 */
- (UIViewController *)createViewControllerFromName:(NSString *)name params:(NSDictionary *)params;

@end

@implementation TJPageManager

- (void)setCurrentViewController:(UIViewController *)currentViewController {
    _currentViewController = currentViewController;
}

#pragma mark - Public Methods

#pragma mark 单例
+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (UINavigationController *)currentNavigationController {
    
    return self.currentViewController.navigationController;
}


#pragma mark 通过viewController的名称加载viewController
- (void)pushViewControllerWithName:(NSString *)viewControllerName {
    
    [self pushViewControllerWithName:viewControllerName params:nil];
}


#pragma mark 通过ViewController的名称加载viewController，并将params的数据赋值给viewController对应的属性
- (void)pushViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params {
    
    [self pushViewControllerWithName:viewControllerName params:params animated:YES];
}

#pragma mark 通过ViewController的名称加载viewController，并将params的数据赋值给viewController对应的属性，以及是否开启push动画
- (void)pushViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params animated:(BOOL)animated {
    
    // 防止viewController重复push
    if (self.currentViewController.navigationController) {
        
        NSString * lastViewControllerName = NSStringFromClass([[self.currentViewController.navigationController.viewControllers lastObject] class]);
        
        if ([lastViewControllerName isEqualToString:viewControllerName] &&![lastViewControllerName containsString:@"WebView"]) {
            
            return;
        }
    }
    if (self.currentViewController.navigationController) {
    }
    UIViewController * viewController = [self createViewControllerFromName:viewControllerName params:params];
    
    if (!viewController) {
        return;
    }
    
    if (self.currentViewController.navigationController) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        [self.currentViewController.navigationController pushViewController:viewController animated:animated];
    }
    
}


- (void)replaceViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params animated:(BOOL)animated {
    
    UIViewController * viewController = [self createViewControllerFromName:viewControllerName params:params];
    
    if (!viewController) {
        return;
    }
    
    
    if (self.currentViewController.navigationController) {
        
        //Get all view controllers in navigation controller currently
        NSMutableArray * controllers = [NSMutableArray arrayWithArray:self.currentViewController.navigationController.viewControllers] ;
        
        //Remove the last view controller
        [controllers removeLastObject];
        [controllers addObject:viewController];
        
        //set the new set of view controllers
        viewController.hidesBottomBarWhenPushed = YES;
        [self.currentViewController.navigationController setViewControllers:controllers animated:YES];
    }
    
}

- (void)replaceViewControllerWithName:(NSString *)replacedViewControllerName pushViewControllerName:(NSString *)pushViewControllerName  params:(NSDictionary *)params animated:(BOOL)animated {
    
    UIViewController * pushViewController = [self createViewControllerFromName:pushViewControllerName params:params];
    
    if (!pushViewController) {
        return;
    }
    
    
    
    if (self.currentViewController.navigationController) {
        
        //set the new set of view controllers
        pushViewController.hidesBottomBarWhenPushed = YES;
        
        NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
        
        NSMutableArray *newViewControllers = [NSMutableArray array];
        
        for (id viewController in viewControllers) {
            
            NSString *viewControllerName = NSStringFromClass([viewController class]);
            
            if ([viewControllerName isEqualToString:replacedViewControllerName]) {
                
                break;
                
            } else {
                
                [newViewControllers addObject:viewController];
            }
        }
        
        [newViewControllers addObject:pushViewController];
        [self.currentViewController.navigationController setViewControllers:newViewControllers animated:animated];
    }
}
#pragma mark pop当前viewController，并将params的数据赋值给前一个viewController
- (UIViewController *)popViewControllerWithParams:(NSDictionary *)params {
    
    NSArray * viewControllers = self.currentViewController.navigationController.viewControllers;
    
    if ([viewControllers count] < 2) {
        
        return nil;
    }
    
    UIViewController * viewController = [viewControllers objectAtIndex:[viewControllers count] - 2];
    
    if (!viewController) {
        
        return nil;
    }
    
    [self updateViewController:viewController params:params];
    return [self.currentViewController.navigationController popViewControllerAnimated:YES];
}


#pragma mark pop到指定name的viewController上，并将params的数据赋值给指定name的viewController
- (NSArray *)popToViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params {
    
    if ([StringUtil isEmpty:viewControllerName]) {
        
        return nil;
    }
    
    Class viewControllerClass = NSClassFromString(viewControllerName);
    
    if (viewControllerClass == nil) {
        return nil;
    }
    
    __block __weak UIViewController * viewController = nil;
    
    NSArray * viewControllers = self.currentViewController.navigationController.viewControllers;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:viewControllerClass]) {
            
            viewController = obj;
            *stop = YES;
        }
    }];
    
    NSArray * resultArray = nil;
    
    if (viewController) {
        
        [self updateViewController:viewController params:params];
        resultArray = [self.currentViewController.navigationController popToViewController:viewController
                                                                                  animated:YES];
    }
    
    return resultArray;
}



#pragma mark pop到rootViewController，并将params的数据赋值给rootViewController
- (NSArray *)popToRootViewControllerWithParams:(NSDictionary *)params {
    
    return [self popToRootViewControllerWithParams:params animated:YES];
}


#pragma markpop到rootViewController，并将params的数据赋值给rootViewController，以及是否开启push动画
- (NSArray *)popToRootViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated {
    
    NSArray * viewControllers = self.currentViewController.navigationController.viewControllers;
    UIViewController * viewController = [viewControllers firstObject];
    
    NSArray * resultArray = nil;
    
    if (viewController) {
        
        [self updateViewController:viewController params:params];
        resultArray = [self.currentViewController.navigationController popToViewController:viewController animated:animated];
    }
    
    return resultArray;
}


- (void)presentViewControllerWithName:(NSString *)viewControllerName {
    
    [self presentViewControllerWithName:viewControllerName params:nil];
}


- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params {
    
    [self presentViewControllerWithName:viewControllerName params:params inNavigationController:NO];
}


- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params inNavigationController:(BOOL)inNavigationController {
    
    [self presentViewControllerWithName:viewControllerName
                                 params:params
                 inNavigationController:inNavigationController
                               animated:YES];
    
}


- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params inNavigationController:(BOOL)inNavigationController animated:(BOOL)animated {
    
    UIViewController * viewController = [self createViewControllerFromName:viewControllerName params:params];
    
    if (!viewController) {
        return;
    }
    
    if (inNavigationController && self.currentViewController) {
        
        TJNavigationController * navigationController = [[TJNavigationController alloc] initWithRootViewController:viewController];
        
        if (TARGET_IS_IOS7_OR_LATER) {
            
            [self.currentViewController.view.window.rootViewController presentViewController:navigationController animated:animated completion:nil];
            
        } else {
            
            [self.currentViewController presentViewController:navigationController animated:animated completion:nil];
        }
        
        
    } else {
        
        [self.currentViewController presentViewController:viewController animated:animated completion:nil];
    }
    
}


#pragma mark - Private Methods
#pragma mark 将params的数据赋值给viewController
- (void)updateViewController:(UIViewController *)viewController params:(NSDictionary *)params {
    
    NSArray * keys = [params allKeys];
    
    if ([keys count] == 0) {
        
        return;
    }
    
    for (NSString * key in keys) {
        
        SEL selector = NSSelectorFromString(key);
        
        if (selector == 0) {
            
            continue;
        }
        
        if ([viewController respondsToSelector:selector]) {
            
            id value = [params objectForKey:key];
            [viewController setValue:value forKey:key];
        }
    }
}


#pragma mark 根据名称创建viewController，并将params的数据赋值给viewController
- (UIViewController *)createViewControllerFromName:(NSString *)name params:(NSDictionary *)params {
    
    if (params && ![params isKindOfClass:[NSDictionary class]]) {
        
        return nil;
    }
    
    Class class = NSClassFromString(name);
    
    if (!class || ![class isSubclassOfClass:[UIViewController class]]) {
        
        return nil;
    }
    
    UIViewController * viewController = nil;
    
    BOOL nibFileExist = ([[NSBundle mainBundle] pathForResource:name ofType:@"nib"] != nil);
    
    if (nibFileExist) {
        
        viewController = [[class alloc] initWithNibName:name bundle:nil];
        
    } else {
        
        viewController = [[class alloc] init];
    }
    
    if (params) {
        
        [self updateViewController:viewController params:params];
    }
    
    return viewController;
}
+ (BOOL)PWTabbarIsHidden{
    
    UITabBarController *tabBarController = [TJPageManager shareTabbarController];
    return tabBarController.tabBar.hidden;
}

+ (void)PWSetTabbarIsHidden:(BOOL)isHidden{
    
    [TJGCDManager asyncMainThreadBlock:^{
        UITabBarController *tabBarController = [TJPageManager shareTabbarController];
        tabBarController.tabBar.hidden=isHidden;
    }];
}

+ (UITabBarController*)shareTabbarController{
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].delegate.window.rootViewController;
    return tabBarController;
}
@end

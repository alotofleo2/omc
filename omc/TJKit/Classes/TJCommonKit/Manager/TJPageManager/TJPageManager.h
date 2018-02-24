//
//  TJPageManager.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TJPageManager : NSObject

/**
 *  当前被加载的viewController
 */
@property (nonatomic, weak) UIViewController * currentViewController;

/**
 *  当前正在使用的navigationController
 */
@property (nonatomic, weak) UINavigationController * currentNavigationController;


/**
 *  用于判断是否需要加载nib文件
 */
@property (nonatomic) BOOL needNibFile;


/**
 *  单例
 *
 *  @return THPageManager对象
 */
+ (instancetype)sharedInstance;


/**
 *  通过viewController的名称加载viewController
 *
 *  @param viewControllerName viewController的名称
 */
- (void)pushViewControllerWithName:(NSString *)viewControllerName;


/**
 *  通过viewController的名称加载viewController，并将params的数据赋值给viewController对应的属性
 *
 *  @param viewControllerName viewController的名称
 *  @param params             赋值给viewController的数据
 */
- (void)pushViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params;


/**
 *  通过viewController的名称加载viewController，并将params的数据赋值给viewController对应的属性，以及是否开启push动画
 *
 *  @param viewControllerName viewController的名称
 *  @param params             赋值给viewController的数据
 *  @param animated           是否开启push动画
 */
- (void)pushViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params animated:(BOOL)animated;


- (void)replaceViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params animated:(BOOL)animated;


- (void)replaceViewControllerWithName:(NSString *)replacedViewControllerName pushViewControllerName:(NSString *)pushViewControllerName  params:(NSDictionary *)params animated:(BOOL)animated;
/**
 *  pop当前viewController，并将params的数据赋值给前一个viewController
 *
 *  @param params 赋值给前一个viewController的数据
 *
 *  @return 被pop的viewController
 */
- (UIViewController *)popViewControllerWithParams:(NSDictionary *)params;

/**
 *  pop到指定name的viewController上，并将params的数据赋值给指定name的viewController
 *
 *  @param viewControllerName pop到指定viewController的name
 *  @param params             赋值给指定name的viewController数据
 *
 *  @return 被pop的viewController组成的数组
 */
- (NSArray *)popToViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params;

/**
 *  pop到rootViewController，并将params的数据赋值给rootViewController
 *
 *  @param params 赋值给rootViewController数据
 *
 *  @return 被pop的viewController组成的数组
 */
- (NSArray *)popToRootViewControllerWithParams:(NSDictionary *)params;


/**
 *  pop到rootViewController，并将params的数据赋值给rootViewController，以及是否开启push动画
 *
 *  @param params   赋值给rootViewController数据
 *  @param animated 是否开启push动画
 *
 *  @return 被pop的viewController组成的数组
 */
- (NSArray *)popToRootViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated;

//- (UIViewController *)currentShowViewController;

- (void)presentViewControllerWithName:(NSString *)viewControllerName;

- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params;

- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params inNavigationController:(BOOL)inNavigationController;

- (void)presentViewControllerWithName:(NSString *)viewControllerName params:(NSDictionary *)params inNavigationController:(BOOL)inNavigationController animated:(BOOL)animated;


/**
 *  @return 当前tabbar是否隐藏
 */
+ (BOOL)PWTabbarIsHidden;

/**
 *  设置是否隐藏tabbar
 */
+ (void)PWSetTabbarIsHidden:(BOOL)isHidden;

/**
 *  获取当前的tabbarController
 */
+ (UITabBarController*)shareTabbarController;
@end

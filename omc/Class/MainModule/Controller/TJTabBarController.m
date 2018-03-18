//
//  TJTabBarController.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJTabBarController.h"
#import "TJCurtainEditManager.h"
#import "TJHomeViewController.h"
#import "TJCategoryViewContoller.h"
#import "TJUploadListViewController.h"
#import "TJVideoListViewController.h"
#import "TJTabBar.h"

@interface TJTabBarController ()

@end

@implementation TJTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    TJTabBar *tabbar = [[TJTabBar alloc] init];
    tabbar.myDelegate = (id)self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    
    TJHomeViewController *HomeVC = [[TJHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];

    TJCategoryViewContoller *categoryVC = [[TJCategoryViewContoller alloc] init];
    [self setUpOneChildVcWithVc:categoryVC Image:@"class_normal" selectedImage:@"class_highlight" title:@"分类"];

    TJVideoListViewController *videoVC = [[TJVideoListViewController alloc] init];
    [self setUpOneChildVcWithVc:videoVC Image:@"video_normal" selectedImage:@"video_highlight" title:@"安装视频"];

    TJUploadListViewController *uploadListVC = [[TJUploadListViewController alloc] init];
    [self setUpOneChildVcWithVc:uploadListVC Image:@"buyerShow_normal" selectedImage:@"buyerShow_highlight" title:@"实景案例"];
    
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d)]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d)]];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    TJNavigationController *nav = [[TJNavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0x999999)} forState:UIControlStateNormal];
    
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - TJTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(TJTabBar *)tabBar {
    [[TJCurtainEditManager sharedInstance]startEdit];
}

@end

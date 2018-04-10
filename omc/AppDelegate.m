//
//  AppDelegate.m
//  omc
//
//  Created by 方焘 on 2018/2/5.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "AppDelegate.h"
#import "TJCollectMessageManager.h"
#import "TJTabBarController.h"
#import "AFNetworkReachabilityManager.h"
#import "TJShareManager.h"
#import <UMPush/UMessage.h>

//微信
#define weiChatShareKey       @"wx5915322399bdd4f5"
#define weiChatShareSecret    @"90e7479fda7ab51814118c2deb1fbb18"

//qq and qq空间
#define ShareQQAppId           @"1106330413"
#define ShareQQAppKey          @"zYS75Eak7lTeNfbv"

//微博
#define weiboAppKey @"1851986776"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 解档 获取用户的所有信息
    [[TJUserModel sharedInstance] unarchiver];
    [TJTokenManager defaultManager];
    
    TJTabBarController *tabBarVc = [[TJTabBarController alloc] init];
    
    self.window.rootViewController = tabBarVc;
    
    [self.window makeKeyAndVisible];
    
    // 加载引导图
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:RW_VERSION];
    
    if (version == nil) {
        //统计第一次安装数据
        [[TJCollectMessageManager sharedInstance] uploadFirstDownloadApp];
        
         [[NSUserDefaults standardUserDefaults] setObject:[TJUserDefaultsManager currentVersion] forKey:RW_VERSION];
        
    }
    
    //友盟推送
    [self setupUPushWithLaunchOptions: launchOptions];
    
    //配置分享
    [[TJShareManager defaultManager] registWithWeiXinAppID:weiChatShareKey qqAppID:ShareQQAppId WeiboAppID:weiboAppKey];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 友盟推送
- (void)setupUPushWithLaunchOptions:(NSDictionary *)launchOptions {
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if (@available(iOS 10.0, *)) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
        
    }
    NSLog(@"%@", userInfo);
    NSInteger applicationState = [UIApplication sharedApplication].applicationState;
    
    switch (applicationState) {
            
        case UIApplicationStateActive:  { // 应用在前台时再调用
            
//            [[TRCLaunchManager sharedInstance] alertMessageViewUserInfo:userInfo];
            break;
        }
            
        case UIApplicationStateInactive: { // 用户通过点击通知中心的消息将客户端从关闭状态调至前台
            
            // 发送推送接受信息的LOG
            [UMessage didReceiveRemoteNotification:userInfo];
            
            
            
            break;
            
        } case UIApplicationStateBackground: {
            
            
            
        }
            break;
            
        default:
            break;
            
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10_0) {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"%@", userInfo);
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10_0){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受
            //必须加这句代码
            NSLog(@"%@", userInfo);
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于后台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
}
@end

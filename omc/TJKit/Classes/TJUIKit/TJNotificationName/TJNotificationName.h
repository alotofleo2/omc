//
//  TJNotificationName.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#ifndef TJNotificationName_h
#define TJNotificationName_h
/**
 *  更新列表数据源的通知名称
 */
#define UpdateInvestmentDatasource @"UpdateInvestmentDatasource"


/**
 *  请求超时
 */
#define TimeOutOfRequest @"TimeOutOfRequest"


/**
 *  登录超时的通知名称
 */
#define TimeOutOfSession @"TimeOutOfSession"


/**
 *  完成引导
 */
#define FIRSTRUN_FINISHGUIDE @"FirstRun_FinshGuide"

/**
 *  启动图加载完成时的通知
 *
 *  @return
 */
#define THLauchViewFinishedNotification @"THLauchViewFinishedNotification"


/**
 *  退出登录
 */
#define LOGOUT_AND_CLEAN_GESTURE_PASSWORD @"LOGOUT_AND_CLEAN_GESTURE_PASSWORD"


/**
 *  隐藏顶部Logo
 */
#define HIDE_TOP_LOGO @"HIDE_TOP_LOGO"


/**
 *  手势解锁成功移除解锁界面
 */
#define GESTURE_FINISHED @"gestureFinishedNeedRemoved"

#define APPLICATION_DID_BECOME_ACTIVE @"applicationDidBecomeActive"

/**
 *
 *   更新去投资页面的segment 切换的badge
 *  @return
 */
#define UPDATESEGMENGTBADGEVALUENOTIFICATION  @"updatesegmentnotification"

#define TJMainViewControllerSignNotification @"TJMainViewControllerSignNotification"

/**
 *  popToRootViewController
 */
#define TJPopToRootViewControllerNotificationName @"TJPopToRootViewControllerNotificationName"

/**
 *  显示分享界面
 */
#define TJShowShareViewNotificationName @"TJShowShareViewNotificationName"


/**
 *  显示服务器正在维护中的界面
 */
#define TJServerIsMaintainedNotificationName @"TJServerIsMaintainedNotificationName"


/**
 *  更换服务器的环境配置
 */
#define TJChangeServerEnvironmentTypeNotificationName @"TJChangeServerEnvironmentTypeNotificationName"



/**
    登出
 */
#define TJLogoutNotificationName @"TJLogoutNotificationName"

/**
 登录
 */
#define TJLoginNotificationName @"TJLoginNotificationName"
/**
 刷新token
 */
#define TJRefreshTokenNotificationName @"TJRefreshTokenNotificationName"

/**
 认证项状态改变通知
 
 info key :recognizedNum
 */
#define RWRecognitionStatusChangeNotificationName @"RWRecognitionStatusChangeNotificationName"
#endif /* TJNotificationName_h */

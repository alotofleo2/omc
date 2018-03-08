//
//  TJUserModel.h
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"

/**
 *  登出后刷新资产信息
 */
#define REFRESH_MINE_VIEWCONTROLLER_LOGINVIEWNOTIFICATION  @"RefreshMineViewControllerLoginView"

@interface TJUserModel : TJBaseSharedInstance
/**
 *  用昵称
 */
@property (nonatomic, strong) NSString * username;

/**
 *  性别
 */
@property (nonatomic, strong) NSString * sex;

/**
 *  手机号
 */
@property (nonatomic, strong) NSString * phone;

/**
 *  姓名
 */
@property (nonatomic, strong) NSString * name;

/**
 *  地址
 */
@property (nonatomic, strong) NSString * address;


#pragma mark 此方法不允许任何人在外面调用，只有在登录成功才需要调用，管理员权限
- (void)updateUserInfo:(NSDictionary *)info;


/**
 *  注销账户
 */
- (void)logout;


/**
 *  解档用户信息数据,程序启动时需要调用
 */
-(void)unarchiver;
@end

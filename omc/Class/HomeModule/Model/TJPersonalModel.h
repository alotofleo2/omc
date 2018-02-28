//
//  TJPersonalModel.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJPersonalModel : TJBaseModel
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  图片名字
 */
@property (nonatomic, copy) NSString *iconImageName;

/**
 *  目标控制(逻辑)
 */
@property (nonatomic, copy) NSString *target;

/**
 *  是否需要登录状态
 */
@property (nonatomic, assign) BOOL isNeedLogin;
@end

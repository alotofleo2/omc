//
//  TJCurtainEditTopBar.h
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"
#import "TJCurtainEditTopContentAlerView.h"

@interface TJCurtainEditTopBar : TJBaseView
//关闭按钮点击事件
@property (nonatomic, copy) void(^closeActionHandle)(void);

//内容选择点击事件
@property (nonatomic, copy) void(^contentActionHandle)(TJCurtainContentType);

//设置按钮点击事件
@property (nonatomic, copy) void(^settingActionHandle)(void);

//确认按钮点击事件
@property (nonatomic, copy) void(^sureActionHandle)(void);
@end

//
//  TJCurtainEditTopBar.h
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"
#import "TJCurtainEditTopContentAlerView.h"
#import "TJCurtainEditSettingAlerView.h"

@interface TJCurtainEditTopBar : TJBaseView
//关闭按钮点击事件
@property (nonatomic, copy) void(^closeActionHandle)(void);

//内容选择点击事件
@property (nonatomic, copy) void(^contentActionHandle)(TJCurtainContentType);

//单幅多福点击事件
@property (nonatomic, copy) void(^ContentNumberButtonPressedHandle)(TJCurtainContentNumberType type);

//图片背景更改的回调(对比度,亮度等)
@property (nonatomic, copy) void(^BackgroundChangeHandle)(TJCurtainBackgroundChangeType type, CGFloat value);

//确认按钮点击事件
@property (nonatomic, copy) void(^sureActionHandle)(void);
@end

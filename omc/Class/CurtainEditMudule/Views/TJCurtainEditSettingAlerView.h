//
//  TJCurtainEditSettingAlerView.h
//  omc
//
//  Created by 方焘 on 2018/3/11.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"
typedef NS_ENUM(NSInteger, TJCurtainContentNumberType) {
    TJCurtainContentNumberTypeSingle = 1,  //单幅
    TJCurtainContentNumberTypeMulti  //多幅
};

typedef NS_ENUM(NSInteger, TJCurtainBackgroundChangeType) {
    TJCurtainBackgroundChangeTypeHilight = 1,  //亮度
    TJCurtainBackgroundChangeTypeContrast,  //对比度
    TJCurtainBackgroundChangeTypeDark       //光暗
};
@interface TJCurtainEditSettingAlerView : TJBaseView
@property (nonatomic, copy) void(^ContentNumberButtonPressedHandle)(TJCurtainContentNumberType type);

@property (nonatomic, copy) void(^BackgroundChangeHandle)(TJCurtainBackgroundChangeType type, CGFloat value);
@end

//
//  TJCurtainEditTopContentAlerView.h
//  omc
//
//  Created by 方焘 on 2018/3/11.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"

typedef NS_ENUM(NSInteger, TJCurtainContentType) {
    TJCurtainContentTypeCurtain = 1,  //窗帘
    TJCurtainContentTypeCurtainHead  //窗头
};
@interface TJCurtainEditTopContentAlerView : TJBaseView

@property (nonatomic, copy) void(^contentButtonPressedHandle)(TJCurtainContentType type);

- (instancetype)initWithType:(TJCurtainContentType)type;
@end

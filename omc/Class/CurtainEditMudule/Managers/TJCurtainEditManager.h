//
//  TJCurtainEditManager.h
//  omc
//
//  Created by 方焘 on 2018/2/28.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"
#define KEditViewContentHeight DEVICE_SCREEN_HEIGHT - TJSystem2Xphone6Height(348)

@interface TJCurtainEditManager : TJBaseSharedInstance
- (void)startEdit;
@end

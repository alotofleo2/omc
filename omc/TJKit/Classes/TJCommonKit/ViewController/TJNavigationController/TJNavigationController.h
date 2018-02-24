//
//  TJNavigationController.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJNavigationController : UINavigationController <UIGestureRecognizerDelegate>

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL dragBackEnable;

@end

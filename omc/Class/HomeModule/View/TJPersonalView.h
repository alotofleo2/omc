//
//  TJPersonalView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPersonalView : UIVisualEffectView

@property (nonatomic, strong, readonly) UIView *maskView;

/**
 *  开始个人页面的左边弹入效果
 *
 */
+ (void)showPersonnalView;

- (void)endShowPersonnalView;
@end

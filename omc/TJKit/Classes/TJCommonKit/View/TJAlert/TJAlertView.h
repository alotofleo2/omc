//
//  TJAlertView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/3/24.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TJAlertView : UIView
@property (nonatomic, strong)UIView *contentSttingView;

//特殊回调 会将弹窗的内容部分回传做特殊要求
@property (nonatomic, strong)void(^specialCloneHandle)(UIView *aletView);

+ (instancetype)actionWithContentViewSettingHandle:(void (^)(UIView *contentView))SettingHandle closeHandle:(void(^)(void))closeHandle;

- (void)show;

- (void)close;
@end

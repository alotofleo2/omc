//
//  TJCurtainEditContentView.h
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"
#import "TJCurtainContentImagemodel.h"
#import "TJCurtainEditSettingAlerView.h"

@interface TJCurtainEditContentView : TJBaseView


@property (nonatomic, strong) UIImage *backgroundImage;

- (void)addImageWithModel:(TJCurtainContentImagemodel* )model;

- (void)deleteImage;

- (UIImage *)getCapture;

- (void)backgroundChangeWithType:(TJCurtainBackgroundChangeType)type value:(CGFloat)value;

- (void)contentNumberButtonPressedWithType:(TJCurtainContentNumberType)type;
@end

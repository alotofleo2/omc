//
//  TJCurtainEditViewController.h
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseViewController.h"

@interface TJCurtainEditViewController : TJBaseViewController

/**
 背景图片
 */
@property (nonatomic, strong) UIImage *backGoundImage;

/**
 窗帘数组
 */
@property (nonatomic, strong) NSArray *curtainImages;

/**
 窗头数组
 */
@property (nonatomic, strong) NSArray *curtainHeadImages;
@end

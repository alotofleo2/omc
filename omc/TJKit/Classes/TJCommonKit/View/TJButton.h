//
//  TJButton.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJButton : UIButton

/**
 *  normal状态下背景色
 */
@property(nonatomic, strong) UIColor * normalColor;


/**
 *  highlight状态下背景色
 */
@property(nonatomic, strong) UIColor * highlightColor;


/**
 *  disabled状态下背景色
 */
@property (nonatomic, strong) UIColor * disabledColor;


/**
 *  selected状态下背景色
 */
@property (nonatomic, strong) UIColor * selectedColor;


/**
 *  圆角半径
 */
@property(nonatomic, assign) CGFloat cornerRadius;


/**
 *  显示标题的下划线
 */
@property (nonatomic, assign) BOOL underlineEnable;

@end

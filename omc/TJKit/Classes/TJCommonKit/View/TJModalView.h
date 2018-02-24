//
//  TJModalView.h
//  RiceWallet
//
//  Created by 方焘 on 2017/9/18.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TJModalView;

/**
 *  淡入淡出效果持续时间
 */
#define kTRCFadeInAnimationDuration 0.3
#define kTRCTransformPart1AnimationDuration 0.2
#define kTRCTransformPart2AnimationDuration 0.1

/**
 *  TRCModalGradientView界面被点击时发送通知的通知名称
 */
#define TJModalGradientViewTapped @"TJModalGradientViewTapped"


/**
 *  默认AlertView的Frame
 */
#define kTJDefaultAlertViewFrame CGRectMake(20.f, 0.f, 300.f, 266.f)

/**
 *  模态界面的显示风格
 */
typedef enum : NSUInteger {
    
    /**
     *  AlertView风格
     */
    TJModalStyleAlert,
    
    /**
     *  ActionSheet风格
     */
    TJModalStyleActionSheet,
    
    /**
     *  从右侧滑入
     */
    TJModalStylePushRight,
    
    
} TJModalStyle;

/**
 *  模态窗口的背景风格
 */
typedef enum : NSUInteger {
    
    /**
     *  渐变的背景
     */
    TJModalBackgroundDisplayStyleGradient,
    
    /**
     *  平滑的背景
     */
    TJModalBackgroundDisplayStyleSolid,
    
} TJModalBackgroundDisplayStyle;

/**
 *  模态窗口中contentView的基础界面
 */
@interface TJBaseModalContentView : UIView


@property (nonatomic, weak) TJModalView * modalView;

/**
 *  隐藏模态窗口
 */
- (void)hide;

@end

/**
 *  模态窗口的容器界面
 */
@interface TJModalContainerView : UIView

@property (nonatomic, strong) CALayer * styleLayer;

@end


// FIMXE: TJModalView存在问题，调用showWithContentView系列的类方法后会生成2个TJModalView实例
@interface TJModalView : UIView
/**
 *  用于添加TRCModalView对象的父界面
 */
@property (nonatomic, weak) UIView * parentView;


/**
 *  模态窗口容器界面
 */
@property (nonatomic, strong) TJModalContainerView *containerView;


/**
 *  显示内容界面
 */
@property (nonatomic, weak) UIView *contentView;


/**
 *  点击模态窗口以外的界时移除模态窗口，默认开启该功能
 */
@property (nonatomic) BOOL tapOutsideToDismiss; // UI_APPEARANCE_SELECTOR;


/**
 *  移除模态窗口的动画效果，默认开启
 */
@property (nonatomic) BOOL animateWhenDismissed; // UI_APPEARANCE_SELECTOR;


/**
 *  模态窗口的右上角显示关闭按钮，默认开启
 */
@property (nonatomic) BOOL closeButtonEnable; // UI_APPEARANCE_SELECTOR;


/**
 *  模态界面的显示风格
 */
@property (nonatomic, assign) TJModalStyle modalStyle;


/**
 *  背景的显示风格，默认使用渐变的背景风格，该风格在Retina iPad上显示效果更佳
 */
@property (nonatomic, assign) TJModalBackgroundDisplayStyle backgroundDisplayStyle; // UI_APPEARANCE_SELECTOR;


// FIXME: 添加Block功能

/**
 *  显示模态窗口的类方法，需要多个模态窗口一起弹出时使用，可设置模态界面的显示风格，显示动画、关闭按钮的显示以及点击模态窗口以外的界时移除模态窗口
 *
 *   contentView         模态窗口内容界面
 *   modalStyle          模态窗口的显示类型
 *   animated            弹出动画
 *   showCloseButton     显示关闭按钮
 *   tapOutsideToDismiss 点击模态窗口以外的界时移除模态窗口
 *
 *  @return 实例化对象
 */
- (instancetype)initWithParentView:(UIView *)parentView;


/**
 *  设置在模态窗口上显示的内容界面，并以动画的形式显示
 *
 *  @param contentView 内容界面
 */
- (void)showContentView:(UIView *)contentView;


/**
 *  设置在模态窗口上显示的内容界面，并设置是否以动画的形式显示
 *
 *  @param contentView 内容界面
 *  @param animated    动画功能
 */
- (void)showContentView:(UIView *)contentView animated:(BOOL)animated;


/**
 *  以动画的形式隐藏模态窗口
 */
- (void)hide;


/**
 *  隐藏模态窗口，并设置是否以动画的形式隐藏
 *
 *  @param animated 动画功能
 */
- (void)hideAnimated:(BOOL)animated;
@end

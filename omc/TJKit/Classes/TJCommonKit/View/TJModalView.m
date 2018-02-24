//
//  TJModalView.m
//  RiceWallet
//
//  Created by 方焘 on 2017/9/18.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJModalView.h"

@implementation TJBaseModalContentView


- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        CGSize size = CGSizeMake([TJAdaptiveManager deviceScreenWidth], 300.f);
        CGRect frame = CGRectZero;
        frame.size = size;
        self.frame = frame;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


/**
 *  隐藏模态窗口
 */
- (void)hide {
    
}

@end

#pragma mark TJModalGradientView 模态窗口的背景界面
@protocol TJModalGradientViewDelegate <NSObject>

/**
 *  背景界面被点击时回调
 */
- (void)gradientViewTapped;

@end

@interface TRCModalGradientView : UIView

/**
 *  回调对象
 */
@property (nonatomic, weak) id<TJModalGradientViewDelegate> delegate;


/**
 *  背景的显示风格，默认使用渐变的背景风格，该风格在Retina iPad上显示效果更佳
 */
@property (nonatomic, assign) TJModalBackgroundDisplayStyle backgroundDisplayStyle;


@end

@implementation TRCModalGradientView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
    }
    
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(gradientViewTapped)]) {
        
        [self.delegate gradientViewTapped];
    }
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (self.backgroundDisplayStyle) {
            
        case TJModalBackgroundDisplayStyleGradient: {
            
            // 实现渐变的背景
            CGContextSaveGState(context);
            size_t gradLocationsNum = 2;
            CGFloat gradLocations[2] = {0.0f, 1.0f};
            CGFloat gradColors[8] = {0, 0, 0, 0.3, 0, 0, 0, 0.8};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            (void)(CGColorSpaceRelease(colorSpace)), colorSpace = NULL;
            CGPoint gradCenter= CGPointMake(round(CGRectGetMidX(self.bounds)), round(CGRectGetMidY(self.bounds)));
            CGFloat gradRadius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            CGContextDrawRadialGradient(context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
            (void)(CGGradientRelease(gradient)), gradient = NULL;

            CGContextRestoreGState(context);
            
        }
            break;
            
        case TJModalBackgroundDisplayStyleSolid: {
            
            // 实现平滑的背景
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
        }
            break;
            
        default:
            break;
    }
}

@end

#pragma mark TRCModalContainerView 模态窗口的容器界面
@implementation TJModalContainerView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
    }
    
    return self;
}


@end

#pragma mark -
#pragma mark TRCModalView
@interface TJModalView () <TJModalGradientViewDelegate>

/**
 *  模态窗口背景
 */
@property (nonatomic, strong) TRCModalGradientView * styleView;


/**
 *  关闭按钮
 */
@property (nonatomic, strong) UIButton *closeButton;


/**
 *  点击关闭按钮
 *
 *  @param sender 发送者
 */
- (void)closeAction:(id)sender;


/**
 *  接收到KGModalGradientView界面被点击的通知时调用
 *
 *  @param sender 发送者
 */
- (void)tapCloseAction:(id)sender;


/**
 *  清除界面
 */
- (void)cleanup;


@end

@implementation TJModalView
#pragma mark - Lifecycle
- (void)dealloc {
    
    NSLog(@"TJModalView Dealloc");
}


- (instancetype)initWithParentView:(UIView *)parentView {
    
    self = [super init];
    
    if(self) {
        
        _parentView = parentView;
        CGRect viewBounds = _parentView.bounds;
        
        [self setFrame:viewBounds];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.backgroundDisplayStyle = TJModalBackgroundDisplayStyleSolid;
        self.tapOutsideToDismiss = YES;
        self.animateWhenDismissed = YES;
        self.closeButtonEnable = YES;
    }
    
    return self;
}



#pragma mark - Public
#pragma mark 用于添加TRCModalView对象的父界面
- (UIView *)parentView {
    
    if (_parentView) {
        
        return _parentView;
    }
    
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}


#pragma mark 设置模态窗口的右上角关闭按钮的显示
- (void)setCloseButtonEnable:(BOOL)closeButtonEnable {
    
    if(_closeButtonEnable != closeButtonEnable) {
        
        _closeButtonEnable = closeButtonEnable;
        [self.closeButton setHidden:!_closeButtonEnable];
    }
}


#pragma mark 设置在模态窗口上显示的内容界面，并以动画的形式显示
- (void)showContentView:(UIView *)contentView {
    
    [self showContentView:contentView animated:YES];
}


#pragma mark 设置在模态窗口上显示的内容界面，并设置是否以动画的形式显示
- (void)showContentView:(UIView *)contentView animated:(BOOL)animated {
    
    CGRect viewBounds = self.bounds;
    [self.parentView addSubview:self];
    
    self.contentView = contentView;
    
    if ([contentView respondsToSelector:@selector(setModalView:)]) {
        
        [(id)contentView setModalView:self];
    }
    
    
    self.styleView = [[TRCModalGradientView alloc] initWithFrame:self.bounds];
    self.styleView.opaque = NO;
    self.styleView.backgroundDisplayStyle = self.backgroundDisplayStyle;
    [self.styleView setDelegate:self];
    [self addSubview:self.styleView];
    
    
    self.containerView = [[TJModalContainerView alloc] init];
    [self addSubview:self.containerView];
    
    
    CGFloat padding = 0.f;
    
    switch (self.modalStyle) {
            
        case TJModalStyleAlert: {
            
            // Alert风格显示边框和圆角
            padding = 15.f;
            CGRect containerViewRect = CGRectInset(contentView.bounds, -padding, -padding);
            containerViewRect.origin.x = containerViewRect.origin.y = 0;
            containerViewRect.origin.x = round(CGRectGetMidX(viewBounds) - CGRectGetMidX(containerViewRect));
            containerViewRect.origin.y = round(CGRectGetMidY(viewBounds) - CGRectGetMidY(containerViewRect));
            
            self.containerView.frame = containerViewRect;
            self.containerView.alpha = 0;
        }
            break;
            
            
        case TJModalStyleActionSheet: {
            
            // ActionSheet风格不显示边框
            padding = 0.f;
            
            CGRect containerViewRect = CGRectInset(contentView.bounds, -padding, -padding);
            containerViewRect.origin.x = 0;
            containerViewRect.origin.y = viewBounds.size.height;
            
            self.containerView.frame = containerViewRect;
            [self.containerView setBackgroundColor:[UIColor clearColor]];
            [self.containerView.styleLayer removeFromSuperlayer];
        }
            break;
            
        case TJModalStylePushRight: {
            
            padding = 0.f;
            
            CGRect containerViewRect = CGRectInset(contentView.bounds, -padding, -padding);
            containerViewRect.origin.x = viewBounds.size.width;
            containerViewRect.origin.y = 0;
            
            self.containerView.frame = containerViewRect;
            [self.containerView setBackgroundColor:[UIColor clearColor]];
            [self.containerView.styleLayer removeFromSuperlayer];
        }
            break;
            
        default:
            break;
    }
    
    self.containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    contentView.frame = (CGRect){padding, padding, contentView.bounds.size};
    
    [self.containerView addSubview:contentView];
    [self addSubview:self.containerView];
    
    
    if (TJModalStyleAlert == self.modalStyle) {
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.closeButton setHidden:!self.closeButtonEnable];
        [self.containerView addSubview:self.closeButton];
    }
    
    
    switch (self.modalStyle) {
            
        case TJModalStyleAlert: {
            
            // Alert风格显示边框和圆角
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(animated) {
                    
                    self.styleView.alpha = 0;
                    
                    [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                        
                        self.styleView.alpha = 1;
                    }];
                    
                    
                    /*
                     当为true时，该层被渲染为在其局部坐标空间中的位图（“光栅化”），则对位图进行合成到目的地（用微小筛选和应用，如果需要的位图缩放层的放大倍率筛选器属性）。出现光栅化应用层的过滤器和阴影效果后，但不透明度调制之前。作为一个实现细节的呈现引擎可尝试高速缓存和重新使用该位图从一个帧到下一帧。 （无论它与否将不会对渲染输出的影响。）当假的层直接合成到目标尽可能（但是，合成模型的某些功能可能会迫使光栅化，如添加过滤器）。默认设置为NO。动画。
                     */
                    
                    self.containerView.layer.shouldRasterize = YES;
                    
                    self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                    
                    [UIView animateWithDuration:kTRCTransformPart1AnimationDuration animations:^{
                        
                        self.containerView.alpha = 1;
                        self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:kTRCTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            self.containerView.alpha = 1;
                            self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                            
                        } completion:^(BOOL finished2) {
                            
                            self.containerView.layer.shouldRasterize = NO;
                        }];
                    }];
                }
            });
        }
            break;
            
        case TJModalStyleActionSheet: {
            
            self.styleView.alpha = 0;
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                self.styleView.alpha = 1;
            }];
            
            
            // 设置底部弹出动画
            CGRect containerViewRect = self.containerView.bounds;
            containerViewRect.origin.y = viewBounds.size.height;
            [self.containerView setFrame:containerViewRect];
            
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                
                CGRect containerViewRect = self.containerView.frame;
                
                containerViewRect.origin.y = viewBounds.size.height - containerViewRect.size.height;
                [self.containerView setFrame:containerViewRect];
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case TJModalStylePushRight: {
            
            self.styleView.alpha = 0;
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                self.styleView.alpha = 1;
            }];
            
            
            // 设置底部弹出动画
            CGRect containerViewRect = self.containerView.bounds;
            containerViewRect.origin.x = viewBounds.size.width;
            [self.containerView setFrame:containerViewRect];
            
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                
                CGRect containerViewRect = self.containerView.frame;
                
                containerViewRect.origin.x = viewBounds.size.width - containerViewRect.size.width;
                [self.containerView setFrame:containerViewRect];
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    
    
    
}


#pragma mark 以动画的形式隐藏模态窗口
- (void)hide
{
    [self hideAnimated:YES];
}


#pragma mark 隐藏模态窗口，并设置是否以动画的形式隐藏
- (void)hideAnimated:(BOOL)animated {
    
    if(!animated) {
        
        [self cleanup];
        return;
    }
    
    
    CGRect viewBounds = self.bounds;
    
    switch (self.modalStyle) {
            
        case TJModalStyleAlert: {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                    self.styleView.alpha = 0;
                }];
                
                self.containerView.layer.shouldRasterize = YES;
                
                [UIView animateWithDuration:kTRCTransformPart2AnimationDuration animations:^{
                    
                    self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:kTRCTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        
                        self.containerView.alpha = 0;
                        self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                        
                    } completion:^(BOOL finished2){
                        
                        [self cleanup];
                    }];
                }];
            });
        }
            break;
            
        case TJModalStyleActionSheet: {
            
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                
                CGRect containerViewRect = self.containerView.frame;
                containerViewRect.origin.y = viewBounds.size.height;
                [self.containerView setFrame:containerViewRect];
                
            } completion:^(BOOL finished) {
                
                [self cleanup];
            }];
        }
            break;
            
        case TJModalStylePushRight:
        {
            [UIView animateWithDuration:kTRCFadeInAnimationDuration animations:^{
                
                CGRect containerViewRect = self.containerView.frame;
                containerViewRect.origin.x = viewBounds.size.width;
                [self.containerView setFrame:containerViewRect];
                
            } completion:^(BOOL finished) {
                
                [self cleanup];
            }];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark -
#pragma mark Private Methods
#pragma mark 点击关闭按钮
- (void)closeAction:(id)sender {
    
    [self hideAnimated:self.animateWhenDismissed];
}


#pragma mark 接收到TRCModalGradientView界面被点击的通知时调用
- (void)tapCloseAction:(id)sender {
    
    if(self.tapOutsideToDismiss) {
        
        [self hideAnimated:self.animateWhenDismissed];
    }
}


#pragma mark 清除界面
- (void)cleanup {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}



#pragma mark -
#pragma mark TRCModalGradientViewDelegate
#pragma mark 背景界面被点击时回调
- (void)gradientViewTapped {
    
    [self tapCloseAction:nil];
}

@end

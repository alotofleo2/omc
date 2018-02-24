//
//  TJAlertView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/3/24.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import "TJAlertView.h"
@interface TJAlertView ()
@property (nonatomic, weak) UIView *coverView;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) void(^closeHandle)(void);
@end

@implementation TJAlertView

+ (instancetype)actionWithContentViewSettingHandle:(void (^)(UIView *contentView))SettingHandle closeHandle:(void(^)(void))closeHandle {
    TJAlertView *alerView = [[TJAlertView alloc]init];
    alerView.closeHandle = closeHandle;
    if (SettingHandle) {
        SettingHandle(alerView.contentSttingView);
    }
    
    
    return alerView;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT)]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = RGBA(0, 0, 0, 0);
    self.backGroundView = [[UIView alloc]init];
    [self addSubview:self.backGroundView];
//    self.backGroundView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"alertView_backGround"].CGImage);

    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.image = [UIImage imageNamed:@"alertView_backGround"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self.backGroundView addSubview:self.backgroundImageView];
    
    self.contentSttingView = [[UIView alloc]init];
    [self.backGroundView addSubview:self.contentSttingView];
    
    self.closeButton = [[UIButton alloc]init];
    self.closeButton.alpha = 0.7;
    [self addSubview:self.closeButton];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"alertView_close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backGroundView.mas_top).mas_offset(-TJSystem1080Height(33));
        make.right.equalTo(self.backGroundView);
        make.width.height.equalTo(@(TJSystem1080Width(70)));
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(self.backGroundView).mas_offset(TJSystem1080Width(70));
        make.height.equalTo(self.backGroundView).mas_offset(TJSystem1080Height(70));
        make.center.equalTo(self.backGroundView);
        
    }];
}



- (void)show {
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *coverView = [[UIView alloc]initWithFrame:window.bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    self.closeButton.alpha = 0;
    self.coverView = coverView;
    [window addSubview:coverView];
    [window addSubview:self];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentSttingView);
        make.center.equalTo(window);
    }];
    [self.backGroundView layoutIfNeeded];
    self.contentSttingView.alpha = 0;
       self.backGroundView.transform = CGAffineTransformMakeScale(0.005, 0.005);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backGroundView.transform = CGAffineTransformMakeScale(1, 0.005);
        self.coverView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.backGroundView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentSttingView.alpha = 1;
                self.closeButton.alpha = 1;
            }];
        }];
    }];
}
- (void)close {
    
    [self.coverView removeFromSuperview];
    [self removeFromSuperview];
}
#pragma mark - 点击事件
- (void)closeButtonPressed:(id)sender {
    //如果有特殊回调的要求 就执行特殊回调
    if (self.specialCloneHandle) {
        self.specialCloneHandle(self.backGroundView);
        self.closeButton.hidden = YES;
        return;
    }
    if (self.closeHandle) {
        self.closeHandle();
    }
    [self close];
}
@end

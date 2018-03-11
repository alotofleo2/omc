//
//  TJCurtainEditSettingAlerView.m
//  omc
//
//  Created by 方焘 on 2018/3/11.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditSettingAlerView.h"

@interface TJCurtainEditSettingAlerView()

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIButton *firstButton;

@property (nonatomic, strong) UIButton *secendButton;
@end

@implementation TJCurtainEditSettingAlerView

- (instancetype)init {
    if (self = [super init]) {
    
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
    }
    
    return self;
}
- (void)setupSubviews {
    self.topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"edit_header"]];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.topImageView.transform = CGAffineTransformMakeScale(-1, 1);
    [self addSubview:self.topImageView];
    
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.firstButton setTitle:@"窗帘" forState:UIControlStateNormal];
    [self.firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.firstButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    self.firstButton.titleLabel.font = [UIFont systemFontOfSize:17 * [TJAdaptiveManager adaptiveScale]];
    [self.firstButton addTarget:self action:@selector(firstButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.firstButton];
    
    self.secendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.secendButton setTitle:@"窗头" forState:UIControlStateNormal];
    [self.secendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.secendButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    self.secendButton.titleLabel.font = [UIFont systemFontOfSize:17 * [TJAdaptiveManager adaptiveScale]];
    [self.secendButton addTarget:self action:@selector(secendButtonButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.secendButton];
}

- (void)setupLayoutSubviews {
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.32);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.equalTo(self.topImageView);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.secendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(self.topImageView);
        make.left.equalTo(self.firstButton.mas_right);
    }];
}

#pragma mark 点击事件
- (void)firstButtonPressed {
    
    self.firstButton.selected = YES;
    self.secendButton.selected = NO;
//    if (self.contentButtonPressedHandle) {
//        self.contentButtonPressedHandle(TJCurtainContentTypeCurtain);
//    }
}

- (void)secendButtonButtonPressed {
    
    self.firstButton.selected = NO;
    self.secendButton.selected = YES;
//    if (self.contentButtonPressedHandle) {
//        self.contentButtonPressedHandle(TJCurtainContentTypeCurtainHead);
//    }
}
@end

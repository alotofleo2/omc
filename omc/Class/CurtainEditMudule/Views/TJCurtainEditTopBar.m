//
//  TJCurtainEditTopBar.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditTopBar.h"
#import "TJCurtainEditTopContentAlerView.h"
#import "TJCurtainEditSettingAlerView.h"
@interface TJCurtainEditTopBar()

@property (nonatomic, strong)UIImageView *backgroundImageView;

//关闭按钮
@property (nonatomic, strong)UIImageView *closeImageView;

//内容选择按钮
@property (nonatomic, strong)UIImageView *contentSelectImageView;

//设置按钮
@property (nonatomic, strong)UIButton *settingButton;

//确认按钮
@property (nonatomic, strong)UIImageView *sureImageView;

//弹出的窗头窗帘选择视图
@property (nonatomic, strong)TJCurtainEditTopContentAlerView *contentAlerView;

@property (nonatomic, assign)TJCurtainContentType currentType;

//弹出的设置视图
@property (nonatomic, strong)TJCurtainEditSettingAlerView *settingAlerView;

//遮罩view
@property (nonatomic, strong)UIView *maskView;

@end

@implementation TJCurtainEditTopBar


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.currentType = TJCurtainContentTypeCurtain;
        

    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.image = [UIImage imageWithColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    [self addSubview:self.backgroundImageView];
    
    self.closeImageView = [[UIImageView alloc]init];
    self.closeImageView.image = [UIImage imageNamed:@"edit_cancel"] ;
    self.closeImageView.userInteractionEnabled = YES;
    self.closeImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *closeGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionPressed:)];
    [self.closeImageView addGestureRecognizer:closeGesture];
    [self addSubview:self.closeImageView];
    
    
    self.contentSelectImageView = [[UIImageView alloc]init];
    self.contentSelectImageView.image = [UIImage imageNamed:@"edit_image"] ;
    self.contentSelectImageView.userInteractionEnabled = YES;
    self.contentSelectImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *contentGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionPressed:)];
    [self.contentSelectImageView addGestureRecognizer:contentGesture];
    [self addSubview:self.contentSelectImageView];
    
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingButton setImage:[UIImage imageNamed:@"edit_setting"] forState:UIControlStateNormal];
    self.settingButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, TJSystem2Xphone6Width(15));
    [self.settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [self.settingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.settingButton.titleLabel.font = [UIFont systemFontOfSize:14 *[TJAdaptiveManager adaptiveScale]];
    [self.settingButton addTarget: self action:@selector(settingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.settingButton.layer.cornerRadius = TJSystem2Xphone6Height(70) / 2;
    self.settingButton.layer.masksToBounds = YES;
    [self.settingButton setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.settingButton];
    
    self.sureImageView = [[UIImageView alloc]init];
    self.sureImageView.image = [UIImage imageNamed:@"edit_selected"] ;
    self.sureImageView.userInteractionEnabled = YES;
    self.sureImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *sureGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionPressed:)];
    [self.sureImageView addGestureRecognizer:sureGesture];
    [self addSubview:self.sureImageView];
}

- (void)setupLayoutSubviews {
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_offset(-TJSystem2Xphone6Height(25));
        make.left.mas_offset(TJSystem2Xphone6Width(20));
        make.height.equalTo(@(TJSystem2Xphone6Width(38)));
        make.width.equalTo(@(TJSystem2Xphone6Width(30)));
    }];
    
    [self.contentSelectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.centerY.equalTo(self.closeImageView);
        make.right.equalTo(self.mas_centerX).mas_offset(-TJSystem2Xphone6Width(110));
        make.height.width.equalTo(@(TJSystem2Xphone6Width(41)));
    }];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.closeImageView);
        make.left.equalTo(self.mas_centerX).mas_offset(TJSystem2Xphone6Width(54));
        make.height.equalTo(@(TJSystem2Xphone6Height(70)));
        make.width.equalTo(@(TJSystem2Xphone6Width(157)));
    }];
    [self.sureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_offset(-TJSystem2Xphone6Height(25));
        make.right.mas_offset(-TJSystem2Xphone6Width(20));
        make.height.width.equalTo(@(TJSystem2Xphone6Width(38)));
    }];
}

#pragma mark - getter
#pragma mark 懒加载内容选择视图
- (UIView *)contentAlerView {
    if (!_contentAlerView) {
        
        BLOCK_WEAK_SELF
        _contentAlerView = [[TJCurtainEditTopContentAlerView alloc]initWithType:self.currentType];
        _contentAlerView.hidden = YES;
        _contentAlerView.contentButtonPressedHandle = ^(TJCurtainContentType type) {
            weakSelf.currentType = type;
            if (weakSelf.contentActionHandle) {
                weakSelf.contentActionHandle(type);
            }
                
            weakSelf.contentAlerView.hidden = YES;
            
        };
        [self.superview addSubview:_contentAlerView];
        [_contentAlerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.contentSelectImageView.mas_centerX).mas_offset(TJSystem2Xphone6Width(370) / 4);
            make.height.equalTo(@(TJSystem2Xphone6Width(108)));
            make.width.equalTo(@(TJSystem2Xphone6Width(360)));
        }];
        
    }
    return _contentAlerView;
}

#pragma mark 懒加载设置视图
- (TJCurtainEditSettingAlerView *)settingAlerView {
    if (!_settingAlerView) {
        _settingAlerView = [[TJCurtainEditSettingAlerView alloc]init];
        _settingAlerView.hidden = YES;
        [self.superview addSubview:_settingAlerView];
        
        [_settingAlerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.settingButton.mas_centerX).mas_offset(-TJSystem2Xphone6Width(480) / 3);
            make.height.equalTo(@(TJSystem2Xphone6Height(420)));
            make.width.equalTo(@(TJSystem2Xphone6Width(480)));
        }];
    }
    return _settingAlerView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
        _maskView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewPressed)];
        [_maskView addGestureRecognizer:gesture];
        [self.superview addSubview:_maskView];
    }
    return _maskView;
}
#pragma mark - 点击事件
- (void)actionPressed:(UIGestureRecognizer *)recognizer {
    
    if (recognizer.view == self.closeImageView) {
        
        if (self.closeActionHandle) self.closeActionHandle();
        
    } else if (recognizer.view == self.contentSelectImageView) {
            
        self.contentAlerView.hidden = !self.contentAlerView.isHidden;
        self.maskView.hidden = self.contentAlerView.isHidden;
        [self.contentAlerView.superview bringSubviewToFront:self.contentAlerView];
    } else if (recognizer.view == self.sureImageView) {
        
        if (self.sureActionHandle) self.sureActionHandle();
        
    }
}

- (void)settingButtonPressed {
    
    self.settingAlerView.hidden = !self.settingAlerView.isHidden;
    self.maskView.hidden = self.settingAlerView.isHidden;
    [self.settingAlerView.superview bringSubviewToFront:self.settingAlerView];
    if (self.settingActionHandle) self.settingActionHandle();
}

- (void)maskViewPressed {
    
    self.contentAlerView.hidden = YES;
    self.settingAlerView.hidden = YES;
    self.maskView.hidden = YES;
}
@end

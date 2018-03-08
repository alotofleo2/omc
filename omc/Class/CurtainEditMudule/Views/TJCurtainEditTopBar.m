//
//  TJCurtainEditTopBar.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditTopBar.h"

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
@end

@implementation TJCurtainEditTopBar


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
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
    self.closeImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    [self.settingButton setImage:[UIImage imageNamed:@"edit_image"] forState:UIControlStateNormal];
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
    self.sureImageView.contentMode = UIViewContentModeScaleAspectFill;
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
        make.height.width.equalTo(@(TJSystem2Xphone6Width(38)));
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

#pragma mark 点击事件
- (void)actionPressed:(UIGestureRecognizer *)recognizer {
    
    if (recognizer.view == self.closeImageView) {
        
        if (self.closeActionHandle) self.closeActionHandle();
        
    } else if (recognizer.view == self.contentSelectImageView) {
        
        if (self.contentActionHandle) self.contentActionHandle();

    } else if (recognizer.view == self.sureImageView) {
        
        if (self.sureActionHandle) self.sureActionHandle();
        
    }
}

- (void)settingButtonPressed {
    
    if (self.settingActionHandle) self.settingActionHandle();
}
@end

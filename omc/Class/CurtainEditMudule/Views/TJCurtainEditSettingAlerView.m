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

//亮度
@property (nonatomic, strong) UIView *hilightView;
//对比度
@property (nonatomic, strong) UIView *contrastView;
//暗部改善
@property (nonatomic, strong) UIView *guanganView;
@end

@implementation TJCurtainEditSettingAlerView

- (instancetype)init {
    if (self = [super init]) {
    
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}
- (void)setupSubviews {
    self.topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"editSetting_Header"]];
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.topImageView];
    
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.firstButton setTitle:@"单幅展示" forState:UIControlStateNormal];
    self.firstButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    [self.firstButton setImage:[UIImage imageNamed:@"editSetting_buttonUnselected"]  forState:UIControlStateNormal];
    [self.firstButton setImage:[UIImage imageNamed:@"editSetting_buttonSelected"] forState:UIControlStateSelected];
    [self.firstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - TJSystem2Xphone6Width(10), 0, 0)];
    self.firstButton.titleLabel.font = [UIFont systemFontOfSize:13.5 * [TJAdaptiveManager adaptiveScale]];
    [self.firstButton addTarget:self action:@selector(firstButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.firstButton.selected = YES;
    [self addSubview:self.firstButton];
    
    self.secendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.secendButton setTitle:@"多幅展示" forState:UIControlStateNormal];
    self.secendButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    [self.secendButton setImage:[UIImage imageNamed:@"editSetting_buttonUnselected"]  forState:UIControlStateNormal];
    [self.secendButton setImage:[UIImage imageNamed:@"editSetting_buttonSelected"] forState:UIControlStateSelected];
    [self.secendButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - TJSystem2Xphone6Width(10), 0, 0)];
    [self.secendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.secendButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    self.secendButton.titleLabel.font = [UIFont systemFontOfSize:13.5 * [TJAdaptiveManager adaptiveScale]];
    [self.secendButton addTarget:self action:@selector(secendButtonButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.secendButton];
    
    self.hilightView = [self createSiderWithIconName:@"editSetting_hilight" title:@"亮度" value:0.5 type:TJCurtainBackgroundChangeTypeHilight];
    [self addSubview:self.hilightView];
    
    self.contrastView = [self createSiderWithIconName:@"editSetting_contrast" title:@"对比" value:0.5 type:TJCurtainBackgroundChangeTypeContrast];
    [self addSubview:self.contrastView];
    
    self.guanganView = [self createSiderWithIconName:@"editSetting_guangan" title:@"暗部改善" value:0.5 type:TJCurtainBackgroundChangeTypeDark];
    [self addSubview:self.guanganView];
}

- (UIView *)createSiderWithIconName:(NSString *)iconName title:(NSString *)title value:(CGFloat)vaule type:(TJCurtainBackgroundChangeType)type {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
    [view addSubview:icon];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:11 *[TJAdaptiveManager adaptiveScale]];
    [view addSubview:titleLabel];
    
    UISlider *slider = [[UISlider alloc]init];
    slider.tag = type;
    [slider setMaximumTrackTintColor:UIColorFromRGB(0xd8d8d8)];
    [slider setMinimumTrackTintColor:UIColorFromRGB(0xd8d8d8)];
    
    UIImage *tubmImage = [[[UIImage imageWithColor:UIColorFromRGB(0x313030)]scaleToSize:CGSizeMake(TJSystem2Xphone6Width(24), TJSystem2Xphone6Width(24))]cutCircleImage];
    [slider setThumbImage:tubmImage forState:UIControlStateNormal];
    slider.value = vaule ?: 0.5;
    [view addSubview:slider];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    UIView *lineview = [[UIView alloc]init];
    lineview.backgroundColor = UIColorFromRGB(0xe8e8e8);
    [view addSubview:lineview];
    
    //layout
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(view);
        make.left.mas_offset(TJSystem2Xphone6Width(30));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(icon.mas_right).mas_offset(TJSystem2Xphone6Width(30));
        make.top.equalTo(icon);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(icon.mas_right).mas_offset(TJSystem2Xphone6Width(30));
        make.right.mas_offset(-TJSystem2Xphone6Width(30));
        make.bottom.equalTo(icon);
    }];
    
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(view);
        make.height.equalTo(@(0.5));
    }];
    
    return view;
}

- (void)setupLayoutSubviews {
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(TJSystem2Xphone6Width(108)));
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.equalTo(self.topImageView);
        make.top.mas_offset(TJSystem2Xphone6Height(20));
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.secendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_offset(TJSystem2Xphone6Height(20));
        make.right.bottom.equalTo(self.topImageView);
        make.left.equalTo(self.firstButton.mas_right);
    }];
    
    [self.hilightView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self.topImageView.mas_bottom);
    }];
    
    [self.contrastView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.equalTo(self.hilightView);
        make.top.equalTo(self.hilightView.mas_bottom);
    }];
    
    [self.guanganView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.equalTo(self.hilightView);
        make.top.equalTo(self.contrastView.mas_bottom);
        make.bottom.equalTo(self);
    }];
}

#pragma mark 点击事件
- (void)firstButtonPressed {
    
    self.firstButton.selected = YES;
    self.secendButton.selected = NO;
    if (self.ContentNumberButtonPressedHandle) {
        self.ContentNumberButtonPressedHandle(TJCurtainContentNumberTypeSingle);
    }
}

- (void)secendButtonButtonPressed {
    
    self.firstButton.selected = NO;
    self.secendButton.selected = YES;
    if (self.ContentNumberButtonPressedHandle) {
        self.ContentNumberButtonPressedHandle(TJCurtainContentNumberTypeMulti);
    }
}

#pragma mark sliderChanege
- (void)sliderChange:(UISlider *)sender {
    if (self.BackgroundChangeHandle) {
        self.BackgroundChangeHandle(sender.tag, sender.value);
    }
}
@end

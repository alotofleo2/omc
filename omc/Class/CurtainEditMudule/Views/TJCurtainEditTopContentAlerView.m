//
//  TJCurtainEditTopContentAlerView.m
//  omc
//
//  Created by 方焘 on 2018/3/11.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditTopContentAlerView.h"

@interface TJCurtainEditTopContentAlerView()

@property (nonatomic, strong) UIImageView *backGroudView;

@property (nonatomic, strong) UIButton *firstButton;

@property (nonatomic, strong) UIButton *secendButton;

@end

@implementation TJCurtainEditTopContentAlerView

- (instancetype)initWithType:(TJCurtainContentType)type; {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        switch (type) {
            case 1:
                self.firstButton.selected = YES;
                break;
            case 2:
                self.secendButton.selected = YES;
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

- (void)setupSubviews {
    self.backGroudView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"edit_header"]];
    self.backGroudView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backGroudView];

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
    [self.backGroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(0);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.secendButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.firstButton.mas_right);
    }];
}

- (void)firstButtonPressed {
    
    self.firstButton.selected = YES;
    self.secendButton.selected = NO;
    if (self.contentButtonPressedHandle) {
        self.contentButtonPressedHandle(TJCurtainContentTypeCurtain);
    }
}

- (void)secendButtonButtonPressed {
    
    self.firstButton.selected = NO;
    self.secendButton.selected = YES;
    if (self.contentButtonPressedHandle) {
        self.contentButtonPressedHandle(TJCurtainContentTypeCurtainHead);
    }
}
@end

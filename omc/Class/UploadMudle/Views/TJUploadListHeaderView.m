//
//  TJUploadListHeaderView.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListHeaderView.h"

@interface TJUploadListHeaderView ()

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *middleButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *middleLeftLine;

@property (nonatomic, strong) UIView *middleRightLine;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIView *blueLine;

@end

@implementation TJUploadListHeaderView


- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubviews {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.leftButton setTitle:@"待审核" forState:UIControlStateNormal];
    self.leftButton.tag = 1000;
    [self.leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.middleButton.titleLabel.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.middleButton setTitle:@"已通过" forState:UIControlStateNormal];
    [self.middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.middleButton.tag = 1001;
    [self.middleButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.middleButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.rightButton setTitle:@"未通过" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.tag = 1002;
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    
    self.middleLeftLine = [[UIView alloc] init];
    self.middleLeftLine.backgroundColor = UIColorFromRGB(0xe6e8ed);
    [self addSubview:self.middleLeftLine];
    
    self.middleRightLine = [[UIView alloc] init];
    self.middleRightLine.backgroundColor = UIColorFromRGB(0xe6e8ed);
    [self addSubview:self.middleRightLine];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = UIColorFromRGB(0xe6e8ed);
    [self addSubview:self.bottomLine];
    
    self.blueLine = [[UIView alloc]init];
    self.blueLine.backgroundColor = UIColorFromRGB(0x389dff);
    self.blueLine.layer.cornerRadius = TJSystem2Xphone6Height(5) / 2;
    self.blueLine.layer.masksToBounds = YES;
    [self addSubview:self.blueLine];
}

- (void)setupLayoutSubviews {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(self);

    }];
    
    [self.middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.leftButton);
        make.left.equalTo(self.leftButton.mas_right).mas_offset(0.5);
        make.right.equalTo(self.rightButton.mas_left).mas_offset(-0.5);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(self.leftButton);
    }];
    
    [self.middleLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(1));
        make.left.equalTo(self.leftButton.mas_right);
        make.top.mas_offset(TJSystem2Xphone6Height(21));
        make.bottom.mas_offset(-TJSystem2Xphone6Height(21));
    }];
    
    [self.middleRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(1));
        make.right.equalTo(self.rightButton.mas_left);
        make.top.mas_offset(TJSystem2Xphone6Height(21));
        make.bottom.mas_offset(-TJSystem2Xphone6Height(21));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@(1));
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.blueLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@(TJSystem2Xphone6Height(5)));
        make.width.equalTo(@(TJSystem2Xphone6Width(112)));
        make.bottom.equalTo(self);
        make.centerX.equalTo(self.leftButton);
    }];
}

- (void)buttonPressed:(UIButton *)sender {

    
    [self.leftButton setTitleColor:sender == self.leftButton ? UIColorFromRGB(0x379dfd) : [UIColor blackColor]  forState:UIControlStateNormal];
    
    [self.rightButton setTitleColor:sender == self.rightButton ? UIColorFromRGB(0x379dfd) : [UIColor blackColor]  forState:UIControlStateNormal];
    
    [self.middleButton setTitleColor:sender == self.middleButton ? UIColorFromRGB(0x379dfd) : [UIColor blackColor]  forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.blueLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(TJSystem2Xphone6Height(5)));
            make.width.equalTo(@(TJSystem2Xphone6Width(112)));
            make.bottom.equalTo(self);
            make.centerX.equalTo(sender);
        }];
    }];
    if (self.buttonPressedHandle) {
        self.buttonPressedHandle(sender.tag - 1000);
    }
}
@end

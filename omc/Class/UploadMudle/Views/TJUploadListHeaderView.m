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

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *middleLine;

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
    [self.leftButton setTitle:@"已上传" forState:UIControlStateNormal];
    self.leftButton.tag = 1;
    [self.leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.rightButton setTitle:@"未通过" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.tag = 2;
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    
    self.middleLine = [[UIView alloc] init];
    self.middleLine.backgroundColor = UIColorFromRGB(0xe6e8ed);
    [self addSubview:self.middleLine];
    
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
        make.right.equalTo(self.mas_centerX).mas_offset(-TJSystem2Xphone6Height(0.5));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_centerX).mas_offset(TJSystem2Xphone6Height(0.5));
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(1));
        make.centerX.equalTo(self.mas_centerX);
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
    if (sender.tag == 1) {
        [self.leftButton setTitleColor:UIColorFromRGB(0x379dfd) forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    } else {
        [self.rightButton setTitleColor:UIColorFromRGB(0x379dfd) forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.blueLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(TJSystem2Xphone6Height(5)));
            make.width.equalTo(@(TJSystem2Xphone6Width(112)));
            make.bottom.equalTo(self);
            make.centerX.equalTo(sender.tag == 1 ? self.leftButton : self.rightButton);
        }];
    }];
    if (self.buttonPressedHandle) {
        self.buttonPressedHandle(sender.tag);
    }
}
@end

//
//  TJCategorySearchBar.m
//  omc
//
//  Created by 方焘 on 2018/3/20.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategorySearchBar.h"

@interface TJCategorySearchBar() <UITextFieldDelegate>
/**搜索框*/
@property (nonatomic, strong) UITextField *searchBarText;

@property (nonatomic, strong) UIImageView *iconImageVIew;

@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation TJCategorySearchBar

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_NAVIGATIONBAR_HEIGHT);
    
    self.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    //icon
    self.iconImageVIew = [[UIImageView alloc]init];
    self.iconImageVIew.image = [UIImage imageNamed:@"category_searbarIcon"];
    self.iconImageVIew.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageVIew];
    
    //设置搜索的textfield
    self.searchBarText = [[UITextField alloc] init];
    self.searchBarText.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBarText.delegate = self;
    [self addSubview:self.searchBarText];
    self.searchBarText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchBarText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //设置左边搜索按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"Search_noraml"] forState:UIControlStateNormal];
    self.searchBarText.leftView = leftBtn;
    [self.searchBarText.leftView setFrame:CGRectMake(0, 0, 25, 20)];
    self.searchBarText.leftViewMode = UITextFieldViewModeAlways;
    
    //设置取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:13.5 * [TJAdaptiveManager adaptiveScale]];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:UIColorFromRGB(0x6e7582) forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (void)setupLayoutSubviews {
    
    [self.iconImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_offset(TJSystem2Xphone6Width(20));
        make.width.height.equalTo(@(19));
        make.right.equalTo(self.searchBarText.mas_left).mas_offset(- TJSystem2Xphone6Width(20));
        make.centerY.equalTo(self.searchBarText);
    }];
    
    [self.searchBarText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(30));
        make.bottom.mas_offset(-5);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.centerY.equalTo(self.searchBarText);
        make.left.equalTo(self.searchBarText.mas_right);
        make.right.equalTo(self);
        make.width.equalTo(@(TJSystem2Xphone6Width(80)));
        
    }];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(customSearch: inputText: )]) {
        [self.delegate customSearch:self inputText:textField.text];
    }
}

- (void)cancleClick:(UIButton *)sender {
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(customSearchBar: cancleButton:)]) {
        [self.delegate customSearchBar:self cancleButton:sender];
    }
    [self.searchBarText resignFirstResponder];
}

- (void)show {
    [self.searchBarText becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}
@end

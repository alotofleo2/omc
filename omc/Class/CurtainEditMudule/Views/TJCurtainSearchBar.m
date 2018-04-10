//
//  TJCurtainSearchBar.m
//  omc
//
//  Created by 方焘 on 2018/4/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainSearchBar.h"

@interface TJCurtainSearchBar () <UITextFieldDelegate>
/**搜索框*/
@property (nonatomic, strong) UITextField *searchBarText;

//@property (nonatomic, strong) UIImageView *iconImageVIew;

@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation TJCurtainSearchBar
- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = UIColorFromRGB(0x333333);
    
    
    //设置搜索的textfield
    self.searchBarText = [[UITextField alloc] init];
    self.searchBarText.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBarText.keyboardType = UIKeyboardTypeASCIICapable;
    self.searchBarText.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBarText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBarText.delegate = self;
    self.searchBarText.placeholder = @"请输入窗帘编号搜索";
    [self addSubview:self.searchBarText];
    self.searchBarText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchBarText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //设置左边搜索按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    leftBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    [leftBtn setImage:[UIImage imageNamed:@"Search_noraml"] forState:UIControlStateNormal];
    self.searchBarText.leftView = leftBtn;
    [self.searchBarText.leftView setFrame:CGRectMake(0, 0, 25, 20)];
    self.searchBarText.leftViewMode = UITextFieldViewModeAlways;
    
    //设置取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (void)setupLayoutSubviews {
    

    
    [self.searchBarText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(TJSystem2Xphone6Height(62)));
        make.centerY.equalTo(self);
        make.left.mas_offset(TJSystem2Xphone6Width(20));
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
    
    if (self.searchBarText.text.length > 0) {
        self.searchBarText.text = @"";
        if ([self.delegate respondsToSelector:@selector(customSearch: inputText: )]) {
            [self.delegate customSearch:self inputText:@""];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(customSearchBar: cancleButton:)]) {
        [self.delegate customSearchBar:self cancleButton:sender];
    }
    [self.searchBarText resignFirstResponder];
}

@end

//
//  TJLoginViewController.m
//  omc
//
//  Created by 方焘 on 2018/2/28.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJLoginViewController.h"
#import "TJSettingTask.h"

@interface TJLoginViewController () <UITextFieldDelegate>
//首行显示title
@property (nonatomic, strong) UILabel *titleLabel;

//=============username
@property (nonatomic, strong) UIImageView *userNameIconImage;

@property (nonatomic, strong) UITextField *userNameTextField;

@property (nonatomic, strong) UIView *userNameLine;

//=============password
@property (nonatomic, strong) UIImageView *passwordIconImage;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIView *passwordLine;

//============button
@property (nonatomic, strong) UIButton *actionButton;
@end

@implementation TJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    
    [self setupLayoutSubviews];
    
    self.navigationItem.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 点击屏幕回收键盘
    UITapGestureRecognizer *viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardresignFirstResponder)];
    [self.view addGestureRecognizer:viewGesture];
    
    [self addNavBackButtonWithDefaultAction];
}

- (void)setUpSubviews {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = UIColorFromRGB(0xa1a9ae);
    self.titleLabel.font = [UIFont systemFontOfSize:14 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.text = @"请使用经销商账户登录!";
    [self.view addSubview:self.titleLabel];
    
    //=============username

    self.userNameIconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting_userName"]];
    self.userNameIconImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.userNameIconImage];
    
    self.userNameTextField = [[UITextField alloc]init];
    self.userNameTextField.delegate = self;
    self.userNameTextField.keyboardType = UIKeyboardTypeDefault;
    self.userNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.userNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.userNameTextField.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    self.userNameTextField.placeholder = @"请输入您的经销商账户";
    [self.view addSubview:self.userNameTextField];
    
    self.userNameLine = [[UIView alloc]init];
    self.userNameLine.backgroundColor = UIColorFromRGB(0xf2f2f5);
    [self.view addSubview:self.userNameLine];
    
    //=============password
    self.passwordIconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting_password"]];
    self.passwordIconImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.passwordIconImage];
    
    self.passwordTextField = [[UITextField alloc]init];
    self.passwordTextField.delegate = self;
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
    self.passwordTextField.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    self.passwordTextField.placeholder = @"请输入您的密码";
    self.passwordTextField.secureTextEntry = YES;
    [self.view addSubview:self.passwordTextField];
    
    self.passwordLine = [[UIView alloc]init];
    self.passwordLine.backgroundColor = UIColorFromRGB(0xf2f2f5);
    [self.view addSubview:self.passwordLine];
    
    //=============button
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside ];
    [self.actionButton  addTarget:self action:@selector(actionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.actionButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d) cornerRadius:5] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.actionButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.actionButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.actionButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:self.actionButton];
    
}

- (void)setupLayoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(84));
        make.top.equalTo(self.view).mas_offset(TJSystem2Xphone6Height(24));
    }];
    
    //=============username
    [self.userNameIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(68));
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(54));
        make.width.equalTo(@(TJSystem2Xphone6Width(36)));
        make.height.equalTo(@(TJSystem2Xphone6Width(44)));
    }];
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.userNameIconImage.mas_right).mas_offset(TJSystem2Xphone6Width(20));
        make.centerY.equalTo(self.userNameIconImage);
    }];
    
    [self.userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.userNameIconImage.mas_bottom).mas_offset(TJSystem2Xphone6Height(28));
        make.left.equalTo(self.userNameIconImage);
        make.height.equalTo(@(1));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(68));
        make.right.equalTo(self.userNameTextField.mas_right);
    }];
    
    //=============Password
    [self.passwordIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(68));
        make.top.equalTo(self.userNameLine.mas_bottom).mas_offset(TJSystem2Xphone6Height(20));
        make.width.equalTo(@(TJSystem2Xphone6Width(36)));
        make.height.equalTo(@(TJSystem2Xphone6Width(44)));
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.passwordIconImage.mas_right).mas_offset(TJSystem2Xphone6Width(20));
        make.centerY.equalTo(self.passwordIconImage);
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.passwordIconImage.mas_bottom).mas_offset(TJSystem2Xphone6Height(28));
        make.left.equalTo(self.passwordIconImage);
        make.height.equalTo(@(1));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(68));
        make.right.equalTo(self.passwordTextField.mas_right);
    }];
    
    //================button
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.passwordLine);
        make.height.equalTo(@(TJSystem2Xphone6Height(90)));
        make.top.equalTo(self.passwordLine.mas_bottom).mas_offset(TJSystem2Xphone6Height(90));
    }];
}
#pragma mark 点击事件
- (void)actionButtonPressed:(UIButton *)sender {

    [UIView animateWithDuration:0.25 animations:^{
        self.actionButton.layer.shadowOpacity = 0.3;
    }];
    
    if (self.userNameTextField.text.length == 0) {
        
        [self showToastWithString:@"请输入用户名"];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        
        [self showToastWithString:@"请输入密码"];
        return;
    }
    
    [self cancelTask];
    
    self.actionButton.enabled = NO;
    
    
    TJRequest *request = [TJSettingTask loginWithUserName:self.userNameTextField.text password:self.passwordTextField.text SuccessBlock:^(TJResult *result) {
        if (result.errcode != 200) {
            
            [self showToastWithString:@"登录出错"];
        }
        //更新token
        [[TJTokenManager sharedInstance]updateTokenWithInfo:result.data];
        
        //获取用户信息
        [TJSettingTask getPersonalDataWithSuccessBlock:^(TJResult *result) {
            
            [[TJUserModel sharedInstance] updateUserInfo:result.data];
        } failureBlock:^(TJResult *result) {
            
            [self showToastWithString:@"获取用户信息错误"];
        }];
        self.actionButton.enabled = YES;
        
        [self showToastWithString:@"登录成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.navigationController.childViewControllers.count > 1) {
                [[TJPageManager sharedInstance] popViewControllerWithParams:nil];
            } else {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        });
        
    } failureBlock:^(TJResult *result) {
        
        self.actionButton.enabled = YES;
        NSString *message = nil;
        if ([result.data valueForKey:@"error"]) {
            if ([[result.data valueForKey:@"error"] valueForKey:@"username"]) {
                
                message = [[[result.data valueForKey:@"error"] valueForKey:@"username"] firstObject];

                
            } else if ([[result.data valueForKey:@"error"] valueForKey:@"password"]) {

                message = [[[result.data valueForKey:@"error"] valueForKey:@"password"] firstObject];

            } else {
                
                message = result.message;
            }
            
            [self showToastWithString:message];
            
        }

    }];

    [self.taskArray addObject:request];
    
}

#pragma mark 按下阴影解除操作
- (void)actionButtonTouchDown:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.actionButton.layer.shadowOpacity = 0;
    }];
    
}


#pragma mark - 隐藏键盘
- (void)keyBoardresignFirstResponder{
    [self.view endEditing:YES];
}
@end

//
//  TJSettingChangePhoneVC.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingChangePhoneVC.h"
#import "TJSettingTask.h"

@interface TJSettingChangePhoneVC ()
//首行显示title
@property (nonatomic, strong) UILabel *titleLabel;

//=============username
@property (nonatomic, strong) UITextField *userNameTextField;

@property (nonatomic, strong) UIView *userNameLine;

//=============验证码
@property (nonatomic, strong) UITextField *authCodeTextField;

@property (nonatomic, strong) UIView *authCodeLine;

@property (nonatomic, strong) UIButton *authCodeButton;

@property (nonatomic, assign) NSInteger currentSecond;

@property (nonatomic, strong) NSTimer *timer;

//============button
@property (nonatomic, strong) UIButton *actionButton;
@end

@implementation TJSettingChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    
    [self setupLayoutSubviews];
    
    self.navigationItem.title = @"更改绑定手机";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 点击屏幕回收键盘
    UITapGestureRecognizer *viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardresignFirstResponder)];
    [self.view addGestureRecognizer:viewGesture];
}

- (void)setUpSubviews {
    //title
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = UIColorFromRGB(0xa1a9ae);
    self.titleLabel.font = [UIFont systemFontOfSize:14 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.text = [NSString stringWithFormat:@"更改绑定手机号后,下次登录可以使用新手机号登录当前手机号:%@", [TJUserModel sharedInstance].phone];
    self.titleLabel.numberOfLines = 0;
    [self.view addSubview:self.titleLabel];
    
    //=============username
    
    self.userNameTextField = [[UITextField alloc]init];
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTextField.font = [UIFont systemFontOfSize:17 *[TJAdaptiveManager adaptiveScale]];
    self.userNameTextField.placeholder = @"请输入您的手机号码";
    [self.view addSubview:self.userNameTextField];
    
    self.userNameLine = [[UIView alloc]init];
    self.userNameLine.backgroundColor = UIColorFromRGB(0xf2f2f5);
    [self.view addSubview:self.userNameLine];
    
    //=============验证码
    
    self.authCodeTextField = [[UITextField alloc]init];
    self.authCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.authCodeTextField.font = [UIFont systemFontOfSize:17 *[TJAdaptiveManager adaptiveScale]];
    self.authCodeTextField.placeholder = @"请输入验证码";
    [self.view addSubview:self.authCodeTextField];
    
    self.authCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.authCodeButton addTarget:self action:@selector(authCodeButtonPressed:) forControlEvents:UIControlEventTouchUpInside ];
    [self.authCodeButton  addTarget:self action:@selector(actionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.authCodeButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d) cornerRadius:5] forState:UIControlStateNormal];
    [self.authCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.authCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.authCodeButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.authCodeButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.authCodeButton.layer.shadowOpacity = 0.3;
    self.authCodeButton.titleLabel.font = [UIFont systemFontOfSize:14 *[TJAdaptiveManager adaptiveScale]];
    
    [self.view addSubview:self.authCodeButton];
    
    self.authCodeLine = [[UIView alloc]init];
    self.authCodeLine.backgroundColor = UIColorFromRGB(0xf2f2f5);
    [self.view addSubview:self.authCodeLine];
    
    
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
        
        make.left.right.equalTo(self.userNameLine);
        make.top.mas_offset(TJSystem2Xphone6Height(24));
    }];
    
    //=============username
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(68));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(68));
        make.left.right.equalTo(self.userNameLine);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(54));
    }];
    
    [self.userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.userNameTextField.mas_bottom).mas_offset(TJSystem2Xphone6Height(28));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(68));
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(68));
        make.height.equalTo(@(1));
    }];
    
    //=============验证码
    
    [self.authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.userNameLine);
        make.top.equalTo(self.userNameLine.mas_bottom).mas_offset(TJSystem2Xphone6Height(28));
    }];
    
    [self.authCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.userNameLine);
        make.height.equalTo(@(1));
        make.top.equalTo(self.authCodeTextField.mas_bottom).mas_offset(TJSystem2Xphone6Height(28));
    }];
    
    [self.authCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.userNameLine);
        make.centerY.equalTo(self.authCodeTextField);
        make.width.equalTo(@(TJSystem2Xphone6Width(210)));
        make.height.equalTo(@(TJSystem2Xphone6Height(70)));
    }];
    
    
    //================button
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.authCodeLine);
        make.height.equalTo(@(TJSystem2Xphone6Height(90)));
        make.top.equalTo(self.authCodeLine.mas_bottom).mas_offset(TJSystem2Xphone6Height(90));
    }];
}
#pragma mark 点击事件
- (void)actionButtonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        sender.layer.shadowOpacity = 0.3;
    }];
    
    if (![StringUtil checkMobileNumber:self.userNameTextField.text]) {
        [self showToastWithString:@"请输入正确的手机号"];
        return;
    }
    
    if (![StringUtil checkCode:self.authCodeTextField.text]) {
        [self showToastWithString:@"请输入正确的验证码"];
        return;
    }
    
    
    [self cancelTask];
    
    
    
    
    
}
#pragma mark 发送验证码点击事件
- (void)authCodeButtonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        sender.layer.shadowOpacity = 0.3;
    }];
    
    if (![StringUtil checkMobileNumber:self.userNameTextField.text]) {
        [self showToastWithString:@"请输入正确的手机号"];
        return;
    }
    
    [self cancelTask];
    
    TJRequest *request = [TJSettingTask getAuthCodeWithPhone:self.userNameTextField.text type:@"forget" SuccessBlock:^(TJResult *result) {
        
        [self startChangeCheckCodeButton];
        [self showToastWithString:@"发送验证码成功"];
        
        
    } failureBlock:^(TJResult *result) {
        
        [self showToastWithString:@"发送验证码失败"];
    }];
    [self.taskArray addObject:request];
}
#pragma mark 按下阴影解除操作
- (void)actionButtonTouchDown:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        sender.layer.shadowOpacity = 0;
    }];
    
    
}
#pragma mark - 隐藏键盘
- (void)keyBoardresignFirstResponder{
    [self.view endEditing:YES];
}

/**
 *  发送验证码开始倒计时
 */
- (void)startChangeCheckCodeButton {
    
    self.currentSecond = 60;
    BLOCK_WEAK_SELF
    self.timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(changeCheckButtonContent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.authCodeButton.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.authCodeButton.layer.shadowOpacity = 0;
    }];
}

- (void)changeCheckButtonContent {
    
    if (self.currentSecond == 0) {
        
        self.authCodeButton.enabled = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.authCodeButton.layer.shadowOpacity = 0.3;
        }];
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        
        [self.authCodeButton setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
        
        return;
    }
    self.currentSecond -= 1;
    
    [self.authCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%zd)", self.currentSecond] forState:UIControlStateNormal];
    
}

#pragma mark - Life Cycle
- (void)dealloc {
    
    [self.timer invalidate];
    
    self.timer = nil;
}

@end

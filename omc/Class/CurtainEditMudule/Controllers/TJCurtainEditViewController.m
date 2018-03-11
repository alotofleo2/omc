//
//  TJCurtainEditViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditViewController.h"
#import "TJCurtainEditContentView.h"
#import "TJCurtainEditManager.h"
#import "TJCurtainEditTopBar.h"

@interface TJCurtainEditViewController ()
@property (nonatomic, strong) TJCurtainEditContentView *editContentView;

@property (nonatomic, strong) TJCurtainEditTopBar *topBar;
@end

@implementation TJCurtainEditViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupLayoutViews];
    
}

- (void)setupViews {
    
    BLOCK_WEAK_SELF
    
    //编辑view
    self.editContentView = [[TJCurtainEditContentView alloc]init];
    self.editContentView.backGroundImageView.image = self.backGoundImage;
    [self.view addSubview:self.editContentView];
    
    //头部view
    self.topBar = [[TJCurtainEditTopBar alloc]init];
    self.topBar.closeActionHandle = ^{ [weakSelf closeButtonPressed];};
    self.topBar.contentActionHandle = ^(TJCurtainContentType type) { [weakSelf contentSelectPressedWithType:(TJCurtainContentType)type];};
    self.topBar.settingActionHandle = ^{[weakSelf settingPressed];};
    self.topBar.sureActionHandle = ^{[weakSelf surePressed];};
    [self.view addSubview:self.topBar];
}

- (void)setupLayoutViews {
    
    [self.editContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(KEditViewContentHeight));
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(DEVICE_STATUSBAR_HEIGHT + TJSystem2Xphone6Height(86)));
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 各种点击事件
#pragma mark 关闭按钮点击事件
- (void)closeButtonPressed {
    if (self.navigationController.childViewControllers.count > 1) {
        
        [[TJPageManager sharedInstance] popViewControllerWithParams:nil];
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 选择内容按钮
- (void)contentSelectPressedWithType:(TJCurtainContentType)type {
    
}

#pragma mark 设置按钮
- (void)settingPressed {
    
}

#pragma mark 确认按钮
- (void)surePressed {
    
}
@end

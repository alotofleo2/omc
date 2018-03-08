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
    
    //编辑view
    self.editContentView = [[TJCurtainEditContentView alloc]init];
    self.editContentView.backGroundImageView.image = self.backGoundImage;
    [self.view addSubview:self.editContentView];
    
    //头部view
    self.topBar = [[TJCurtainEditTopBar alloc]init];
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



@end

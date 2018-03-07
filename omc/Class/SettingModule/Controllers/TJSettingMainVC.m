//
//  TJSettingMainVC.m
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMainVC.h"
#import "TJSettingMainTopCell.h"
#import "TJSettingMainModel.h"
#import "MJExtension.h"
#import "TJSettingTask.h"

@interface TJSettingMainVC ()

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation TJSettingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSource];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    
    [self registerCellWithClassName:@"TJSettingMainTopCell" reuseIdentifier:@"TJSettingMainTopCell"];
    [self registerCellWithClassName:@"TJSettingMainNormalCell" reuseIdentifier:@"TJSettingMainNormalCell"];
    self.navigationItem.title = @"我的";
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.logoutButton addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside ];
    [self.logoutButton  addTarget:self action:@selector(logoutButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.logoutButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d) cornerRadius:5] forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.logoutButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.logoutButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.logoutButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).mas_offset(TJSystem2Xphone6Width(68));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(68));
        make.height.equalTo(@(TJSystem2Xphone6Height(90)));
        make.bottom.mas_offset(-TJSystem2Xphone6Height(150));
    }];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.logoutButton.hidden = ![TJTokenManager sharedInstance].isLogin;
}
#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *sectionData = self.dataSource[section];
    return sectionData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell = nil;
    NSMutableArray *sectionData = self.dataSource[indexPath.section];
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJSettingMainTopCell" forIndexPath:indexPath];
        TJSettingMainTopCell *topCell = (TJSettingMainTopCell *)cell;
        topCell.loginActionHandle = ^{
            [[TJPageManager sharedInstance] pushViewControllerWithName:@"TJLoginViewController"];
        };
        [cell setupViewWithModel:sectionData[indexPath.row]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJSettingMainNormalCell" forIndexPath:indexPath];
        [cell setupViewWithModel:sectionData[indexPath.row]];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [TJTokenManager sharedInstance].isLogin ? TJSystem2Xphone6Height(90) : TJSystem2Xphone6Height(270);
    }
    return TJSystem2Xphone6Height(90);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return TJSystem2Xphone6Height(30);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSettingMainModel *model = self.dataSource[indexPath.section][indexPath.row];
    
    //如果非登录状态下的第一行不做操作
    if (indexPath.section == 0 && ![TJTokenManager sharedInstance].isLogin) {
        
        return;
    }
    [[TJPageManager sharedInstance] pushViewControllerWithName:model.targetControllerName];
}

#pragma mark 点击事件
- (void)logoutButtonPressed:(UIButton *)sender {
    sender.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        sender.layer.shadowOpacity = 0.3;
    }];
    
    [self cancelTask];
    
    TJRequest *requeset = [TJSettingTask logoutWithSuccessBlock:^(TJResult *result) {
        if (result.errcode == 200) {
            
            [[TJTokenManager sharedInstance]logout];
            [[TJUserModel sharedInstance]logout];
            self.logoutButton.hidden = ![TJTokenManager sharedInstance].isLogin;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        sender.enabled = YES;
    } failureBlock:^(TJResult *result) {
        [self showToastWithString:@"退出登录失败"];
        sender.enabled = YES;
    }];
    [self.taskArray addObject:requeset];
    
}
- (void)logoutButtonTouchDown:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        sender.layer.shadowOpacity = 0;
    }];
}


#pragma mark private

-(void)setupDataSource {
    
    
    self.dataSource = [NSMutableArray arrayWithCapacity:3];
    
    NSArray *data = @[@[@{ @"targetControllerName" : @"TJPersonalDataVC"}],
                      @[@{@"title": @"关于我们", @"iconImageName":@"setting_about", @"targetControllerName" : @"TJPersonalDataVC"},
                        @{@"title":@"意见反馈", @"iconImageName":@"setting_advice", @"targetControllerName" : @"TJPersonalDataVC"}],
                      @[@{@"title":[NSString stringWithFormat:@"当前版本%@", [TJUserDefaultsManager currentVersion]], @"detial":@"已最新", @"iconImageName":@"setting_version", @"targetControllerName" : @"TJPersonalDataVC"},
                        @{@"title":@"消息", @"iconImageName":@"setting_message", @"targetControllerName" : @"TJPersonalDataVC"}],];
    
    for (NSArray *item in data) {
        [self.dataSource addObject:[TJSettingMainModel mj_objectArrayWithKeyValuesArray:item]];
    }
    
}
@end

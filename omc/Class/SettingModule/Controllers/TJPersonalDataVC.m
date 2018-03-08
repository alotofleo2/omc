//
//  TJPersonalDataVC.m
//  omc
//
//  Created by 方焘 on 2018/2/28.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJPersonalDataVC.h"
#import "TJSettingMainModel.h"
#import "MJExtension.h"

@interface TJPersonalDataVC ()

@end

@implementation TJPersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSource];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人资料";
    [self registerCellWithClassName:@"TJSettingPersonalDataCell" reuseIdentifier:@"TJSettingPersonalDataCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TJSystem2Xphone6Height(90);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    } else {
        return TJSystem2Xphone6Height(24);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJSettingPersonalDataCell" forIndexPath:indexPath];
    
    [cell setupViewWithModel:self.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TJSettingMainModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (model.targetControllerName != nil) {
        [[TJPageManager sharedInstance] pushViewControllerWithName:model.targetControllerName];
    }
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSettingMainModel *model = self.dataSource[indexPath.section][indexPath.row];
    return model.targetControllerName != nil;
}


- (void)setupDataSource {
    
    NSArray *dataArray = @[@[@{@"title":@"用户名", @"detial":[TJUserModel sharedInstance].username?:@""},
                             @{@"title":@"姓名", @"detial":[TJUserModel sharedInstance].name?:@""},
                             @{@"title":@"联系电话", @"detial":[TJUserModel sharedInstance].phone?:@""},
                             @{@"title":@"性别", @"detial":[TJUserModel sharedInstance].sex?:@""},
                             @{@"title":@"地址", @"detial":[TJUserModel sharedInstance].address?:@""}],
                           @[@{@"title":@"修改密码", @"targetControllerName":@"TJSettingChangePasswordVC"},
                             @{@"title":@"更改绑定手机", @"targetControllerName":@"TJSettingChangePhoneVC"}]];
    self.dataSource = @[[TJSettingMainModel mj_objectArrayWithKeyValuesArray:dataArray.firstObject], [TJSettingMainModel mj_objectArrayWithKeyValuesArray:dataArray[1]]].mutableCopy;
    
}
@end

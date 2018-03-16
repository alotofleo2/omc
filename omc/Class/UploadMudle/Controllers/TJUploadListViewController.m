//
//  TJUploadListViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListViewController.h"
#import "TJUploadListHeaderView.h"
#import "TJUploadListModel.h"
#import "TJUploadListCell.h"
#import "TJUploadTask.h"
#import "MJExtension.h"

@interface TJUploadListViewController ()
@property (nonatomic, strong) TJUploadListHeaderView *headerView;

//1已上传 2未通过
@property (nonatomic, assign) NSInteger currentType;
@end

@implementation TJUploadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClassName:@"TJUploadListCell" reuseIdentifier:@"TJUploadListCell"];
    
    self.headerView = [[TJUploadListHeaderView alloc]init];
    BLOCK_WEAK_SELF
    self.headerView.buttonPressedHandle = ^(NSInteger index) {[weakSelf topViewButtonPressedWithIndex:index];};
    [self.view addSubview: self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(TJSystem2Xphone6Height(95)));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    self.userPullToRefreshEnable = YES;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.currentType = 1;
    
    if (![TJTokenManager sharedInstance].isLogin) {
        
        NSDictionary * params = @{@"closeButtonEnable" : @(1)};
        [[TJPageManager sharedInstance] presentViewControllerWithName:@"TJLoginViewController" params:params inNavigationController:YES animated:YES];
    }
}


- (void)requestTableViewDataSource {

    [self cancelTask];
    BLOCK_WEAK_SELF
    //fasle 已上传 其他未通过
    TJRequest *request = [TJUploadTask getUploadListWithType:self.currentType == 1 ? @"fasle" : @"true" successBlock:^(TJResult *result) {
        
        weakSelf.dataSource = [TJUploadListModel mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.tableView reloadData];
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
    } failureBlock:^(TJResult *result) {
        
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
        [self showToastWithString:result.message];
    }];
    [self.taskArray addObject:request];
}
#pragma mark - UITableViewDelegate UITableViewDateSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJUploadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadListCell" forIndexPath:indexPath];
    
    [cell setupViewWithModel:self.dataSource[indexPath.section]];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return TJSystem2Xphone6Height(26);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}
#pragma mark - 点击事件
- (void)topViewButtonPressedWithIndex:(NSInteger)index {
    self.currentType = index;
    
    [self requestTableViewDataSource];
}
@end

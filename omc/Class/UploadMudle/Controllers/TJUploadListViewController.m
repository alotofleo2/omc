//
//  TJUploadListViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListViewController.h"
#import "TJUploadListHeaderView.h"
#import "TJUploadListFailCell.h"
#import "TJUploadListModel.h"
#import "TJUploadListCell.h"
#import "TJUploadTask.h"
#import "MJExtension.h"

@interface TJUploadListViewController ()
@property (nonatomic, strong) TJUploadListHeaderView *headerView;

//0待审核 1已上传 2未通过
@property (nonatomic, assign) NSInteger currentType;
@end

@implementation TJUploadListViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogout) name:TJLogoutNotificationName object:nil];
    
    [self registerCellWithClassName:@"TJUploadListCell" reuseIdentifier:@"TJUploadListCell"];
    [self registerCellWithClassName:@"TJUploadListFailCell" reuseIdentifier:@"TJUploadListFailCell"];
    
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
    self.needReloadData = NO;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.rightImageName = @"upload_upload";
    
    //设置当前选中的类型(已上传或者未通过)
    self.currentType = 0;
    [self requestTableViewDataSource];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkLogin];
}

- (void)requestTableViewDataSource {
    [super requestTableViewDataSource];
    [self getDataSourceWithPageNumber:0];
}

- (void)getDataSourceWithPageNumber:(NSInteger)pageNumber {
    [self cancelTask];
    BLOCK_WEAK_SELF
    
    TJRequest *request = [TJUploadTask getUploadListWithType:@(self.currentType).stringValue pageNumber:pageNumber successBlock:^(TJResult *result) {
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
        if (result.pageInfo) {
            [self setupPageInfoWithDictionary:result.pageInfo];
            
            self.userPullDownToLoadMoreEnable = self.pageInfo.currentPage < self.pageInfo.pageCount;
            if (self.pageInfo.currentPage == 1) {
                
                weakSelf.dataSource = [TJUploadListModel mj_objectArrayWithKeyValuesArray:result.data];
            } else {
                
                [weakSelf.dataSource addObjectsFromArray:[TJUploadListModel mj_objectArrayWithKeyValuesArray:result.data]];
            
            }
            
        } else {
            weakSelf.dataSource = [TJUploadListModel mj_objectArrayWithKeyValuesArray:result.data];
        }
        [weakSelf.tableView reloadData];

    } failureBlock:^(TJResult *result) {
        
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
        [self showToastWithString:result.message];
    }];
    [self.taskArray addObject:request];
}
- (void)requestLoadMore {
    [self getDataSourceWithPageNumber:self.pageInfo.currentPage + 1];
}
#pragma mark - UITableViewDelegate UITableViewDateSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJUploadListModel *model = self.dataSource[indexPath.section];
    
    if ([model.status isEqualToString:@"未通过"]) {
        
        TJUploadListFailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadListFailCell" forIndexPath:indexPath];
        cell.reuploadHandle = ^(TJUploadListModel *CellModel) {[self reUpLoadWithModel:CellModel];};
        cell.deleteHandle   = ^(TJUploadListModel *CellModel) {[self deleteWithModel:CellModel];};
        [cell setupViewWithModel:model];
        return cell;
    } else {

        
        TJUploadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadListCell" forIndexPath:indexPath];
        [cell setupViewWithModel:model];
        return cell;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 0.1 : TJSystem2Xphone6Height(26);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}
#pragma mark - 点击事件
#pragma mark type点击事件
- (void)topViewButtonPressedWithIndex:(NSInteger)index {
    self.currentType = index;
    
    [self requestTableViewDataSource];
}

#pragma mark 上传按钮点击
- (void)rigthButtonPressed {
    NSDictionary *params = nil;
    [[TJPageManager sharedInstance] pushViewControllerWithName:@"TJUploadViewController" params:params];
}

#pragma mark 重新上传按钮
- (void)reUpLoadWithModel:(TJUploadListModel *)model {
    [self rigthButtonPressed];
}

#pragma mark 删除按钮
- (void)deleteWithModel:(TJUploadListModel *)model {
    
    [TJProgressHUD showWithTitle:@"删除中..."];
    TJRequest *request = [TJUploadTask deleteUploadListItemWithBuyrsShowId:model.buyersShowId successBlock:^(TJResult *result) {
        [TJProgressHUD dismiss];
        [self showToastWithString:@"删除成功"];
        [self.dataSource removeObject:model];
        [self.tableView reloadData];
        
    } failureBlock:^(TJResult *result) {
        
        [TJProgressHUD dismiss];
        [TJAlertUtil toastWithString:result.message];
    }];
    [self.taskArray addObject:request];

}


#pragma mark 退出登录通知
- (void)didLogout {
    [self checkLogin];
}

- (void)checkLogin {
    BLOCK_WEAK_SELF
    if (![TJTokenManager sharedInstance].isLogin) {
        self.needReloadData = YES;
        void(^backBlock)(void)  = ^{
            UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [tabbarVC setSelectedIndex:0];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        };
        NSDictionary * params = @{@"backBlock" : backBlock};
        
        [[TJPageManager sharedInstance] presentViewControllerWithName:@"TJLoginViewController" params:params inNavigationController:YES animated:YES];
    }
}
@end

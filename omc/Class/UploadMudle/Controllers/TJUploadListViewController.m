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
@end

@implementation TJUploadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClassName:@"TJUploadListCell" reuseIdentifier:@"TJUploadListCell"];
    
    self.headerView = [[TJUploadListHeaderView alloc]init];
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
}


- (void)requestTableViewDataSource {
    [self cancelTask];
    BLOCK_WEAK_SELF
    TJRequest *request = [TJUploadTask getUploadListWithType:@"fasle" successBlock:^(TJResult *result) {
        NSLog(@"%@", result.data);
        weakSelf.dataSource = [TJUploadListModel mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.tableView reloadData];
    } failureBlock:^(TJResult *result) {
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
@end

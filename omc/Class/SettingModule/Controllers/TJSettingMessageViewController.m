//
//  TJSettingMessageViewController.m
//  omc
//
//  Created by 方焘 on 2018/4/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMessageViewController.h"
#import "TJSettingMessageModel.h"
#import "TJSettingTask.h"

@interface TJSettingMessageViewController (){
    /**
     *  没有消息的背景图和文字
     */
    UIImageView *_backImgView;
    UILabel *_detailLabel;
}

@end

@implementation TJSettingMessageViewController

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.userPullToRefreshEnable = YES;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    _backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"messageCenter_backImage"]];
    _backImgView.hidden = YES;
    _backImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_backImgView];
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-80);
        make.centerX.offset(0);
        make.width.offset(DEVICE_SCREEN_WIDTH*0.61);
        make.height.equalTo(@((DEVICE_SCREEN_WIDTH - 80)*563/680));
        
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.hidden = YES;
    [self.view addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImgView.mas_left);
        make.right.equalTo(_backImgView.mas_right);
        make.height.offset(50);
        make.top.equalTo(_backImgView.mas_bottom);
    }];
    _detailLabel.text = @"暂时还没有消息";
    _detailLabel.textColor = [UIColor lightGrayColor];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)setupTableView {
    [super setupTableView];
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self registerCellWithClassName:@"TJSettingMessageCell" reuseIdentifier:@"TJSettingMessageCell"];
}

#pragma mark - UITableViewDelegate UITableViewDateSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJSettingMessageCell" forIndexPath:indexPath];
    
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
    
    return TJSystem2Xphone6Height(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//设置tableView headerView颜色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor = UIColorFromRGB(0xf4f4f4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestTableViewDataSource {

    [self getMessageWithPageNumber:0];
}
- (void)requestLoadMore {
    if (self.pageInfo.currentPage < self.pageInfo.pageCount) {
        
        [self getMessageWithPageNumber:self.pageInfo.currentPage + 1];
    }
}

- (void)getMessageWithPageNumber:(NSUInteger)pageNumber {
    [self cancelTask];
    
    TJRequest *request = [TJSettingTask getMessageWithPageNumber:pageNumber SuccessBlock:^(TJResult *result) {
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
        if (result.pageInfo) {
            [self setupPageInfoWithDictionary:result.pageInfo];
            self.userPullDownToLoadMoreEnable = self.pageInfo.currentPage < self.pageInfo.pageCount;
            
            if ([result.data isKindOfClass:[NSArray class]]) {
                //如果是第一页 就重置 否则就添加
                if (self.pageInfo.currentPage == 1) {
                    
                    self.dataSource = [TJSettingMessageModel mj_objectArrayWithKeyValuesArray:result.data];
                } else {
                    
                    [self.dataSource addObjectsFromArray: [TJSettingMessageModel mj_objectArrayWithKeyValuesArray:result.data]];
                }
                
                [self.tableView reloadData];
            }
        }
        
        [self requestTableViewDataSourceSuccess:self.dataSource];
        
    } failureBlock:^(TJResult *result) {
        
        [self showToastWithString:result.message];
    }];
    
    [self.taskArray addObject:request];
}
@end

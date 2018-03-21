//
//  TJHomeViewController.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeViewController.h"
#import "TJHomeTopBannerCell.h"
#import "TJHomeCategoryCell.h"
#import "TJHomeDateManager.h"
#import "TJHomeMiddleContentCell.h"
#import "TJPersonalView.h"
#import "TJSearchManager.h"
#import "TJCurtainEditManager.h"


@interface TJHomeViewController () 
@property (nonatomic, strong) UIButton *backToTopButton;
@end

@implementation TJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self setupNavigation];
    [self registerCellWithClassName:@"TJHomeTopBannerCell" reuseIdentifier:@"TJHomeTopBannerCell"];
    [self registerCellWithClassName:@"TJHomeCategoryCell" reuseIdentifier:@"TJHomeCategoryCell"];
    [self registerCellWithClassName:@"TJHomeMiddleContentCell" reuseIdentifier:@"TJHomeMiddleContentCell"];
    
    [[TJSearchManager sharedInstance] updateHotSearch];
}
- (void)setupNavigation {
    self.navigationItem.title = @"欧曼辰";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //消除阴影
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    UIButton *leftButton = [TJButton buttonWithType:UIButtonTypeCustom];
    self.leftButton = leftButton;
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, TJSystem2Xphone6Width(20));
    [leftButton setImage:[UIImage imageNamed:@"home_mine"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, TJSystem2Xphone6Width(60), TJSystem2Xphone6Width(43));
    leftButton.titleLabel.font = [UIFont systemFontOfSize:40 / 3];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftitem;
    
    UIButton *rightfirstButton = [TJButton buttonWithType:UIButtonTypeCustom];
    [rightfirstButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    rightfirstButton.frame = CGRectMake(0, 0, TJSystem2Xphone6Width(44), TJSystem2Xphone6Width(60));
    rightfirstButton.titleLabel.font = [UIFont systemFontOfSize:40 / 3];
    [rightfirstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightfirstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightfirstButton addTarget:self action:@selector(rightfirstButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *firstitem = [[UIBarButtonItem alloc] initWithCustomView:rightfirstButton];
    
    
    UIButton *rightSecendButton = [TJButton buttonWithType:UIButtonTypeCustom];
    [rightSecendButton setImage:[UIImage imageNamed:@"home_camera"] forState:UIControlStateNormal];
    rightSecendButton.frame = CGRectMake(0, 0, TJSystem2Xphone6Width(55), TJSystem2Xphone6Width(60));
    rightSecendButton.titleLabel.font = [UIFont systemFontOfSize:40 / 3];
    [rightSecendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightSecendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightSecendButton addTarget:self action:@selector(rightSecendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *secendItem = [[UIBarButtonItem alloc] initWithCustomView:rightSecendButton];
    
    self.navigationItem.rightBarButtonItems = @[secendItem, firstitem];
    
    self.backToTopButton = [TJButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.backToTopButton];
    [self.backToTopButton addTarget:self action:@selector(backtoTopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.backToTopButton setImage:[UIImage imageNamed:@"home_backToTop"] forState:UIControlStateNormal];
    
    [self.backToTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-TJSystem2Xphone6Width(38));
        make.bottom.mas_offset(-TJSystem2Xphone6Height(150));
        make.width.height.equalTo(@(TJSystem2Xphone6Width(94)));
    }];
    
}
- (void)requestTableViewDataSource {
    BLOCK_WEAK_SELF
    [[TJHomeDateManager sharedInstance]requestHomeWithCompleteHandle:^{
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        BLOCK_STRONG_SELF
        //窗帘内容请求
        NSInteger categoryNumb = [TJHomeDateManager sharedInstance].curtainCategoryModel.categoryModels[1].productCateId;
        [[TJHomeDateManager sharedInstance] requestCurtainContentWithCategoryNumb:categoryNumb completeHandle:^{
            
            [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        //窗头内容请求
        NSInteger headCategoryNumb = [TJHomeDateManager sharedInstance].curtainHeadCategoryModel.categoryModels[1].productCateId;
        [[TJHomeDateManager sharedInstance] requestCurtainHeadContentWithCategoryNumb:headCategoryNumb completeHandle:^{
            
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    

}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTopBannerCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].bannerModels];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeCategoryCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainCategoryModel];
            
            TJHomeCategoryCell * categoryCell = (TJHomeCategoryCell *)cell;
            BLOCK_WEAK_SELF
            categoryCell.itemActionHandle = ^(NSInteger index){
                [weakSelf curtainCategoryActionWithIndex:index];
            };
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeMiddleContentCell" forIndexPath:indexPath];

            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainContentModel];
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeCategoryCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainHeadCategoryModel];
            
            TJHomeCategoryCell * categoryCell = (TJHomeCategoryCell *)cell;
            BLOCK_WEAK_SELF
            categoryCell.itemActionHandle = ^(NSInteger index){
                [weakSelf curtainHeadCategoryActionWithIndex:index];
            };
        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeMiddleContentCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainHeadContentModel];
        }
            break;
            
        default:
            break;
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heigt = 0.0;
    switch (indexPath.row) {
        case 0:
            heigt = TJSystem2Xphone6Height(250);
            break;
            
        case 1:
            heigt = DEVICE_SCREEN_WIDTH / 4 + TJSystem2Xphone6Height(103) + 2;
            break;
        case 2:
            heigt = [TJHomeDateManager sharedInstance].curtainContentModel.rowHeight;
            break;
        case 3:
            heigt = DEVICE_SCREEN_WIDTH / 4 + TJSystem2Xphone6Height(103) + 2;
            break;
        case 4:
            heigt = [TJHomeDateManager sharedInstance].curtainHeadContentModel.rowHeight;
            break;
            
    }
    return heigt;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}
#pragma mark - 点击事件
#pragma mark 窗帘分类item点击事件
- (void)curtainCategoryActionWithIndex:(NSInteger)index {
    //第一个查看全部 就push
    if (index == 0) {
        [[TJPageManager sharedInstance] pushViewControllerWithName:@""];
        return ;
    }
    BLOCK_WEAK_SELF
    //如果不是第一个请求数据
    NSInteger categoryNumb = [TJHomeDateManager sharedInstance].curtainCategoryModel.categoryModels[index].productCateId;
    [[TJHomeDateManager sharedInstance] requestCurtainContentWithCategoryNumb:categoryNumb completeHandle:^{
        BLOCK_STRONG_SELF
       [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
#pragma mark 窗头分类item点击事件
- (void)curtainHeadCategoryActionWithIndex:(NSInteger)index {
    //第一个查看全部 就push
    if (index == 0) {
        [[TJPageManager sharedInstance] pushViewControllerWithName:@""];
        return ;
    }
    
    
    //如果不是第一个请求数据
    NSInteger categoryNumb = [TJHomeDateManager sharedInstance].curtainHeadCategoryModel.categoryModels[index].productCateId;
    [[TJHomeDateManager sharedInstance] requestCurtainHeadContentWithCategoryNumb:categoryNumb completeHandle:^{
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark 左边第一个点击事件 搜索
- (void)rightfirstButtonPressed {
    
}

#pragma mark 左边第二个点击事件 照片编辑
- (void)rightSecendButtonPressed {
    
    [[TJCurtainEditManager sharedInstance] startEdit];
}

#pragma mark 左边navigation 点击事件
- (void)leftButtonPressed {


    [[TJPageManager sharedInstance] pushViewControllerWithName:@"TJSettingMainVC"];

}

#pragma mark 返回顶部按钮点击
- (void)backtoTopButtonPressed {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end

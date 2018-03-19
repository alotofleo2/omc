//
//  TJCategoryViewContoller.m
//  omc
//
//  Created by 方焘 on 2018/3/9.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryViewContoller.h"
#import "TJCategoryProductModel.h"
#import "TJCategoryProductCell.h"
#import "TJCategoryListModel.h"
#import "TJCategoryListCell.h"
#import "TJCategoryTask.h"

#define kCategoryMargin TJSystem2Xphone6Width(18)

@interface TJCategoryViewContoller () <UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UISearchBar *mySearchBar;

@property (nonatomic, strong)UITableView *categoryListTableView;

@property (nonatomic, strong)NSMutableArray<TJCategoryListModel *> *categoryListDataSource;
@end

@implementation TJCategoryViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initMysearchBarAndMysearchDisPlay];
}
- (void)setupTableView {
    [super setupTableView];
    
    self.categoryListTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.categoryListTableView.delegate = self;
    self.categoryListTableView.dataSource = self;
    self.categoryListTableView.tableFooterView = [[UIView alloc]init];
    self.categoryListTableView.backgroundColor = [UIColor clearColor];
    self.categoryListTableView.separatorColor  = TJTABLEVIEW_SEPERATE_COLOR;
    if ([self.categoryListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.categoryListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.categoryListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.categoryListTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.categoryListTableView registerClass:[TJCategoryListCell class] forCellReuseIdentifier:@"TJCategoryListCell"];
    [self.view addSubview:self.categoryListTableView];
    
    [self.categoryListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_offset(kCategoryMargin);
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(@(TJSystem2Xphone6Width(240)));
    }];
    
    
    //========================tableView
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.view);
        make.top.mas_offset(kCategoryMargin);
        make.left.equalTo(self.categoryListTableView.mas_right).mas_offset(kCategoryMargin);
        make.right.mas_offset(- kCategoryMargin);
    }];
    
    self.userPullToRefreshEnable = YES;
    [self registerCellWithClassName:@"TJCategoryProductCell" reuseIdentifier:@"TJCategoryProductCell"];
}

- (void)requestTableViewDataSource {
    //首次加载
    if (!_categoryListDataSource) {
        [self cancelTask];
        
        TJRequest *request = [TJCategoryTask getCategoryListWithSuccessBlock:^(TJResult *result) {
            
            if (result.errcode == 200) {
                self.categoryListDataSource = [TJCategoryListModel mj_objectArrayWithKeyValuesArray:result.data];
                //设置全部选中
                self.categoryListDataSource.firstObject.cates.firstObject.selected = YES;
                //设置窗帘打开
                self.categoryListDataSource.firstObject.listOpen = YES;
                [self.categoryListTableView reloadData];
                
                [self getCategoryContentDataSourceWithCateId:self.categoryListDataSource.firstObject.cates.firstObject.cateId keyWords:nil];

            }
        } failureBlock:^(TJResult *result) {
            
            [self showToastWithString:result.message];
        }];
        
        [self.taskArray addObject:request];
        
        //下拉刷新
    } else {
        //设置查询选中
        TJCategoryListCateModel *model = nil;
        for (NSInteger i = 0; i < self.categoryListDataSource.count; i++) {
            for (NSInteger j = 0; j< self.categoryListDataSource[i].cates.count; j++) {
                if (self.categoryListDataSource[i].cates[j].isSelected == YES) {
                    model = self.categoryListDataSource[i].cates[j];
                }
            }
        }
        [self getCategoryContentDataSourceWithCateId:model.cateId keyWords:nil];
    }
}
#pragma mark 获取产品的请求接口
- (void)getCategoryContentDataSourceWithCateId:(NSString *)cateId keyWords:(NSString *)keyWords {
    [self cancelTask];
    BLOCK_WEAK_SELF
    TJRequest *request = [TJCategoryTask getCategoryContentWithCateId:cateId keywords:keyWords successBlock:^(TJResult *result) {
        if (result.errcode == 200) {
            
            weakSelf.dataSource = [TJCategoryProductModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf.tableView reloadData];
            
            [self requestTableViewDataSourceSuccess:@[@(1)]];
        }
    } failureBlock:^(TJResult *result) {
        [self showToastWithString:result.message];
    }];
    
    [self.taskArray addObject:request];
    

}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.categoryListTableView) {
        
        return self.categoryListDataSource.count;
    } else {
        return self.dataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryListTableView) {
        TJCategoryListModel *model = self.categoryListDataSource[section];
        return model.isListOpen ? model.cates.count : 0;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryListTableView) {
        TJCategoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJCategoryListCell" forIndexPath:indexPath];
        TJCategoryListCateModel *model = self.categoryListDataSource[indexPath.section].cates[indexPath.row];
        [cell setupViewWithModel:model];
        if (model.isSelected) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        
        return cell;
    } else {
        TJCategoryProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJCategoryProductCell" forIndexPath:indexPath];
        
        [cell setupViewWithModel:self.dataSource[indexPath.section]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryListTableView) {
        
        return TJSystem2Xphone6Height(90);
        
    } else {
        
        return TJSystem2Xphone6Height(170);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.categoryListTableView) {
        return TJSystem2Xphone6Height(90);
    } else {
        return TJSystem2Xphone6Height(20);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryListTableView) {
        //设置是否已选中
        for (NSInteger i = 0; i < self.categoryListDataSource.count; i++) {
            for (NSInteger j = 0; j< self.categoryListDataSource[i].cates.count; j++) {
                if (i == indexPath.section && j == indexPath.row) {
                    [self.categoryListDataSource[i].cates[j] setSelected:YES];
                } else {
                    [self.categoryListDataSource[i].cates[j] setSelected:NO];
                }
            }
        }
        [self getCategoryContentDataSourceWithCateId:self.categoryListDataSource[indexPath.section].cates[indexPath.row].cateId
                                            keyWords:nil];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //product的
    if (tableView != self.categoryListTableView) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = self.view.backgroundColor;
        return view;
    }
    //分类的
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.tag = 100 + section;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewPressed:)];
    [headerView addGestureRecognizer:gesture];
    //添加title
    UILabel *title = [[UILabel alloc]init];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:17 * [TJAdaptiveManager adaptiveScale]];
    title.text = self.categoryListDataSource[section].parentCateName;
    [headerView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
    }];
    
    //添加line
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = UIColorFromRGB(0xf2f2f5);
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(headerView);
        make.height.equalTo(@(0.8));
    }];
    return headerView;
}
#pragma mark 点击事件
- (void)headerViewPressed:(UITapGestureRecognizer *)recognizer {
    
    NSInteger section = recognizer.view.tag - 100;
    TJCategoryListModel *model = self.categoryListDataSource[section];
    model.listOpen = !model.isListOpen;
    
    [self.categoryListTableView reloadData];
}

//-(void)initMysearchBarAndMysearchDisPlay
//
//{
//
//    self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, DEVICE_STATUSBAR_HEIGHT, DEVICE_SCREEN_WIDTH, 44)];
//
//    self.mySearchBar.delegate = self;
//
//    //设置选项
//
//    self.mySearchBar.barTintColor = [UIColor redColor];
//
//    self.mySearchBar.searchBarStyle = UISearchBarStyleDefault;
//
//    self.mySearchBar.translucent = NO; //是否半透明
//
//    [self.mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//
//    [self.mySearchBar sizeToFit];
//
//
//
//   UISearchDisplayController *  mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.mySearchBar contentsController:self];
//
//    mySearchDisplayController.delegate = self;
//
//    mySearchDisplayController.searchResultsDataSource = self;
//
//    mySearchDisplayController.searchResultsDelegate = self;
//
//    mySearchDisplayController.displaysSearchBarInNavigationBar = YES;
//
////    suggestResults = [NSMutableArray arrayWithArray:@[@"此处为推荐词", @"也可以为历史记录"]];
//
//
//
//}




@end

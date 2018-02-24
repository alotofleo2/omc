//
//  TJBaseTableViewController.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseViewController.h"
#import "TJBaseTableViewCell.h"

@protocol TJBaseTableViewControllerDelegate <NSObject>

@optional

/**
 *  通知回调对象tableView发生滚动
 *
 *  @param tableView 当前操作的tableView
 */
- (void)updateTableViewOffset:(UITableView *)tableView;


/**
 *  通知回调对象tablView结束滚动
 *
 *  @param tableView 当前操作的tableView
 */
- (void)tableViewDidEndScroll:(UITableView *)tableView;


/**
 *  设置tableView的headerView
 *
 *  @return headerView
 */
- (UIView *)tableHeaderView;


/**
 *  设置tableView最小的内容高度
 *
 *  @return 内容高度
 */
- (CGFloat)minContentSizeHeight;


- (void)tableViewWillRequestDateSource;


/**
 *  通知回调对象网络请求结束
 *
 *  @param tableView 当前操作的tableView
 */
- (void)requestTableViewDataSourceFinished:(UITableView *)tableView;


@end


@interface TJBaseTableViewController : TJBaseViewController <UITableViewDataSource, UITableViewDelegate>

/**
 *  回调对象
 */
@property (nonatomic, weak) id<TJBaseTableViewControllerDelegate> delegate;


/**
 *  列表界面
 */
@property (nonatomic, strong) UITableView * tableView;


/**
 *  列表的显示风格
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;


/**
 *  是否开启下拉刷新功能，MJreFresh
 */
@property (nonatomic, assign) BOOL userPullToRefreshEnable;

/**
 *  是否开启上啦加载更多
 */
@property (nonatomic, assign) BOOL userPullDownToLoadMoreEnable;

/**
 *  是否支持滚动到顶部
 */
@property (nonatomic, assign) BOOL scrollToTopEnable;


/**
 *  默认的cell重用标示符
 */
@property (nonatomic, strong) NSString * defaultCellReuseIdentifier;


/**
 *  列表数据源
 */
@property (nonatomic, strong) NSMutableArray * dataSource;


/**
 *  是否需要刷新当前页面的数据,请求完数据后因该赋值为NO
 */
@property (nonatomic, assign) BOOL needReloadData;



/**
 *  配置tableView
 */
- (void)setupTableView;

/**
 *  上啦加载更多的方法
 */
- (void)requestLoadMore;


/**
 *  通过nib文件名称注册cell
 *
 *  @param nibName    nib文件的名称
 *  @param identifier 重用标示符
 */
- (void)registerCellWithNibName:(NSString *)nibName reuseIdentifier:(NSString *)identifier;


/**
 *  通过类名注册cell
 *
 *  @param className  类名
 *  @param identifier 重用标示符
 */
- (void)registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)identifier;


/**
 *  scrollView内容移动到顶层
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToTop:(BOOL)animated;


/**
 *  scrollView内容移动到底层
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToBottom:(BOOL)animated;

@end

//
//  TJBaseTableViewController.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseTableViewController.h"
#import "MJRefreshAutoGifFooter.h"


@interface TJBaseTableViewController ()
@property (nonatomic, weak) MJRefreshGifHeader *MJheader;

@property (nonatomic, weak) MJRefreshAutoGifFooter *MJFooter;
@end

@implementation TJBaseTableViewController

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.scrollToTopEnable = YES;
        self.needReloadData = YES;
        
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.scrollToTopEnable = YES;
        self.needReloadData = YES;
    }
    
    return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.scrollToTopEnable = YES;
        self.needReloadData = YES;
    }
    
    return self;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }

    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    // 去除最后的分割钱 plain
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor  = TJTABLEVIEW_SEPERATE_COLOR;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.needReloadData) {
        if ([self respondsToSelector:@selector(requestTableViewDataSource)]) {
            [self requestTableViewDataSource];
        }
    }
}

#pragma mark - Getter

- (MJRefreshGifHeader *)MJheader {
    if (!_MJheader) {
        BLOCK_WEAK_SELF
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakSelf requestTableViewDataSource];
        }];
//        NSArray *animationImages = @[
//                                     [UIImage imageNamed:@"dropdown_loading_01"],
//                                     [UIImage imageNamed:@"dropdown_loading_02"],
//                                     [UIImage imageNamed:@"dropdown_loading_03"],
//                                     [UIImage imageNamed:@"dropdown_loading_04"],
//                                     [UIImage imageNamed:@"dropdown_loading_05"],
//                                     [UIImage imageNamed:@"dropdown_loading_06"],
//                                     [UIImage imageNamed:@"dropdown_loading_07"],
//                                     [UIImage imageNamed:@"dropdown_loading_08"],
//                                     ];
//
//        NSArray *normalAnimationImages = @[
//                                     [UIImage imageNamed:@"dropdown_loading_00"],
//
//                                     ];
//        //设置动画图片
//        [header setImages:normalAnimationImages forState:MJRefreshStateIdle];
//        [header setImages:animationImages forState:MJRefreshStatePulling];
//        [header setImages:animationImages forState:MJRefreshStateRefreshing];
        
        //设置状态文字
        [header setTitle:@"下拉更新..." forState:MJRefreshStateIdle];
        [header setTitle:@"松手更新..." forState:MJRefreshStatePulling];
        [header setTitle:@"更新中....." forState:MJRefreshStateRefreshing];
        
        //设置文字
        header.stateLabel.font = TJSystemFont15;
        header.stateLabel.hidden = NO;
        
        //隐藏时间栏
        header.lastUpdatedTimeLabel.hidden = YES;
        
        
        self.tableView.mj_header = header;
    }
    return _MJheader;
}

- (MJRefreshAutoGifFooter *)MJFooter {
    
    if (!_MJFooter) {
        BLOCK_WEAK_SELF
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            [weakSelf requestLoadMore];
        }];
        
        NSArray *animationImages = @[
                                     [UIImage imageNamed:@"dropdown_loading_01"],
                                     [UIImage imageNamed:@"dropdown_loading_02"],
                                     [UIImage imageNamed:@"dropdown_loading_03"],
                                     ];
        //设置动画图片
        [footer setImages:animationImages forState:MJRefreshStateIdle];
        [footer setImages:animationImages forState:MJRefreshStatePulling];
        [footer setImages:animationImages forState:MJRefreshStateRefreshing];
        
        [footer setTitle:@"上啦加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载更多..." forState:MJRefreshStateRefreshing];
        
        self.tableView.mj_footer = footer;
    }
    return _MJFooter;
}

#pragma mark - 下拉刷新
- (void)setUserPullToRefreshEnable:(BOOL)userPullToRefreshEnable {
    
    _userPullToRefreshEnable = userPullToRefreshEnable;
    
    if (_userPullToRefreshEnable) {
        [self MJheader];
    } else {
        if (self.tableView.mj_header) {
            [self.tableView.mj_header removeFromSuperview];
        }
    }
    
}

#pragma mark -上拉刷新
- (void)setUserPullDownToLoadMoreEnable:(BOOL)userPullDownToLoadMoreEnable {
    
    _userPullDownToLoadMoreEnable = userPullDownToLoadMoreEnable;
    
    if (_userPullDownToLoadMoreEnable) {
        
        [self MJFooter];
        
    } else {
        
        if (self.tableView.mj_footer) {
            [self.tableView.mj_footer removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public
#pragma mark 配置tableView
- (void)setupTableView {
    
    self.tableView.sectionFooterHeight = 20;
    
    // 注册默认的cell
    [self registerCellWithClassName:NSClassToString(TJBaseTableViewCell) reuseIdentifier:NSClassToString(TJBaseTableViewCell)];
}



#pragma mark 列表数据源懒加载
- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}


#pragma mark 通过nib文件名称注册cell
- (void)registerCellWithNibName:(NSString *)nibName reuseIdentifier:(NSString *)identifier {
    
    UINib * nib = [UINib nibWithNibName:nibName bundle:nil];
    
    if (!nib) {
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}


#pragma mark 通过类名注册cell
- (void)registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)identifier {
    
    Class class = NSClassFromString(className);
    
    if (!class) {
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
}


#pragma mark scrollView内容移动到顶层
- (void)scrollToTop:(BOOL)animated {
    
    if (!self.scrollToTopEnable)
        return;
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}


#pragma mark scrollView内容移动到底层
- (void)scrollToBottom:(BOOL)animated {
    
    if (self.tableView.contentSize.height < self.tableView.frame.size.height)
        return;
    
    NSUInteger sectionCount = [self.tableView numberOfSections];
    
    if (sectionCount)
    {
        NSUInteger rowCount = [self.tableView numberOfRowsInSection:0];
        
        if (rowCount)
        {
            NSUInteger i[2] = {0, rowCount - 1};
            NSIndexPath * indexPath = [NSIndexPath indexPathWithIndexes:i length:2];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    }
}


#pragma mark 请求列表数据（需重写）
- (void)requestTableViewDataSource {
//    [super requestTableViewDataSource];
    _needReloadData = NO;
    if ([self.delegate respondsToSelector:@selector(tableViewWillRequestDateSource)]) {
        
        [self.delegate tableViewWillRequestDateSource];
    }
}
#pragma mark 请求成功的方法
- (void)requestTableViewDataSourceSuccess:(NSArray *)dataSource;
{   [super requestTableViewDataSourceSuccess:dataSource];
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    } else if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)requestTableViewDataSourceFailure;
{
    [self requestTableViewDataSourceFailureWithResult:nil];
}

- (void)requestTableViewDataSourceFailureWithResult:(TJResult *)result {
    [super requestTableViewDataSourceFailureWithResult:result];
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    } else if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark 上啦加载更多 (需重写)
- (void)requestLoadMore {
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    
    TJBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.defaultCellReuseIdentifier];
    
    if ([self.dataSource count] > row) {
        
        id model = [self.dataSource objectAtIndex:row];
        [cell setupViewWithModel:model];
        
    }
    
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    
//    
//    if (self.userPullToRefreshEnable) {
//        
//        CGFloat contentOffsetY = scrollView.contentOffset.y;
//        
//        if (self.pullToRefreshView && contentOffsetY <= -self.pullToRefreshView.height) {
//            
//            if (!decelerate) {
//                
//                [self requestTableViewDataSource];
//                
//            } else {
//                
//                self.needReloadData = YES;
//            }
//        }
//    }
//    
//    
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    if (self.userPullToRefreshEnable && self.needReloadData) {
//        
//        [self requestTableViewDataSource];
//        
//        if ([self.delegate respondsToSelector:@selector(tableViewWillRequestDateSource)]) {
//            
//            [self.delegate tableViewWillRequestDateSource];
//        }
//    }
//}

@end

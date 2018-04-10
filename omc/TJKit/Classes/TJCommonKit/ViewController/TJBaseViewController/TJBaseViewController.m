//
//  TJBaseViewController.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseViewController.h"
#import "UIButton+WebCache.h"
#import "UIView+Toast.h"

@interface TJBaseViewController ()
@property (nonatomic, assign) BOOL isInitData;

- (void)addNavBackButtonWithDefaultAction;
@end

@implementation TJBaseViewController
#pragma mark - LifeCycle
- (void)dealloc {
    
    NSLog(@"%@ Dealloc", NSStringFromClass([self class]));
    
    
    [self cancelTask];
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self initData];
    }
    
    return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        [self initData];
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if ([self.navigationController.childViewControllers count] > 1) {
        
        [self addNavBackButtonWithDefaultAction];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self setupSubviews];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.pageManagerEnable && self.navigationController) {
        
        [TJPageManager sharedInstance].currentViewController = self;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle animated:NO];
    
    if (self.navigationBarHidden) {
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}
#pragma clang diagnostic pop

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self cancelTask];
    
     [self.view endEditing:YES];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.statusBarStyle;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}


#pragma mark - Setter
- (void)setNeedRefreshUI:(BOOL)needRefreshUI {
    
    _needRefreshUI = needRefreshUI;
    
    if (_needRefreshUI) {
        
        [self refreshUI];
    }
    
}


#pragma mark 设置返回按钮标题
- (void)setBackButtonTitle:(NSString *)title {
    
    [self.backButton setTitle:title forState:UIControlStateNormal];
}


#pragma mark 设置返回按钮背景颜色
- (void)setBackButtonBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    
    [self.backButton setBackgroundImage:[UIImage backButtonImageWithColor:color barMetrics:UIBarMetricsDefault cornerRadius:0.f] forState:state];
}



- (void)setLeftTitle:(NSString *)leftTitle{
    
    _leftTitle = leftTitle;
    
    [self.leftButton setTitle:_leftTitle forState:UIControlStateNormal];
    
}

#pragma mark 设置右侧按钮显示的标题
-(void)setRightTitle:(NSString *)rightTitle{
    
    _rightTitle = rightTitle;
    [self.rightButton setTitle:_rightTitle forState:UIControlStateNormal];
}

#pragma mark 设置左侧图片按钮
-(void)setLeftImageName:(NSString *)leftImageName corner:(BOOL)corner{
    
    _leftImageName  =leftImageName;
    
    self.leftButton.frame = CGRectMake(0, 0, 30, 30);
    self.leftButton.clipsToBounds = YES;
    self.leftButton.layer.cornerRadius = 15;
    
    [self.leftButton setImage:[UIImage imageNamed:_leftImageName] forState:UIControlStateNormal];
    
    if ([leftImageName hasPrefix:@"http"]) {
        
        [self.leftButton sd_setImageWithURL:[NSURL URLWithString:leftImageName] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"return"]];
    }
    
    if (leftImageName.length ==0||[leftImageName isKindOfClass:[NSNull class]]) {
        
        [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
}


#pragma mark 右侧按钮显示的图片名称
- (void)setRightImageName:(NSString *)rightImageName {
    
    _rightImageName = rightImageName;
    [self.rightButton setImage:[UIImage imageNamed:_rightImageName] forState:UIControlStateNormal];
}


- (void)setCloseButtonEnable:(BOOL)closeButtonEnable {
    
    _closeButtonEnable = closeButtonEnable;
    
    if (closeButtonEnable) {
        
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        
        // 添加关闭按钮，默认隐藏，只有在WebView中才能使用
        self.closeButton = [TJButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.frame = CGRectMake(0, 0, 40, 40);
        [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        self.closeButton.titleLabel.font = TJSystemFont(40 / 3);
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        self.closeButton.hidden = YES;
        [self.closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
        
        self.navigationItem.leftBarButtonItems = @[barButtonItem, closeButtonItem];
        
    } else {
        
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
}



#pragma mark - Getter
#pragma mark 加载中界面

#pragma mark 数据为空界面


-(UIButton *)leftButton{
    
    if (!_leftButton) {
        _leftButton = [TJButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 60, 40);
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_leftButton addTarget:self action:@selector(leftbuttonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
        self.navigationItem.leftBarButtonItem = item;
    }
    return _leftButton;
    
}


- (UIButton *)rightButton {
    
    if (!_rightButton) {
        
        _rightButton = [TJButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 60, 40);
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:40 / 3];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(rigthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    return _rightButton;
}
#pragma mark - Public
- (void)setupSubviews {
    
}

#pragma mark 点击返回按钮后调用
- (void)backButtonPressed {
    
    if (self && self.backBlock) {
        
        self.backBlock();
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark 点击关闭按钮
- (void)closeButtonPressed {
    
    
}


#pragma mark 导航条左侧按钮点击调用
- (void)leftbuttonPressed {
    
    
}


#pragma mark 右边按钮点击调用
- (void)rigthButtonPressed {
    
}


#pragma mark 重新刷新界面
- (void)refreshUI {
    
}


#pragma mark 取消正在进行的网络请求
- (void)cancelTask {
    
    for (NSInteger i = 0; i < [self.taskArray count]; i++) {
        
        if ([self.taskArray[i] isKindOfClass:[TJRequest class]]) {
            
            TJRequest *request = self.taskArray[i];
            [request cancel];
            
        }
    }
    
    [self.taskArray removeAllObjects];
}

/**
 *  列表数据加载成功后调用
 *
 *  @param dataSource 服务器返回的一页的数据
 */
- (void)requestTableViewDataSourceSuccess:(NSArray *)dataSource;
{
    
    if (dataSource.count==0) {
        
         self.loadState = TJRefreshViewLoadStateEmpty;
    }else{
        
        self.loadState = TJRefreshViewLoadStateSuccess;
    }
    
}

/**
 *  列表数据加载失败后调用
 */
- (void)requestTableViewDataSourceFailure;
{
    [self requestTableViewDataSourceFailureWithResult:nil];
}

/**
 *  列表数据加载失败后调用，根据返回结果进行错误处理
 *
 *  @param result 服务端返回的错误结果
 */
- (void)requestTableViewDataSourceFailureWithResult:(TJResult *)result {
    
    if (result.errcode == kCFURLErrorCannotConnectToHost || result.errcode == kCFURLErrorNotConnectedToInternet) {
        // 网络连接失败
        self.loadState = TJRefreshViewLoadStateNetFailure;
    } else {
        
        // 请求异常显示加载失败界面
        self.loadState = TJRefreshViewLoadStateFailure;
    }
}

/**
 *  请求列表数据（需重写）
 */
- (void)requestTableViewDataSource {

}
/**
 重新刷新数据源 (需重写)
 */
- (void)reloadViewControllerDataSource {
    
    [self requestTableViewDataSource];
}



#pragma mark 清除所有的加载状态视图



#pragma mark - Private
#pragma mark 导航条添加返回按钮
- (void)addNavBackButtonWithDefaultAction {
    
    self.backButton = [TJButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0.f, 0.f, TJSystem2Xphone6Width(60), TJSystem2Xphone6Width(60));
    [self.backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, - TJSystem2Xphone6Width(60) / 2, 0, 0)];
    [self.backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)initData {
    
    if (!self.isInitData) {
        
        self.pageManagerEnable = YES;
        self.taskArray = [NSMutableArray array];
        self.statusBarStyle = UIStatusBarStyleDefault;
        
//        [TJPatchManager runJavaScriptFile:[NSStringFromClass([self class]) stringByAppendingString:@".js"]];
        
        self.isInitData = YES;
    }
}


#pragma mark - Notification


#pragma mark - THLoadingViewDelegate
- (void)loadingViewPressed {
    
}


#pragma mark - THTableLoadFailViewDelegate
#pragma mark 加载失败，重新加载
- (void)reloadViewPressed {
    
    
}

#pragma mark toast
- (void)showToastWithString:(NSString *)string {
    
    [self.view makeToast:string duration:2 position:CSToastPositionCenter];
}

// 是否显示加载状态图
- (void)setShowLoadStateView:(BOOL)showLoadStateView {
    
    _showLoadStateView = showLoadStateView;
    if (showLoadStateView) {
        
        [self.view addSubview:self.loadStateView];
        self.loadState = TJRefreshViewLoadStateLoading;
        
        BLOCK_WEAK_SELF
        [self.loadStateView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakSelf.view);
        }];
        
    } else {
        
        if (self.loadStateView.superview) {
            [self.loadStateView removeFromSuperview];
            self.loadStateView = nil;
        }
    }
}

// tableView的加载状态
- (void)setLoadState:(TJRefreshViewLoadState)loadState {
    
    self.loadStateView.loadState = loadState;
}

// 加载视图
- (TJRefreshLoadStateView *)loadStateView {
    
    if (!_loadStateView) {
        _loadStateView = [[TJRefreshLoadStateView alloc] initWithFrame:self.view.bounds];
        
        BLOCK_WEAK_SELF
        _loadStateView.reLoadBlock = ^{
            
            weakSelf.loadState = TJRefreshViewLoadStateLoading;
            [weakSelf reloadViewControllerDataSource];
        };
    }
    return _loadStateView;
}
@end

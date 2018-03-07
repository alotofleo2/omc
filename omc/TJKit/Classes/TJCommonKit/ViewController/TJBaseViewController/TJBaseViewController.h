//
//  TJBaseViewController.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJTableLoadFailView.h"
#import "TJTableEmptyView.h"
#import "TJTableLoadingView.h"
#import "TJTableNetWorkFailView.h"
#import "TJResult.h"


typedef void(^TJBackBlock)(void);
/**
 *  页面返回类型
 */
typedef NS_ENUM(NSInteger, TJReturnType) {
    /**
     *  默认返回到上一级页面，pushViewController
     */
    TJReturnTypeDefault,
    /**
     *  返回到跟视图控制器 pushRootViewController
     */
    TJReturnTypeRootViewController,
    /**
     *  web控制器返回上一级  goback
     */
    TJReturnTypeGoBack,
};

@interface TJBaseViewController : UIViewController <TJTableLoadFailViewDelegate, UIGestureRecognizerDelegate,TJTableNetWorkFailViewDelegate>
/**
 *  是否使用页面管理
 */
@property (nonatomic, assign) BOOL pageManagerEnable;


/**
 *  点击返回按钮后调用的block
 */
@property (nonatomic, strong) TJBackBlock backBlock;


/**
 *  保存正在执行的task请求
 */
@property (nonatomic, strong) NSMutableArray * taskArray;


/**
 *  用于判断是否需要刷新界面
 *  配合TJPageManager使用，数据修改完成后，通过popViewControllerWithParams将needRefreshUI设置为YES
 *  回到该界面后将自动调用refreshUI方法，刷新界面信息
 */
@property (assign, nonatomic) BOOL needRefreshUI;

/**
 *  自定义返回按钮
 */
@property (nonatomic, strong) TJButton * backButton;

/**
 *  webView中使用的关闭按钮
 */
@property (nonatomic, strong) TJButton * closeButton;


/**
 *  设置关闭按钮是否启用
 */
@property (nonatomic, assign) BOOL closeButtonEnable;

/**
 *  状态栏的风格
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 *  左侧导航条按钮
 */
@property(nonatomic,strong) UIButton  *leftButton;

/**
 *  左侧导航条按钮显示标题
 */
@property(nonatomic,strong) NSString *leftTitle;

/**
 *  左侧按钮图片名
 */
@property (nonatomic, strong) NSString *leftImageName;

/**
 *  左侧按钮图片名，是否带圆角

 */
-(void)setLeftImageName:(NSString *)leftImageName corner:(BOOL) corner;

/**
 *  导航条右侧按钮
 */
@property (nonatomic, strong) UIButton *rightButton;

/**
 *  右侧按钮显示的标题
 */
@property (nonatomic, strong) NSString *rightTitle;


/**
 *  右侧按钮显示的图片名称
 */
@property (nonatomic, strong) NSString *rightImageName;


/**
 *  状态栏的隐藏状态
 */
@property (nonatomic, assign) BOOL statusBarHidden;


/**
 *  数据为空
 */
@property (nonatomic, strong) TJTableEmptyView  * emptyView;


/**
 *  正在加载中
 */
@property (nonatomic, strong) TJTableLoadingView * loadingView;


/**
 *  数据加载失败
 */
@property (nonatomic, strong) TJTableLoadFailView * failView;

/**
 *  网络无连接
 */
@property(nonatomic,strong) TJTableNetWorkFailView *netFailView;


/**
 *  保存前一个界面的截屏图
 */
@property (nonatomic, strong) UIImage *screenShotImage;



/**
 *  设置返回按钮标题
 *
 *  @param title 标题内容
 */
- (void)setBackButtonTitle:(NSString *)title;


/**
 *  设置返回按钮背景颜色
 *
 *  @param color UIColor对象
 *  @param state 按钮状态
 */
- (void)setBackButtonBackgroundColor:(UIColor *)color forState:(UIControlState)state;


/**
 *  点击返回按钮后调用
 */
- (void)backButtonPressed;


/**
 *  点击关闭按钮
 */
- (void)closeButtonPressed;

/**
 *  左侧按钮的标题
 */
-(void)leftbuttonPressed;

/**
 *  点击右侧按钮调用
 */
-(void)rigthButtonPressed;


/**
 *  重新刷新界面
 *  将模型数据到界面上的显示写到此方法中
 */
- (void)refreshUI;



/**
 *  取消正在执行的网络请求
 */
- (void)cancelTask;

#pragma mark 加载数据


/**
 *  请求列表数据（需重写），需要调用[super requestTableViewDataSource];
 */

- (void)requestTableViewDataSource;


/**
 显示加载页面

 @param isNeed 是否需要
 */
- (void)requestTableViewDataSourceIsNeedShowloadView:(BOOL)isNeed;


/**
 *  列表数据加载成功后调用
 *
 *  @param dataSource 服务器返回的一页的数据
 */
- (void)requestTableViewDataSourceSuccess:(NSArray *)dataSource;


/**
 *  列表数据加载失败后调用
 */
- (void)requestTableViewDataSourceFailure;
- (void)requestTableViewDataSourceFailureWithResult:(TJResult *)result;

/**
 *  添加返回按钮
 */
- (void)addNavBackButtonWithDefaultAction;

#pragma mark toast
- (void)showToastWithString:(NSString *)string;

@end

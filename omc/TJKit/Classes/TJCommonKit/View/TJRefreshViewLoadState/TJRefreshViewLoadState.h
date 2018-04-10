//
//  TJRefreshViewLoadState.h
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshViewReLoadBlock)(void);


typedef NS_ENUM(NSUInteger, TJRefreshViewLoadState) {
    
    /**
     *  加载成功
     */
    TJRefreshViewLoadStateSuccess,
    
    /**
     *  正在加载
     */
    TJRefreshViewLoadStateLoading,
    
    /**
     *   数据为空
     */
    TJRefreshViewLoadStateEmpty,
    
    /**
     *  加载失败
     */
    TJRefreshViewLoadStateFailure,
    
    /**
     *   网络无连接
     */
    TJRefreshViewLoadStateNetFailure,
};



@interface TJRefreshLoadStateView : UIView


/**
 *  加载状态
 */
@property (nonatomic, assign) TJRefreshViewLoadState loadState;


/**
 * 重新加载block
 */
@property (nonatomic, copy) refreshViewReLoadBlock reLoadBlock;


/**
 *  小动图
 */
@property (nonatomic, strong) UIImageView *iconImageView;


/**
 *  描述文字
 */
@property (nonatomic, strong) UILabel *titleLabel;


/**
 * 重新加载
 */
@property (nonatomic, strong) UIButton *reloadButton;



@end

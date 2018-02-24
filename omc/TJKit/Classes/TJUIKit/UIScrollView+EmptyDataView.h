//
//  UIScrollView+EmptyDataView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol THEmptyDataViewDelegate <NSObject>

/**
 *  设置emptyDataView上显示的自定义view
 *
 *  @param scrollView 添加了空数据提示界面的scrollView
 *
 *  @return 自定义view
 */
- (UIView *)customViewForEmptyDataView:(UIScrollView *)scrollView;


/**
 *  设置emptyDataView上显示自定义view的背景色
 *
 *  @param scrollView 添加了空数据提示界面的scrollView
 *
 *  @return 背景色
 */
- (UIColor *)backgroundColorForEmptyDataView:(UIScrollView *)scrollView;


@end



@interface THEmptyDataView : UIView


@property (nonatomic, strong) UIView * customView;

- (void)removeAllSubviews;

- (void)show;

- (void)dismiss;

@end



@interface UIScrollView (EmptyDataView)


/**
 *  回调对象
 */
@property (nonatomic, weak) id<THEmptyDataViewDelegate> emptyDataViewDelegate;


/**
 *  设置emptyDataView的frame
 *  原本使用AutoLayout进行控制，但是iOS7在tableView中addSubview并进行约束出现crash，iOS7以上无此问题
 *
 *  @param frame 需要设置的frame
 */
- (void)setEmptyDataViewFrame:(CGRect)frame;


/**
 *  刷新emptyDataView显示的内容
 */
- (void)reloadEmptyDataView;


/**
 *  隐藏emptyDataView
 */
- (void)dismissEmptyDataView;


@end

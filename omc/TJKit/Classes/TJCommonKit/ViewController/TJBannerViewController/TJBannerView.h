//
//  TJBannerViewController.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/26.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJBannerViewDelegate <NSObject>

@optional

/**
 *  广告横幅被点击时调用
 *
 *  @param index 被点击广告的索引
 */
- (void)bannerClickedWithIndex:(NSUInteger)index;

- (void)bannerScrollToIndex:(NSUInteger)index;

@end

@interface TJBannerView : UIView
/**
 *  回调代理对象
 */
@property (nonatomic, weak)id<TJBannerViewDelegate> delegate;

/**
 *  图片url数组,也可以传imagename数组
 */
@property (nonatomic, copy)NSArray *imageUrlArray;

/**
 *  标题数组(待扩展)
 */
@property (nonatomic, copy)NSArray *titleArray;

/**
 *  pageControl 可以自定义样式
 */
@property (nonatomic, strong, readonly)UIPageControl *pageControl;

/**
 *  广告切换间隔
 */
@property (nonatomic, assign)NSTimeInterval interval;

/**
 *  item高度 默认200
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 *  开启自动播放功能
 *
 *  @param interval 广告切换间隔
 */
- (void)startAutoplay:(NSTimeInterval)interval;

/**
 *  开启自动播放功能 使用默认时间或者之前设置的时间
 */
- (void)startAutoplay;
/**
 *  关闭自动播放功能
 */
- (void)stopAutoplay;
@end

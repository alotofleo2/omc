//
//  TJLoopScrollView.h
//  RiceWallet
//
//  Created by 方焘 on 2017/8/4.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJLoopScrollViewDelegate <NSObject>

- (void)loopScrollViewCurrentIndexChange:(NSInteger)currentIndex;

@end

typedef enum : NSUInteger {
    CountTypeZone,
    CountTypeOne,
    CountTypeTwo,
    CountTypeThreeOrMore,
} CountType;

@interface TJLoopScrollView : UIScrollView <UIScrollViewDelegate>{
    
    NSMutableArray *_dataArray;
    
    CGFloat _width;
    CGFloat _height;
    NSTimer *_loopTimer;
    
    UIView *firstLoopView;
    UIView *secondLoopView;
    UIView *thirdLoopView;
    CountType _countType;
    
    
}
@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,assign)BOOL isAutoScroll;

- (void)setUpViewsWithArray:(NSArray *)dataArray isAlwaysLoop:(BOOL)isAlwaysLoop;

- (instancetype)initWithFrame:(CGRect)frame itemViewClassName:(NSString *)className;

- (instancetype)initWithFrame:(CGRect)frame itemViewClassName:(NSString *)className isVertical:(BOOL)isVertical;

/*
 *  当前索引，从0开始，页面显示的数值为索引+1
 */
@property(nonatomic,assign)NSInteger currentIndex;

- (void)setUpViewsWithArray:(NSArray*)dataArray;

- (void)updateWithScrollView:(UIScrollView*)scrollView;

@property(nonatomic,assign)id<TJLoopScrollViewDelegate>loopDelegate;

/**
 * 是否垂直显示，YES垂直显示，NO横向显示
 */
@property(nonatomic,assign)BOOL isVertical;

/*
 *  开始动画
 */
- (void)startAutoplay_loop:(NSTimeInterval)interval;

/*
 *  结束动画
 */
- (void)stopAutoplay_loop;


@end

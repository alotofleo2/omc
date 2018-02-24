//
//  UIScrollView+EmptyDataView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "UIScrollView+EmptyDataView.h"
#import <objc/runtime.h>
#import "Masonry.h"



@interface THEmptyDataView ()


@property (nonatomic, strong) UIView * contentView;

@end


@implementation THEmptyDataView

#pragma mark - Initialization Methods
- (instancetype)init
{
    self =  [super init];
    
    if (self) {
        
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
    }
    
    return self;
}


#pragma mark - Getters
#pragma mark - Setters
- (void)setCustomView:(UIView *)customView {
    
    if (!customView) {
        return;
    }
    
    if (_customView) {
        [_customView removeFromSuperview];
        _customView = nil;
    }
    
    _customView = customView;
    [self.contentView addSubview:_customView];
    
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.contentView);
        }];
    }];
}


- (void)removeAllSubviews {
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _customView = nil;
}


- (void)show {
    
    self.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.alpha = 1.f;
        
    } completion:NULL];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.alpha = 0.f;
        self.hidden = YES;
        
    } completion:NULL];
}

@end


#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataViewDelegate = "emptyDataViewDelegate";
static char const * const kEmptyDataView = "emptyDataView";


@interface UIScrollView ()


/**
 *  无数据时显示的内容为空界面
 */
@property (nonatomic, readonly) THEmptyDataView * emptyDataView;


@end


@implementation UIScrollView (EmptyDataView)


#pragma mark - LifeCycle

#pragma mark - Setter
#pragma mark 设置回调对象
- (void)setEmptyDataViewDelegate:(id<THEmptyDataViewDelegate>)emptyDataViewDelegate {
    
    objc_setAssociatedObject(self, kEmptyDataViewDelegate, emptyDataViewDelegate, OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark 设置无数据时显示的内容为空界面
- (void)setEmptyDataView:(THEmptyDataView *)emptyDataView {
    
    objc_setAssociatedObject(self, kEmptyDataView, emptyDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Getter
#pragma mark 回调对象
- (id<THEmptyDataViewDelegate>)emptyDataViewDelegate {
    
    return objc_getAssociatedObject(self, kEmptyDataViewDelegate);
}


#pragma mark 无数据时显示的内容为空界面
- (THEmptyDataView *)emptyDataView {
    
    THEmptyDataView * view = objc_getAssociatedObject(self, kEmptyDataView);
    
    if (!view) {
        
        view = [THEmptyDataView new];
        view.hidden = YES;
        [self setEmptyDataView:view];
    }
    
    return view;
}


#pragma mark - Public
#pragma mark 设置emptyDataView的frame
- (void)setEmptyDataViewFrame:(CGRect)frame {
    
    self.emptyDataView.frame = frame;
}


#pragma mark 刷新emptyDataView显示的内容
- (void)reloadEmptyDataView {
    
    UIView * customView = nil;
    
    if ([self.emptyDataViewDelegate respondsToSelector:@selector(customViewForEmptyDataView:)]) {
        
        customView = [self.emptyDataViewDelegate customViewForEmptyDataView:self];
    }
    
    
    if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
        
        [self insertSubview:self.emptyDataView atIndex:1];
        
    } else {
        
        [self addSubview:self.emptyDataView];
    }
    
    
    
    // Moves all its subviews
    [self.emptyDataView removeAllSubviews];
    
    // If a non-nil custom view is available, let's configure it instead
    if (customView) {
        self.emptyDataView.customView = customView;
    }
    
    
    if ([self.emptyDataViewDelegate respondsToSelector:@selector(backgroundColorForEmptyDataView:)]) {
        
        self.emptyDataView.backgroundColor = [self.emptyDataViewDelegate backgroundColorForEmptyDataView:self];
    }
    
    self.emptyDataView.hidden = NO;
    [self.emptyDataView show];
}


#pragma mark 隐藏emptyDataView
- (void)dismissEmptyDataView {
    
    [self.emptyDataView dismiss];
}


#pragma mark - Private


#pragma mark - Notification


@end

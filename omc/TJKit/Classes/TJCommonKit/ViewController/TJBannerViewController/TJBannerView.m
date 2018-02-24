//
//  TJBannerViewController.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/26.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBannerView.h"
#import "TJBannerCell.h"


static NSString * const bannerViewIdentifier = @"Cell";
@interface TJBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)BOOL shouldBeginPlay;

@end

@implementation TJBannerView
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setupSubViews];
        [self layoutUI];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setupSubViews];
        [self layoutUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupSubViews];
        [self layoutUI];
    }
    
    return self;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];

}


#pragma mark - 控件加载
/**
 *  添加子控件
 */
- (void)setupSubViews {
    
    //添加collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    
    [self.collectionView registerClass:[TJBannerCell class] forCellWithReuseIdentifier:bannerViewIdentifier];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    [self addSubview:self.collectionView];
    
    //添加pageControl
    self.pageControl = [[UIPageControl alloc]init];
    
    [self addSubview:self.pageControl];
    
    
}

/**
 *  布局子控件
 */
- (void)layoutUI {
    //布局collectionView
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //布局pageControl
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        make.height.equalTo(@(20 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        
    }];
}


#pragma mark - Setter
/*
 * 图片rul数组Set
 */
- (void)setImageUrlArray:(NSArray *)imageUrlArray {
    
    _imageUrlArray = imageUrlArray;
    
    self.pageControl.numberOfPages = _imageUrlArray.count;
    
    [self.collectionView reloadData];
    
    //一加载就设置偏移量为中间组的第一张
    [self.collectionView setContentOffset:CGPointMake(DEVICE_SCREEN_WIDTH *self.imageUrlArray.count, 0)];
    
    
}


- (void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
}

- (void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
    
    self.layout.itemSize = CGSizeMake(DEVICE_SCREEN_WIDTH, itemHeight);
    
    [self.collectionView reloadData];
}
#pragma mark - Getter
#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.itemSize = CGSizeMake(DEVICE_SCREEN_WIDTH, self.itemHeight?: TJSystem3Xphone6Height(526));
        
        _layout.minimumLineSpacing = 0;
        
        _layout.minimumInteritemSpacing = 0;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}


- (NSTimer *)timer {
    if (!_timer && self.shouldBeginPlay) {
        
        BLOCK_WEAK_SELF
        
        _timer = [NSTimer timerWithTimeInterval:(self.interval?: 2) target:weakSelf selector:@selector(scrollConllectionView) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}


#pragma mark - Public

- (void)startAutoplay {
    
    [self startAutoplay:self.interval?: 2];
}
/**
 *  开启自动播放功能
 *
 *  @param interval 广告切换间隔
 */
- (void)startAutoplay:(NSTimeInterval)interval {
    
    _shouldBeginPlay = YES;
    
    _interval = interval;
    
    if (!_timer) {
        
        [self timer];
    }
}


/**
 *  关闭自动播放功能
 */
- (void)stopAutoplay {
    
    _shouldBeginPlay = NO;
    
    if (_timer) {
        
        [self.timer invalidate];
        self.timer = nil;
        
    }
}


#pragma mark - Private

- (void)scrollConllectionView {
    
    if (!self.imageUrlArray) {
        return;
    }
    
    [self changePage];
    
    NSInteger index = (NSInteger)self.collectionView.contentOffset.x / DEVICE_SCREEN_WIDTH;
    
    NSInteger currentIndex = index %self.imageUrlArray.count;
    
    NSInteger section = 0;
    
    if (currentIndex >= self.imageUrlArray.count - 1) {
        
        currentIndex = 0;
        section = 2;
        
    } else {
        
        currentIndex += 1;
        section = 1;
        
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:section];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
}

- (void)changePage {
    
    NSInteger index = (NSInteger)self.collectionView.contentOffset.x / DEVICE_SCREEN_WIDTH;
    
    NSInteger currentIndex = index %self.imageUrlArray.count;
        
    self.pageControl.currentPage = currentIndex;
    
    if (index > self.imageUrlArray.count * 2 - 2 || index < self.imageUrlArray.count) {
        [self.collectionView setContentOffset:CGPointMake(DEVICE_SCREEN_WIDTH *self.imageUrlArray.count + DEVICE_SCREEN_WIDTH *currentIndex, 0)];
    }
}


#pragma mark - 各种代理<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageUrlArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TJBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerViewIdentifier forIndexPath:indexPath];
    
    cell.imageUrlString = self.imageUrlArray[indexPath.item];
    
    return cell;
}


#pragma mark <UIScrollViewdelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (_timer) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self changePage];
    
    [self timer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self changePage];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //代理回调
    if ([self.delegate respondsToSelector:@selector(bannerClickedWithIndex:)]) {
        [self.delegate bannerClickedWithIndex:indexPath.row];
    }
}

@end

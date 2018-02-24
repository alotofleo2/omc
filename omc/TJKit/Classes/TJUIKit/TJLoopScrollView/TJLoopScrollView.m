//
//  TJLoopScrollView.m
//  RiceWallet
//
//  Created by 方焘 on 2017/8/4.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJLoopScrollView.h"


typedef enum : NSUInteger {
    SlidingDirectionTop,
    SlidingDirectionLeft,
    SlidingDirectionBottom,
    SlidingDirectionRight,
} SlidingDirection;

@implementation TJLoopScrollView

- (instancetype)initWithFrame:(CGRect)frame itemViewClassName:(NSString *)className{
    self = [super initWithFrame:frame];
    if (self) {
        _isVertical = NO;
        self.userInteractionEnabled = NO;
        self.bounces = NO;
        _dataArray = [[NSMutableArray alloc] init];
        [self setUpSubViewsWithItemClassName:className];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemViewClassName:(NSString *)className isVertical:(BOOL)isVertical{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.bounces = NO;
        self.userInteractionEnabled = NO;
        _isVertical = isVertical;
        _dataArray = [[NSMutableArray alloc] init];
        [self setUpSubViewsWithItemClassName:className];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _width = self.bounds.size.width;
    _height = self.bounds.size.height;
    
    [self setUpSubViewFrame];
    
    
}

- (void)setUpSubViewsWithItemClassName:(NSString *)className{
    
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    Class item = NSClassFromString(className);
    if (![item isSubclassOfClass:[UIView class]]) {
        NSLog(@"传入类名不是UIView类或其子类的类名");
        return;
    }
    if (_isVertical) {
        firstLoopView = [[item alloc] init];
        secondLoopView = [[item alloc] init];
        thirdLoopView = [[item alloc] init];
        [self addSubview:firstLoopView];
        [self addSubview:secondLoopView];
        [self addSubview:thirdLoopView];
    }else{
        firstLoopView = [[item alloc] init];
        secondLoopView = [[item alloc] init];
        thirdLoopView = [[item alloc] init];
        [self addSubview:firstLoopView];
        [self addSubview:secondLoopView];
        [self addSubview:thirdLoopView];
    }
    [self setUpSubViewFrame];
}

- (void)setUpSubViewFrame{
    
    if (!_isVertical) {
        
        if (_dataArray.count == 0||_dataArray.count == 1) {
            self.contentSize = CGSizeMake(_width, _height);
            self.contentOffset = CGPointMake(0, 0);
        }else if(_dataArray.count == 2){
            self.contentSize = CGSizeMake(_width * 2, _height);
            self.contentOffset = CGPointMake(0, 0);
        }else{
            self.contentSize = CGSizeMake(_width * 3, _height);
            self.contentOffset = CGPointMake(_width, 0);
        }
        
        
        firstLoopView.frame = CGRectMake(0, 0, _width, _height);
        secondLoopView.frame = CGRectMake(_width, 0, _width, _height);
        thirdLoopView.frame = CGRectMake(_width * 2, 0, _width, _height);
    }else{
        if (_dataArray.count == 0||_dataArray.count == 1) {
            self.contentSize = CGSizeMake(_width, _height);
            self.contentOffset = CGPointMake(0, 0);
        }else if(_dataArray.count == 2){
            self.contentSize = CGSizeMake(_width, _height * 2);
            self.contentOffset = CGPointMake(0, 0);
        }else{
            self.contentSize = CGSizeMake(_width, _height*3);
            self.contentOffset = CGPointMake(0, _height);
        }
        firstLoopView.frame = CGRectMake(0, 0, _width, _height);
        secondLoopView.frame = CGRectMake(0, _height, _width, _height);
        thirdLoopView.frame = CGRectMake(0, _height * 2, _width, _height);
        
    }
    
}

- (void)setUpViewsWithArray:(NSArray *)dataArray isAlwaysLoop:(BOOL)isAlwaysLoop{
    
    [_dataArray removeAllObjects];
    
    self.currentPage = 1;
    if (dataArray.count == 0)_countType = CountTypeZone;else if (dataArray.count == 1)_countType = CountTypeOne;else if (dataArray.count == 2)_countType = CountTypeTwo;else _countType = CountTypeThreeOrMore;
    
    if (isAlwaysLoop) {
        NSArray *sourceArray;
        if (dataArray.count==1) {
            sourceArray = @[dataArray.firstObject,[dataArray.firstObject copy],[dataArray.firstObject copy]];
        }else if (dataArray.count == 2){
            sourceArray = @[dataArray.firstObject,[dataArray objectAtIndex:1],[dataArray.firstObject copy],[[dataArray objectAtIndex:1] copy]];
        }else{
            sourceArray = dataArray;
        }
        [_dataArray addObjectsFromArray:sourceArray];
    }else{
        [_dataArray addObjectsFromArray:dataArray];
    }
    
    self.currentIndex = 0;
    
    if (_dataArray.count == 0) {
        
        
        self.contentSize = CGSizeMake(_width, _height);
        self.contentOffset = CGPointMake(0, 0);
        return;
    }else if (_dataArray.count == 1){
        
        self.contentSize = CGSizeMake(_width, _height);
        self.contentOffset = CGPointMake(0, 0);
        
        [firstLoopView setValue:_dataArray.firstObject forKey:@"model"];
        return;
    }else if (_dataArray.count == 2){
        
        if (!_isVertical) {
            self.contentSize = CGSizeMake(_width * 2, _height);
            self.contentOffset = CGPointMake(0, 0);
            
            [firstLoopView setValue:_dataArray.firstObject forKey:@"model"];
            
            [secondLoopView setValue:[_dataArray objectAtIndex:1] forKey:@"model"];
        }else{
            self.contentSize = CGSizeMake(_width, _height * 2);
            
            self.contentOffset = CGPointMake(0, 0);
            
            [firstLoopView setValue:_dataArray.firstObject forKey:@"model"];
            
            [secondLoopView setValue:[_dataArray objectAtIndex:1] forKey:@"model"];
        }
    }
    else{
        
        if (_isVertical) {
            self.contentSize = CGSizeMake(_width, _height*3);
            self.contentOffset = CGPointMake(0, _height);
        }else{
            self.contentSize = CGSizeMake(_width * 3, _height);
            self.contentOffset = CGPointMake(_width, 0);
        }
        [self updateDataSource];
    }
}
- (void)setUpViewsWithArray:(NSArray *)dataArray{
    
    [self setUpViewsWithArray:dataArray isAlwaysLoop:NO];
}

- (void)updateDataSource{
    
    
    [firstLoopView setValue:[self firstModel] forKey:@"model"];
    [secondLoopView setValue:[self secondModel] forKey:@"model"];
    [thirdLoopView setValue:[self thirdModel] forKey:@"model"];
    
}

- (void)updateWithScrollView:(UIScrollView*)scrollView{
    
    if (_dataArray.count<3) {
        return;
    }
    if (_isVertical) {
        if (scrollView.contentOffset.y>_height) {
            //向上滑
            [self updateDataSourceWithSlidingDirection:SlidingDirectionTop];
            
        }else if (scrollView.contentOffset.y<_height){
            //向下滑
            [self updateDataSourceWithSlidingDirection:SlidingDirectionBottom];
            
        }else{
            
            return;
        }
        [scrollView scrollRectToVisible:CGRectMake(0, _height, _width, _height) animated:NO];
    }else{
        if (scrollView.contentOffset.x>_width) {
            //向左滑
            [self updateDataSourceWithSlidingDirection:SlidingDirectionLeft];
            
        }else if (scrollView.contentOffset.x<_width){
            //向右滑
            [self updateDataSourceWithSlidingDirection:SlidingDirectionRight];
            
        }else{
            
            return;
        }
        [scrollView scrollRectToVisible:CGRectMake(_width, 0, _width, _height) animated:NO];
    }
    
    
    
    
}

- (void)updateDataSourceWithSlidingDirection:(SlidingDirection)direction{
    
    
    [self updateCurrentIndexWithSlidingDirection:direction];
    [self updateDataSource];
}

- (void)updateCurrentIndexWithSlidingDirection:(SlidingDirection)direction{
    
    if (direction == SlidingDirectionTop||direction == SlidingDirectionLeft) {
        
        
        self.currentIndex = self.currentIndex + 1;
        
        if (self.currentIndex>=_dataArray.count) {
            
            self.currentIndex = 0;
        }
    }else{
        
        self.currentIndex = self.currentIndex - 1;
        
        if (self.currentIndex<0) {
            self.currentIndex = _dataArray.count - 1;
        }
    }
    
    if (_countType == CountTypeThreeOrMore) {
        
        self.currentPage = self.currentIndex + 1;
    }else if (_countType == CountTypeOne){
        
        //        self.currentIndex = 0;
        self.currentPage = 1;
    }else if (_countType == CountTypeTwo){
        if (self.currentPage == 1) {
            self.currentPage = 2;
        }else{
            self.currentPage = 1;
        }
    }else{
        self.currentPage = 1;
    }
    
    
    if ([self.loopDelegate respondsToSelector:@selector(loopScrollViewCurrentIndexChange:)]) {
        [self.loopDelegate loopScrollViewCurrentIndexChange:self.currentPage];
    }
}

- (id)firstModel{
    if (self.currentIndex==0) {
        return [_dataArray lastObject];
    }else{
        return [_dataArray objectAtIndex:self.currentIndex - 1];
    }
}

- (id)secondModel{
    
    return [_dataArray objectAtIndex:self.currentIndex];
}

- (id)thirdModel{
    if (self.currentIndex >= _dataArray.count - 1) {
        return [_dataArray firstObject];
    }else{
        return [_dataArray objectAtIndex:self.currentIndex + 1];
    }
}

/*
 *  开始动画
 */
- (void)startAutoplay_loop:(NSTimeInterval)interval{
    
    
    
    [self stopAutoplay_loop];
    
    _loopTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_loopTimer forMode:NSRunLoopCommonModes];
}


- (void)timerAction{
    if (_dataArray.count<3) {
        return ;
    }
    if (_isVertical) {
        
        [self scrollRectToVisible:CGRectMake(0, _height*2, _width, _height) animated:YES];
    }else{
        [self scrollRectToVisible:CGRectMake(_width*2, 0, _width, _height) animated:YES];
    }
}
/*
 *  结束动画
 */
- (void)stopAutoplay_loop{
    [_loopTimer invalidate];
    _loopTimer = nil;
}

- (void)dealloc{
    [self stopAutoplay_loop];
}

@end

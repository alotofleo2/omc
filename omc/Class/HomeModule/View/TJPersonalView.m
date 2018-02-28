//
//  TJPersonalView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJPersonalView.h"
#import "TJPersonalDataDelegate.h"
#import "Masonry.h"
#import "TJPersonalTableViewCell.h"
#import "TJPersonalTableHeaderView.h"
#import <POP.h>
#import "TJAccountTask.h"

#define VIEW_WIDTH (DEVICE_SCREEN_WIDTH / 7 * 5)
@interface TJPersonalView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) BOOL isMoving;

@property (nonatomic, assign) CGPoint startTouch;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TJPersonalDataDelegate *datadelegate;

@property (nonatomic, strong) TJPersonalTableHeaderView *tableHeaderView;

@end

@implementation TJPersonalView

#pragma mark - lifeCycle
- (void)dealloc {
    
    [self.datadelegate cancleTask];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    if (self) {
        
        [self setup];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    [self setFrame:frame];
    
    if (self) {
        
        [self setup];
        
    }
    return self;
}

#pragma mark - getter
- (UIView *)maskView {
    if (!_maskView) {
        
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT)];
        
        _maskView.backgroundColor = [UIColor grayColor];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewPressed:)];
        
        [_maskView addGestureRecognizer:gesture];
    }
    return _maskView;
}

- (TJPersonalDataDelegate *)datadelegate {
    
    if (!_datadelegate) {
        
        _datadelegate = [[TJPersonalDataDelegate alloc]init];
        
        _datadelegate.owner = self;
        
    }
    
    return _datadelegate;
}

#pragma mark - public
+ (void)showPersonnalView {
    
    TJPersonalView *personnalView = [[TJPersonalView alloc]initWithFrame:CGRectMake(-10, 0, VIEW_WIDTH + 10, DEVICE_SCREEN_HEIGHT)];
    
    personnalView.hidden = YES;
    
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    
    [topWindow addSubview:personnalView.maskView];
    
    personnalView.maskView.alpha = 0.25;
    
    personnalView.maskView.userInteractionEnabled = NO;
    
    [topWindow addSubview:personnalView];
    
//    pop动画效果
    [personnalView popRigthUpWithDuration:0.25 completionBlock:^{
        
        personnalView.maskView.userInteractionEnabled = YES;
        
    }];
    

}


- (void)endShowPersonnalView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.maskView.alpha = 0;
        
        self.x = - VIEW_WIDTH;
        
    }completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
        [self removeFromSuperview];
        
    }];
}


#pragma mark - private
- (void)setup {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];

    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(1, 1);
    
    self.layer.shadowOpacity = 0.8;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    
    [self addGestureRecognizer:panGesture];
    
    panGesture.delegate = self;
    
    //配置tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.dataSource = self.datadelegate;
    
    self.tableView.delegate = self.datadelegate;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.separatorColor  = [UIColor clearColor];
    
    self.tableView.rowHeight = TJSystem1080Height(180);
    
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerClass:[TJPersonalTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJPersonalTableViewCell class])];
    
    //设置tableView的headerView
    self.tableHeaderView = [[TJPersonalTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, TJSystem1080Height(580))];
    
    self.tableHeaderView.iconImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self.datadelegate action:@selector(iconImageViewPressed:)];
    
    [self.tableHeaderView.iconImageView addGestureRecognizer:gesture];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self.contentView addSubview:self.tableView];
    
    //设置约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
        
    }];
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x {
    
    x = x > 0 ? 0 : x;

    self.transform = CGAffineTransformMakeTranslation(x, 0);
    
    float alpha = 0.25 * (1 + x /VIEW_WIDTH);
    
    self.maskView.alpha = alpha;
    
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // 只支持左侧拖动返回
    CGPoint touchPoint = [touch locationInView:self.superview];
    
    if (touchPoint.x < VIEW_WIDTH - 50) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Gesture Recognizer

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer {
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:self.superview];
    
    switch (recoginzer.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            _isMoving = YES;

            self.startTouch = touchPoint;
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            if (_isMoving) {
                
                [self moveViewWithX: touchPoint.x - self.startTouch.x];
        
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            
            if (self.startTouch.x - touchPoint.x  > VIEW_WIDTH / 7)
            {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    [self moveViewWithX: - VIEW_WIDTH];
                    
                } completion:^(BOOL finished) {
                    
                    [self.maskView removeFromSuperview];
                    
                    [self removeFromSuperview];
                    
                    _isMoving = NO;
                    
                }];
                
            } else if (self.startTouch.x - touchPoint.x > 0) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    [self moveViewWithX:0];
                    
                } completion:^(BOOL finished) {
                    
                    _isMoving = NO;
                    
                }];
            }
            
            break;
        }
            
        default:
            return;
            break;
    }
}
#pragma mark - 各种点击事件
#pragma mark 蒙层点击事件
- (void)maskViewPressed:(UITapGestureRecognizer *)recognizer {
    
    recognizer.view.userInteractionEnabled = NO;
    
    [self endShowPersonnalView];
}

#pragma mark 进入后台的通知
- (void)enterBackground {
    
    [self.maskView removeFromSuperview];
    
    [self removeFromSuperview];
    
}
@end

//
//  FTMessageView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/9/14.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "FTMessage.h"
#import "Masonry.h"




#define FTDesignFileName @"FTMessagesDefaultDesign"

static NSMutableDictionary *_notificationDesign;

static NSInteger _showingViewNum;
@interface FTMessageView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, copy) NSString *currentString;

@property (nonatomic, strong) NSDictionary *currentDesign;

@property (nonatomic, strong) UIVisualEffectView *topVisualView;

@property (nonatomic, strong) UIVisualEffectView *bottomVisualView;

@property (nonatomic, assign) BOOL isMoving;

@property (nonatomic, assign) CGPoint startTouch;

@property (nonatomic, copy) void(^removeBlock)(void);

@property (nonatomic, assign) BOOL isRemoved;
@end

@implementation FTMessageView


#pragma mark - lifeCycle
- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
                         type:(TJMessageNotificationType)type
                     duration:(NSTimeInterval)duration
                    imageName:(NSString *)imageName {
    self = [super init];
    
    if (self) {
        
        _title = title;
        
        _subtitle = subtitle;
        
        _type = type;
        
        _duration = duration;
        
        _imageName = imageName;
        
        CGFloat stringHeight = 0;
        
        CGSize size = CGSizeMake(DEVICE_SCREEN_WIDTH - 8 * 2 - 15 * 2, 1000);
        
        if ([_subtitle length] > 0) {
            
            stringHeight =[subtitle
                          boundingRectWithSize:size
                          options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:self.subtitleLabel.font}
                          context:nil].size.height;
            
        }
        
        [self setFrame:CGRectMake(8, 8, DEVICE_SCREEN_WIDTH - 8 * 2, 36 + stringHeight + 10 + 15)];
        
        [self setupSubViews];
        
        [self setupLayoutSubViews];
        
        
    }
    
    return self;
}

#pragma mark 设置控件
- (void)setupSubViews {
    
    self.backgroundColor = [UIColor colorFromHexCode:self.currentDesign[@"backgroundColor"]];
    
    self.layer.cornerRadius = 10;
    
    self.layer.masksToBounds = YES;

    self.topVisualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    
    [self addSubview:self.topVisualView];
    
    self.bottomVisualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    [self addSubview:self.bottomVisualView];
        
    [self.topVisualView addSubview:self.titleLabel];
        
    [self.bottomVisualView addSubview:self.subtitleLabel];
    
    [self.topVisualView addSubview:self.iconImageView];

}
- (void)moveViewWithY:(float)y {
    
    y = y > 0 ? 0 : y;
    
    self.superview.transform = CGAffineTransformMakeTranslation(0, y);
    
    
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // 只支持左侧拖动返回
    CGPoint touchPoint = [touch locationInView:self.superview.superview];
    
    if (touchPoint.y < self.height - 50) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Gesture Recognizer

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer {
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:self.superview.superview];
    
    switch (recoginzer.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            _isMoving = YES;
            
            self.startTouch = touchPoint;
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            if (_isMoving) {
                
                [self moveViewWithY: touchPoint.y - self.startTouch.y];
                
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            
            if (self.startTouch.y - touchPoint.y  > 10)
            {
                if (self.removeBlock) {
                    self.removeBlock();
                    self.isMoving = NO;
                    self.isRemoved = YES;
                }

                
            } else {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    [self moveViewWithY:0];
                    
                } completion:^(BOOL finished) {
                    
                    _isMoving = NO;
                    
                }];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(self.isRemoved || self.isMoving)return ;
                    if (self.removeBlock) {
                        self.removeBlock();
                    }
                });
            }
            break;
        }
            
        default:
            return;
            break;
    }
}

#pragma mark 布局子控件
- (void)setupLayoutSubViews {
    
    //上部分毛玻璃视图
    [self.topVisualView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.height.equalTo(@36);
        
    }];
    
    //下半部分毛玻璃视图
    [self.bottomVisualView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topVisualView.mas_bottom);
        
    }];
    
    //标题label
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.topVisualView);
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(8);
        
    }];
    
    
    //图标
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self.topVisualView).mas_offset(8);
        make.centerY.equalTo(self.topVisualView);
        make.height.width.equalTo(@20);
        
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bottomVisualView).mas_offset(15);
        make.right.equalTo(self.bottomVisualView).mas_offset(- 15);
        make.top.equalTo(self.bottomVisualView).mas_offset(10);
        
        
    }];
    
    
}

#pragma mark 懒加载
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.font = [UIFont systemFontOfSize:40 / 3];
        
        _titleLabel.textColor = UIColorFromRGB(0x4f423c);
        
        _titleLabel.text = self.title;
    }
    
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    
    if (!_subtitleLabel) {
        
        _subtitleLabel = [[UILabel alloc]init];
        
        _subtitleLabel.numberOfLines = MAXFLOAT;
        
        _subtitleLabel.font = [UIFont systemFontOfSize:[self.currentDesign[@"contentFontSize"] floatValue]];
        
        _subtitleLabel.textColor = [UIColor colorFromHexCode:self.currentDesign[@"contentTextColor"]];
        
        _subtitleLabel.text = self.subtitle?: @" ";
    }
    
    return _subtitleLabel;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView ) {
        
         _iconImageView = [[UIImageView alloc]init];
        
        UIImage *customImage = [UIImage imageNamed:self.imageName];
        if (customImage) {
            
            _iconImageView.image = customImage;
            
        } else {
            
            _iconImageView.image = [UIImage imageNamed:self.currentDesign[@"imageName"]];
            
        }
        
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _iconImageView;
}

#pragma mark 懒加载 样式字典
- (NSDictionary *)currentDesign {
    
    if (!_currentDesign) {
        
        switch (self.type)
        {
            case FTMessageNotificationTypeMessage:
            {
                _currentString = @"message";
                break;
            }
            case FTMessageNotificationTypeError:
            {
                _currentString = @"error";
                break;
            }
            case FTMessageNotificationTypeSuccess:
            {
                _currentString = @"success";
                break;
            }
            case FTMessageNotificationTypeWarning:
            {
                _currentString = @"warning";
                break;
            }
                
            default:
                break;
        }
        
        _currentDesign = [FTMessageView notificationDesign][self.currentString];
    }
    
    return _currentDesign;
}


+ (NSMutableDictionary *)notificationDesign
{
    if (!_notificationDesign)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:FTDesignFileName ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSAssert(data != nil, @"Could not read FTMessages config file from main bundle with name %@.json", FTDesignFileName);
        
        _notificationDesign = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                            options:kNilOptions
                                                                                                              error:nil]];
    }
    
    return _notificationDesign;
}
@end

@implementation FTMessage
+ (void)showTopNotificationWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                                type:(TJMessageNotificationType)type
                            duration:(NSTimeInterval)duration
                           imageName:(NSString *)imageName {
    
    FTMessageView *messageView = [[FTMessageView alloc]initWithTitle:title
                                                            subtitle:subtitle
                                                                type:type
                                                            duration:duration
                                                           imageName:imageName];
    

    
    UIView *backgroundView = [[UIView alloc]init];

    backgroundView.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, messageView.height + 16);

    backgroundView.backgroundColor = [UIColor clearColor];

    
    CALayer *shadowLayer = [CALayer layer];
    
    shadowLayer.frame = CGRectMake(messageView.x + 5, messageView.y + 5, messageView.width - 10, messageView.height - 10);
    
    
    
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    
    shadowLayer.shadowOffset = CGSizeMake(5, 6);
    
    shadowLayer.shadowOpacity = 0.5;
    
    shadowLayer.shadowRadius = 6;
    
    shadowLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:1].CGColor;
    
    [backgroundView.layer addSublayer:shadowLayer];
    
    [backgroundView addSubview:messageView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];

    _showingViewNum += 1;
    
    [self setStatusBar];

    backgroundView.hidden = YES;
    
    [backgroundView fallDownWithDuration:0.3 completionBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(messageView.isRemoved || messageView.isMoving)return ;
            [backgroundView unFallDownWithDuration:0.3 completionBlock:^{
               
                [backgroundView removeFromSuperview];
                
                _showingViewNum -= 1;
                
                [self setStatusBar];
            }];
            
        });
    }];
    __weak typeof(backgroundView) weakBackGroundView = backgroundView;
    BLOCK_WEAK_SELF
    messageView.removeBlock = ^(){
        [weakBackGroundView unFallDownWithDuration:0.3 completionBlock:^{
            [weakBackGroundView removeFromSuperview];
            
            _showingViewNum -= 1;
            
            [weakSelf setStatusBar];
        }];
    };
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:messageView action:@selector(paningGestureReceive:)];
    
    [backgroundView addGestureRecognizer:panGesture];
    
    panGesture.delegate = messageView;
    
}

+ (void)setStatusBar {
    
    if (_showingViewNum <= 0) {
        
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
    } else {
        
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelStatusBar + 1;
        
    }
}

@end

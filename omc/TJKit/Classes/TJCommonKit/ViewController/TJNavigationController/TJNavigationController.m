//
//  TJNavigationController.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJNavigationController.h"

typedef NS_ENUM(NSUInteger, TJPanGestureDirection) {
    
    TJPanGestureDirectionNone,
    
    TJPanGestureDirectionUp,
    
    TJPanGestureDirectionDown,
    
    TJPanGestureDirectionRight,
    
    TJPanGestureDirectionLeft
};

@interface TJNavigationController ()

@property (nonatomic, assign) CGPoint startTouch;
@property (nonatomic, strong) UIView *blackMask;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) BOOL isMoving;

@end

@implementation TJNavigationController 
- (void)dealloc {
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        
        self.dragBackEnable = YES;
        
        
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.dragBackEnable = YES;
    }
    
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = UIColorFromRGB(0xf0f0f0);
    
    
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName, nil];
    [self.navigationBar setTitleTextAttributes:titleAttributes];

}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:(BOOL)animated];
}


// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark - Utility Methods


// get the current view screen shot
- (UIImage *)capture {
    
    
    UIView * currentView = nil;
    
    if (self.tabBarController) {
        
        currentView = self.tabBarController.view;
        
    } else {
        
        currentView = self.view;
    }
    
    //DEVICE_CURRENT_VIEW;
    
    UIGraphicsBeginImageContextWithOptions(currentView.bounds.size, currentView.opaque, 0.0);
    [currentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x {
    
    x = x > DEVICE_SCREEN_WIDTH ? DEVICE_SCREEN_WIDTH : x;
    x = x < 0 ? 0 : x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    
    float alpha = 0.4 - (x/800);
    self.blackMask.alpha = alpha;
    
}


#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
//    if (self.viewControllers.count <= 1 || !self.dragBackEnable)
//        return NO;
//    
//    // 只支持左侧拖动返回
//    CGPoint touchPoint = [touch locationInView:self.view.superview];
//    
//    if (touchPoint.x > 50) {
//        return NO;
//    }
//    
//    return YES;
//}

#pragma mark - Gesture Recognizer -

//- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
//{
//    // If the viewControllers has only one vc or disable the interaction, then return.
//    if (self.viewControllers.count <= 1 || !self.dragBackEnable)
//        return;
//    
//    // we get the touch position by the window's coordinate
//    CGPoint touchPoint = [recoginzer locationInView:self.view.superview];
//    
//    switch (recoginzer.state) {
//            
//        case UIGestureRecognizerStateBegan: {
//            
//            _isMoving = YES;
//            self.startTouch = touchPoint;
//            
//            
//            if (self.backgroundView) {
//                
//                [self.backgroundView removeFromSuperview];
//                self.backgroundView = nil;
//            }
//            
//            
//            self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
//            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
//            
//            self.blackMask = [[UIView alloc]initWithFrame:self.backgroundView.bounds];
//            self.blackMask.backgroundColor = [UIColor blackColor];
//            [self.backgroundView addSubview:self.blackMask];
//            
//            UIImage * screenShotImag = nil;
//            id lastObject = [self.viewControllers lastObject];
//            
//            if ([lastObject isKindOfClass:[TJBaseViewController class]] ) {
//                
//                screenShotImag = [(TJBaseViewController *)lastObject screenShotImage];
//            }
//            
//            UIImageView * lastScreenShotView = [[UIImageView alloc] initWithImage:screenShotImag];
//            [self.backgroundView insertSubview:lastScreenShotView belowSubview:self.blackMask];
//            break;
//        }
//            
//        case UIGestureRecognizerStateChanged: {
//            
//            if (_isMoving) {
//                [self moveViewWithX:touchPoint.x - self.startTouch.x];
//            }
//            
//            break;
//        }
//            
//        case UIGestureRecognizerStateEnded: {
//            
//            if (touchPoint.x - self.startTouch.x > DEVICE_SCREEN_WIDTH / 5)
//            {
//                [UIView animateWithDuration:0.3 animations:^{
//                    
//                    [self moveViewWithX:DEVICE_SCREEN_WIDTH];
//                    
//                } completion:^(BOOL finished) {
//                    
//                    
//                    [self popViewControllerAnimated:NO];
//                    CGRect frame = self.view.frame;
//                    frame.origin.x = 0;
//                    frame.size.height = DEVICE_SCREEN_HEIGHT;
//                    self.view.frame = frame;
//                    
//                    [self.view layoutIfNeeded];
//                    
//                    _isMoving = NO;
//                    self.backgroundView.hidden = YES;
//                    
//                }];
//                
//            } else {
//                
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self moveViewWithX:0];
//                } completion:^(BOOL finished) {
//                    _isMoving = NO;
//                    self.backgroundView.hidden = YES;
//                }];
//                
//            }
//            
//            break;
//        }
//            
//        default:
//            return;
//            break;
//    }
//}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    
//    if (animated) {
//        
//        if (self.backgroundView) {
//            
//            [self.backgroundView removeFromSuperview];
//            self.backgroundView = nil;
//        }
//        
//        
//        self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
//        [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
//        
//        self.blackMask = [[UIView alloc]initWithFrame:self.backgroundView.bounds];
//        self.blackMask.backgroundColor = [UIColor blackColor];
//        [self.backgroundView addSubview:self.blackMask];
//        
//        UIImage * screenShotImag = nil;
//        id lastObject = [self.viewControllers lastObject];
//        
//        if ([lastObject isKindOfClass:[TJBaseViewController class]] ) {
//            
//            screenShotImag = [(TJBaseViewController *)lastObject screenShotImage];
//        }
//        
//        UIImageView * lastScreenShotView = [[UIImageView alloc] initWithImage:screenShotImag];
//        [self.backgroundView insertSubview:lastScreenShotView belowSubview:self.blackMask];
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            
//            [self moveViewWithX:DEVICE_SCREEN_WIDTH];
//            
//        } completion:^(BOOL finished) {
//            
//            
//            [super popViewControllerAnimated:NO];
//            CGRect frame = self.view.frame;
//            frame.origin.x = 0;
//            frame.size.height = DEVICE_SCREEN_HEIGHT;
//            self.view.frame = frame;
//            
//            [self.view layoutIfNeeded];
//            
//            self.backgroundView.hidden = YES;
//            
//        }];
//        
//        return lastObject;
//        
//    } else {
//        
//        return [super popViewControllerAnimated:NO];
//    }
//}
@end

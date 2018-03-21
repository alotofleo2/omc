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
    self.interactivePopGestureRecognizer.delegate =  self;
    
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

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    return YES;
}

@end

//
//  UIView+ViewUtils.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "UIView+ViewUtils.h"
#import <QuartzCore/QuartzCore.h>
#import <POP.h>


#pragma GCC diagnostic ignored "-Wgnu"

@implementation UIView (ViewUtils)


#pragma mark - nib loading
+ (id)instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner
{
    //default values
    NSString *nibName = nibNameOrNil ?: NSStringFromClass(self);
    NSBundle *bundle = bundleOrNil ?: [NSBundle mainBundle];
    
    //cache nib to prevent unnecessary filesystem access
    static NSCache *nibCache = nil;
    if (nibCache == nil)
    {
        nibCache = [[NSCache alloc] init];
    }
    NSString *pathKey = [NSString stringWithFormat:@"%@.%@", bundle.bundleIdentifier, nibName];
    UINib *nib = [nibCache objectForKey:pathKey];
    if (nib == nil)
    {
        NSString *nibPath = [bundle pathForResource:nibName ofType:@"nib"];
        if (nibPath) nib = [UINib nibWithNibName:nibName bundle:bundle];
        [nibCache setObject:nib ?: [NSNull null] forKey:pathKey];
    }
    else if ([nib isKindOfClass:[NSNull class]])
    {
        nib = nil;
    }
    
    if (nib)
    {
        //attempt to load from nib
        NSArray *contents = [nib instantiateWithOwner:owner options:nil];
        UIView *view = [contents count]? [contents objectAtIndex:0]: nil;
        NSAssert ([view isKindOfClass:self], @"First object in nib '%@' was '%@'. Expected '%@'", nibName, view, self);
        return view;
    }
    
    //return empty view
    return [[[self class] alloc] init];
}

- (void)loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil
{
    NSString * nibName = nibNameOrNil ?: NSStringFromClass([self class]);
    
    UIView * view = [UIView instanceWithNibName:nibName bundle:bundleOrNil owner:self];
    
    if (view)
    {
        if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
            
            //if we have zero size, set size from content
            self.size = view.size;
            
        } else {
            
            //otherwise set content size to match our size
            view.frame = self.contentBounds;
        }
        
        [self addSubview:view];
    }
}


#pragma mark - view searching
- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    for (UIView *view in self.subviews)
    {
        UIView *match = [view viewMatchingPredicate:predicate];
        if (match) return match;
    }
    return nil;
}


- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass {
    
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}


- (UIView *)viewOfClass:(Class)viewClass
{
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}


- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate
{
    NSMutableArray *matches = [NSMutableArray array];
    if ([predicate evaluateWithObject:self])
    {
        [matches addObject:self];
    }
    for (UIView *view in self.subviews)
    {
        //check for subviews
        //avoid creating unnecessary array
        if ([view.subviews count])
        {
            [matches addObjectsFromArray:[view viewsMatchingPredicate:predicate]];
        }
        else if ([predicate evaluateWithObject:view])
        {
            [matches addObject:view];
        }
    }
    return matches;
}

- (NSArray *)viewsWithTag:(NSInteger)tag
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag;
    }]];
}

- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (NSArray *)viewsOfClass:(Class)viewClass
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    return [self.superview firstSuperviewMatchingPredicate:predicate];
}

- (UIView *)firstSuperviewOfClass:(Class)viewClass
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (UIView *)firstSuperviewWithTag:(NSInteger)tag
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag;
    }]];
}

- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag && [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return YES;
    }
    return [self.superview viewOrAnySuperviewMatchesPredicate:predicate];
}

- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass
{
    return [self viewOrAnySuperviewMatchesPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)isSuperviewOfView:(UIView *)view
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview == view;
    }]] != nil;
}

- (BOOL)isSubviewOfView:(UIView *)view
{
    return [view isSuperviewOfView:self];
}


#pragma mark - responder chain
- (UIViewController *)firstViewController
{
    id responder = self;
    while ((responder = [responder nextResponder]))
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
    }
    return nil;
}

- (UIView *)firstResponder
{
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isFirstResponder];
    }]];
}

#pragma mark - frame accessors
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)y {
    
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}


- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}


- (CGFloat)centerX {
    
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    
    self.center = CGPointMake(self.center.x, centerY);
}






- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}




- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}




#pragma mark - bounds accessors
- (CGSize)boundsSize
{
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size
{
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth
{
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight
{
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}


#pragma mark - content getters
- (CGRect)contentBounds
{
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter
{
    return CGPointMake(self.boundsWidth/2.0f, self.boundsHeight/2.0f);
}


#pragma mark - additional frame setters
- (void)setLeft:(CGFloat)left right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = right - left;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - width;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - height;
    frame.size.height = height;
    self.frame = frame;
}
#pragma  mark - border
- (void)setBorderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

#pragma mark - animation
- (void)crossfadeWithDuration:(NSTimeInterval)duration
{
    //jump through a few hoops to avoid QuartzCore framework dependency
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion
{
    [self crossfadeWithDuration:duration];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

#pragma mark 阴影

-(void)setShadowcolor0:(UIColor*)color0 color1:(UIColor*) color1;
{
    UIView  *_layerView =self;
    
    CAGradientLayer * _gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    _gradientLayer.bounds = _layerView.bounds;
    _gradientLayer.borderWidth = 0;
    _gradientLayer.frame = _layerView.bounds;
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)color0.CGColor,
                             (id)color1.CGColor, nil];
    
    _gradientLayer.startPoint = CGPointMake(0.5, 0);
    
    _gradientLayer.endPoint = CGPointMake(0.5, 1);
    
    [_layerView.layer insertSublayer:_gradientLayer atIndex:0];
    
}
#pragma mark 水平居中
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


#pragma mark 竖直下落
- (void)fallDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock {
    
    self.hidden = NO;
    
    CGRect oriFrame = self.frame;
 //   CGFloat offsetFromTop = [self.superview.superview convertPoint:self.superview.origin toView:[UIApplication sharedApplication].keyWindow].y;
    
    self.y =  - self.height;
    
    //第一阶段动画
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, - self.height)];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y  + oriFrame.size.height / 2 )];
    
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    positionAnimation.duration = duration ?: 0.3;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerDown"];
    
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
    
        if(completionBlock) completionBlock();
    };
}

/**
 *  竖直下落弹回去的效果
 *
 *  @param duration 弹回的时间
 */
- (void)unFallDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock {
    
    CGRect oriFrame = self.frame;
    //第一阶段动画
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y  + oriFrame.size.height / 2 )];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, - self.height)];
    
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    positionAnimation.duration = duration ?: 0.3;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerUp"];
    
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        if(completionBlock) completionBlock();
    };
}

#pragma mark pop
- (void)popUpWithDuration:(NSTimeInterval)duration completionBlock:(void (^)(void))completionBlock {
    
    self.hidden = NO;
    
    CGRect oriFrame = self.frame;
    
     CGFloat offsetFromBottom = DEVICE_SCREEN_HEIGHT - [self.superview.superview convertPoint:self.superview.origin toView:[UIApplication sharedApplication].keyWindow].y;
    
    self.y = offsetFromBottom;

    //第一阶段动画
    [POPBasicAnimation animation];
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, offsetFromBottom)];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y  + oriFrame.size.height / 2 - 10)];
    
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    positionAnimation.duration = duration ?: 0.3;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerUp"];
    
    //第二阶段动画
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y + oriFrame.size.height / 2 + 5)];
        
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        positionAnimation.duration = 0.15;
        
        [self pop_addAnimation:positionAnimation forKey:@"centerDown"];
        
        positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            //第三阶段动画
            POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
            
            positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y + oriFrame.size.height / 2)];
            
            positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            
            positionAnimation.duration = 0.15;
            
            [self pop_addAnimation:positionAnimation forKey:@"centerUp"];
            
            positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
                
                if (completionBlock) completionBlock();
                
            };
        };
        
    };
    
    self.hidden = NO;
}


- (void)popDownWithDuration:(NSTimeInterval)duration completionBlock:(void (^)(void))completionBlock {
    
    CGRect oriFrame = self.frame;
    
    CGFloat offsetFromBottom = DEVICE_SCREEN_HEIGHT - [self.superview.superview convertPoint:self.superview.origin toView:[UIApplication sharedApplication].keyWindow].y;
    
    //第一阶段动画
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, oriFrame.origin.y  + oriFrame.size.height / 2 - 10)];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    positionAnimation.duration = 0.1;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerUp"];
    
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        //第二阶段动画
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.x + self.width / 2, offsetFromBottom + self.height / 2)];
        
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        positionAnimation.duration = duration ?: 0.2;
        
        [self pop_addAnimation:positionAnimation forKey:@"centerDown"];
        
        positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            if (completionBlock) completionBlock();
        };
        
    };
    
}

- (void)popRigthUpWithDuration:(NSTimeInterval)duration completionBlock:(void (^)(void))completionBlock {
    
    CGRect oriFrame = self.frame;
    
    self.hidden = NO;

    CGFloat offsetFromLeft =  - [self.superview.superview convertPoint:self.superview.origin toView:[UIApplication sharedApplication].keyWindow].x - self.width;
    
    self.x = offsetFromLeft;
    
    //第一阶段动画
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(offsetFromLeft, self.y + self.height / 2)];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(oriFrame.origin.x + oriFrame.size.width / 2 + 10, self.y + self.height / 2)];
    
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    positionAnimation.duration = duration ?: 0.3;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerRight"];
    
    
    //第二阶段动画
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(oriFrame.origin.x + oriFrame.size.width / 2 - 5, self.y + self.height / 2)];
        
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        positionAnimation.duration = 0.15;
        
        [self pop_addAnimation:positionAnimation forKey:@"centerLeft"];
        
        positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            //第三阶段动画
            POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
            
            positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(oriFrame.origin.x + oriFrame.size.width / 2, self.y + self.height / 2)];
            
            positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            
            positionAnimation.duration = 0.15;
            
            [self pop_addAnimation:positionAnimation forKey:@"centerLeft"];
            
            positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
                
                if (completionBlock) completionBlock();
                
                
            };
            
        };
        
    };
    
}


- (void)popRigthDownWithDuration:(NSTimeInterval)duration completionBlock:(void (^)(void))completionBlock {
    CGRect oriFrame = self.frame;
    
    CGFloat offsetFromLeft =  - [self.superview.superview convertPoint:self.superview.origin toView:[UIApplication sharedApplication].keyWindow].x - self.width;
    
    //第一阶段动画
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(oriFrame.origin.x + oriFrame.size.width / 2 + 10, self.y + self.height / 2)];
    
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    positionAnimation.duration = 0.1;
    
    [self pop_addAnimation:positionAnimation forKey:@"centerRight"];
    positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        //第二阶段动画
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(offsetFromLeft, self.y + self.height / 2)];
        
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        positionAnimation.duration = duration ?: 0.2;
        
        [self pop_addAnimation:positionAnimation forKey:@"centerLeft"];
        
        positionAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            if (completionBlock) completionBlock();
            
        };
    };
}
@end


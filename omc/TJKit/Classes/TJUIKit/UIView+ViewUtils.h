//
//  UIView+ViewUtils.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewUtils)


// nib loading
+ (id)instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner;
- (void)loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil;

// hierarchy
- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (UIView *)viewOfClass:(Class)viewClass;
- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)viewsWithTag:(NSInteger)tag;
- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray *)viewsOfClass:(Class)viewClass;

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)firstSuperviewOfClass:(Class)viewClass;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)isSuperviewOfView:(UIView *)view;
- (BOOL)isSubviewOfView:(UIView *)view;

- (UIViewController *)firstViewController;
- (UIView *)firstResponder;


// frame accessors
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,readonly, assign) CGFloat maxX;
@property (nonatomic,readonly, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;



// bounds accessors
@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;


// content getters
@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;



// additional frame setters
- (void)setLeft:(CGFloat)left right:(CGFloat)right;
- (void)setWidth:(CGFloat)width right:(CGFloat)right;
- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom;

//border
- (void)setBorderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;
// animation
- (void)crossfadeWithDuration:(NSTimeInterval)duration;
- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;
/**
 *  阴影view
 *
 *  @param color0 开始颜色
 *  @param color1 结束颜色
 */
-(void)setShadowcolor0:(UIColor*)color0 color1:(UIColor*) color1;


/**
 *  竖直下落效果
 *
 *  @param duration 弹出的时间
 */
- (void)fallDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;

/**
 *  竖直下落弹回去的效果
 *
 *  @param duration 弹回的时间
 */
- (void)unFallDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;
/**
 *  pop竖直弹出效果
 *
 *  @param duration 弹出的时间
 */
- (void)popUpWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;


/**
 *  pop竖直弹回效果
 *
 *  @param duration 弹回时间
 */
- (void)popDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;

/**
 *  pop向右弹出效果
 *
 *  @param duration 弹出时间
 */
- (void)popRigthUpWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;

/**
 *  pop向右弹回效果
 *
 *  @param duration 弹回时间
 */
- (void)popRigthDownWithDuration:(NSTimeInterval)duration completionBlock:(void(^)(void))completionBlock;
@end

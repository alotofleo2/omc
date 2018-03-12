//
//  TJCurtainEditContentView.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditContentView.h"
#import "POPAnimatableProperty+AGGeometryKit.h"
#import "AGGeometryKit.h"
#import <pop/POP.h>
#import "UIImageView+WebCache.h"
#import "TJCurtainContentImagemodel.h"

@interface TJCurtainEditContentView ()
@property (nonatomic, strong) UIImageView *CurrentImageView;

@property (nonatomic, strong) NSString *currentAnimationPreopert;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) NSMutableArray<TJCurtainContentImagemodel *> *models;
@end

@implementation TJCurtainEditContentView


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.imageViews = [NSMutableArray arrayWithCapacity:0];
        self.models = [NSMutableArray arrayWithCapacity:0];
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}
- (void)addImageWithModel:(TJCurtainContentImagemodel* )model {
    [self.models addObject:model];
    UIImageView *imageView = [[UIImageView alloc]init];
    if ([model.contentImageName hasPrefix:@"http"]) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageName]];
    }else {
        imageView.image = [UIImage imageNamed:model.contentImageName];
    }
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [imageView addGestureRecognizer:gesture];
    model.imageView = imageView;
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        make.width.height.equalTo(@(TJSystem2Xphone6Width(200)));
    }];
    self.CurrentImageView = imageView;
    
}

- (void)setupSubviews {
    self.backGroundImageView = [[UIImageView alloc]init];
    [self addSubview:self.backGroundImageView];
    
//    self.imageView = [[UIImageView alloc]init];
//    self.imageView.image = [UIImage imageNamed:@"rexiao"];
//    self.imageView.userInteractionEnabled = YES;
//    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
//    [self addGestureRecognizer:gesture];
//    [self addSubview:self.imageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (TJCurtainContentImagemodel *model  in self.models) {
        
        CGRect frame = model.imageView.frame;
        [model.imageView.layer ensureAnchorPointIsSetToZero];
        
        model.imageView.layer.quadrilateral = AGKQuadMake(CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame)),
                                                         CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame)),
                                                         CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame)),
                                                         CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)));
        model.leftTopPoint     = CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame));
        model.rightTopPoint    = CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame));
        model.rightBottomPoint = CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame));
        model.leftBottomPoint  = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame));
                                                                                                           
    }
}
- (void)setupLayoutSubviews {
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
    }];

}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    TJCurtainContentImagemodel * currentModel;
    for (TJCurtainContentImagemodel *model  in self.models) {
        if (model.imageView == self.CurrentImageView) {
            currentModel = model;
        }
    }
    CGFloat minLeft = MIN(currentModel.leftTopPoint.x, currentModel.leftBottomPoint.x);
    CGFloat maxRight = MAX(currentModel.rightBottomPoint.x, currentModel.rightTopPoint.x);
    CGFloat minTop = MIN(currentModel.rightTopPoint.y, currentModel.leftTopPoint.y);
    CGFloat maxBottom = MAX(currentModel.leftBottomPoint.y, currentModel.rightBottomPoint.y);
    CGPoint center = CGPointMake((minLeft + maxRight) / 2, (minTop + maxBottom) / 2);
    
    CGPoint location = [recognizer locationInView:self];
    CGPoint endPoint;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //判断落点位置
        //左上
        if ((location.x < center.x) && (location.y < center.y)) {
            
            self.currentAnimationPreopert = kPOPLayerAGKQuadTopLeft;
            //右上
        } else if ((location.x > center.x) && (location.y < center.y)) {
            
            self.currentAnimationPreopert = kPOPLayerAGKQuadTopRight;
            //右下
        } else if ((location.x > center.x) && (location.y > center.y)) {
            
            self.currentAnimationPreopert = kPOPLayerAGKQuadBottomRight;
            //左下
        } else if ((location.x < center.x) && (location.y > center.y)) {
            
            self.currentAnimationPreopert = kPOPLayerAGKQuadBottomLeft;
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        self.currentAnimationPreopert = nil;
    }
    
    if (self.currentAnimationPreopert == kPOPLayerAGKQuadTopLeft) {
        endPoint = currentModel.leftTopPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadTopRight) {
        endPoint = currentModel.rightTopPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadBottomRight) {
        endPoint = currentModel.rightBottomPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadBottomLeft) {
        endPoint = currentModel.leftBottomPoint;
    }
    
    CGPoint translation = [recognizer translationInView:self];
    CGPoint newPoint = CGPointMake(endPoint.x + translation.x, endPoint.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self];
    // Animate
    POPSpringAnimation *anim = [self.CurrentImageView.layer pop_animationForKey:self.currentAnimationPreopert];
    
    if(anim == nil)
    {
        anim = [POPSpringAnimation animation];
        anim.property = [POPAnimatableProperty AGKPropertyWithName:self.currentAnimationPreopert];
        [self.CurrentImageView.layer pop_addAnimation:anim forKey:self.currentAnimationPreopert];
    }
    
    anim.velocity = [NSValue valueWithCGPoint:[recognizer velocityInView:self]];
    anim.toValue = [NSValue valueWithCGPoint:newPoint];
    
    
    if (self.currentAnimationPreopert == kPOPLayerAGKQuadTopLeft) {
        currentModel.leftTopPoint = newPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadTopRight) {
        currentModel.rightTopPoint = newPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadBottomRight) {
        currentModel.rightBottomPoint = newPoint;
    } else if (self.currentAnimationPreopert == kPOPLayerAGKQuadBottomLeft) {
        currentModel.leftBottomPoint = newPoint;
    }
}
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    
}

#pragma public
- (UIImage *)getCapture {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end

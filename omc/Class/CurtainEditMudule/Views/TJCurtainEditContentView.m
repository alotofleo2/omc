//
//  TJCurtainEditContentView.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "POPAnimatableProperty+AGGeometryKit.h"
#import "TJCurtainContentImagemodel.h"
#import "TJCurtainEditContentView.h"
#import "UIImageView+WebCache.h"
#import <CoreImage/CoreImage.h>
#import "AGGeometryKit.h"
#import <pop/POP.h>

#define kMaxImageCount 6

@interface TJCurtainEditContentView ()

@property (nonatomic, strong) UIImageView *backGroundImageView;

@property (nonatomic, strong) UIImageView *CurrentImageView;

@property (nonatomic, strong) NSString *currentAnimationPreopert;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) NSMutableArray<TJCurtainContentImagemodel *> *models;

@property (nonatomic, assign) TJCurtainContentNumberType contentNumberType;

//是否显示拐角数子
@property (nonatomic, assign, getter=isShowNumbers) BOOL showNumbers;

@property (nonatomic, strong) NSDictionary *numberIcons;

//新添加一个imageView的方法
- (UIImageView *)addImageViewWithModel:(TJCurtainContentImagemodel *)model;

//背景图片的调度值
//亮度值
@property (nonatomic, assign) CGFloat brightnessValue;

//对比度值
@property (nonatomic, assign) CGFloat contrastValue;

//饱和度值
@property (nonatomic, assign) CGFloat saturationValue;
@end

@implementation TJCurtainEditContentView


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.imageViews = [NSMutableArray arrayWithCapacity:0];
        self.showNumbers = YES;
        self.contentNumberType = TJCurtainContentNumberTypeSingle;
        
        self.models = [NSMutableArray arrayWithCapacity:0];
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:gesture];
        
        self.brightnessValue = 1.f;
        self.contrastValue = 1.f;
        self.saturationValue= 1.f;
    }
    return self;
}

#pragma mark public
- (void)addImageWithModel:(TJCurtainContentImagemodel* )model {
    
    //有单图
    if (self.contentNumberType == TJCurtainContentNumberTypeSingle ) {
        if (self.models.count > 0) {
            [self.models removeAllObjects];
            [self.imageViews.firstObject removeFromSuperview];
            [self.imageViews removeAllObjects];
            [self addImageViewWithModel:model];
            self.showNumbers = YES;
        } else {
            [self addImageViewWithModel:model];
            self.showNumbers = YES;
        }
        //多图
    } else if (self.contentNumberType == TJCurtainContentNumberTypeMulti ) {
        if (self.models.count < kMaxImageCount) {
            [self addImageViewWithModel:model];
            self.showNumbers = YES;
        }
        
    }
    
    
}

- (void)deleteImage {
    //有单图
    if (self.contentNumberType == TJCurtainContentNumberTypeSingle ) {
        if (self.models.count > 0) {
            [self.models removeAllObjects];
            [self.imageViews.firstObject removeFromSuperview];
            [self.imageViews removeAllObjects];
        }
        //多图
    } else if (self.contentNumberType == TJCurtainContentNumberTypeMulti ) {
        if (self.models.count > 0) {
            [self.CurrentImageView removeFromSuperview];
            [self.imageViews removeObject:self.CurrentImageView];
            for (NSInteger i = 0 ; i < self.models.count; i++) {
                if (self.models[i].imageView == self.CurrentImageView) {
                    [self.models removeObjectAtIndex:i];
                    self.CurrentImageView = self.imageViews.count > 0 ? self.imageViews.firstObject : nil;
                }
            }
        }
        
    }
    self.showNumbers = self.imageViews.count > 0;
}

- (UIImage *)getCapture {
    self.showNumbers = NO;
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap;
    } else {
        [TJAlertUtil toastWithString:@"系统版本过低"];
        return nil;
    }
    
}



- (void)backgroundChangeWithType:(TJCurtainBackgroundChangeType)type value:(CGFloat)value {
    switch (type) {
        case TJCurtainBackgroundChangeTypeHilight:
            
            self.brightnessValue = value;
            break;
        case TJCurtainBackgroundChangeTypeContrast:
            
            self.contrastValue = value;
            break;
        case TJCurtainBackgroundChangeTypeDark:
            
            self.saturationValue = value;
            break;

    }
     //使用CGImage初始化CIImage对象
    CIImage *image = [CIImage imageWithCGImage:self.backgroundImage.CGImage];
    //创建一个滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    //利用键值对来设置滤镜的属性（后面的key在CIFilter中都可以找到，然后拿到这些key进行相应的赋值即可）
    [filter setValue:image forKey:kCIInputImageKey];
    
    //设置亮度
    [filter setValue:@(self.brightnessValue) forKey:kCIInputBrightnessKey];
    
    //设置对比度
    [filter setValue:@(self.contrastValue) forKey:kCIInputContrastKey];

    //设置饱和度
    [filter setValue:@(self.saturationValue) forKey:kCIInputSaturationKey];

    //得到滤镜处理后的CIImage
    CIImage *imageOut = [filter outputImage];
    //初始化CIContext对象
    CIContext *context = [CIContext contextWithOptions:nil];
    //利用CIContext对象渲染后得到CGImage，最后将它转成UIImage
    CGImageRef outImage = [context createCGImage:imageOut fromRect:imageOut.extent];
    
    UIImage *outPutImage = [UIImage imageWithCGImage:outImage];
    //释放CGImage对象，一定不要忘记自己释放
    self.backGroundImageView.image = outPutImage;
    CGImageRelease(outImage);

}

- (void)contentNumberButtonPressedWithType:(TJCurtainContentNumberType)type {
    
    if (self.contentNumberType == TJCurtainContentNumberTypeMulti && type == TJCurtainContentNumberTypeSingle) {
        
        //删除图片
        for (NSInteger i = 1; i < self.imageViews.count; i++) {
            [self.imageViews[i] removeFromSuperview];
        }
        [self.imageViews removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange: NSMakeRange(1, self.imageViews.count - 1)]];
        [self.models removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange: NSMakeRange(1, self.models.count - 1)]];
        
    }
    self.contentNumberType = type;
    
}

- (void)setupSubviews {
    self.backGroundImageView = [[UIImageView alloc]init];
    self.backGroundImageView.userInteractionEnabled = YES;
    self.backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backGroundImageView.layer.masksToBounds = YES;
   
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.backGroundImageView addGestureRecognizer:gesture];
    [self addSubview:self.backGroundImageView];
    

}
- (void)layoutSubviews {
    [super layoutSubviews];
    

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
    anim.springSpeed = 20;
    anim.springBounciness = 0;
    anim.removedOnCompletion = NO;
    
    anim.velocity = [NSValue valueWithCGPoint:[recognizer velocityInView:self]];
    anim.toValue = [NSValue valueWithCGPoint:newPoint];
    
    UILabel *numberIconLabel = self.numberIcons[self.currentAnimationPreopert];
    numberIconLabel.x += translation.x;
    numberIconLabel.y += translation.y;
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
    if (recognizer.view == self.backGroundImageView) {
        
        self.showNumbers = !self.isShowNumbers;
    } else if ([recognizer.view isMemberOfClass:[UIImageView class]]){
        [self bringSubviewToFront:recognizer.view];
        self.CurrentImageView = (UIImageView *)recognizer.view;
        
        for (TJCurtainContentImagemodel *model  in self.models) {
            
            //设置4个拐角
            if (model.imageView == self.CurrentImageView ) {
                
                [self changeNumberIconCenterWithModel:model];
            }
        }
        
    }
}




#pragma mark setter
- (void)setShowNumbers:(BOOL)showNumbers {
    _showNumbers = showNumbers;
    
    [self.numberIcons enumerateKeysAndObjectsUsingBlock:^(NSString * key, UILabel * obj, BOOL * _Nonnull stop) {
        if (self.models.count == 0) {
            obj.hidden = YES;
        } else {
            
            obj.hidden = !showNumbers;
        }
    }];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.backGroundImageView.image = backgroundImage;
}

#pragma mark getter
- (NSDictionary *)numberIcons {
    if (!_numberIcons) {
        _numberIcons = @{kPOPLayerAGKQuadTopLeft : [self creatNumberIconWithKey:kPOPLayerAGKQuadTopLeft],
                         kPOPLayerAGKQuadTopRight : [self creatNumberIconWithKey:kPOPLayerAGKQuadTopRight],
                         kPOPLayerAGKQuadBottomRight : [self creatNumberIconWithKey:kPOPLayerAGKQuadBottomRight],
                         kPOPLayerAGKQuadBottomLeft : [self creatNumberIconWithKey:kPOPLayerAGKQuadBottomLeft]
                         };
    }
    return _numberIcons;
}

#pragma mark private
- (UIImageView *)addImageViewWithModel:(TJCurtainContentImagemodel *)model {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    [self addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, TJSystem2Xphone6Width(200), TJSystem2Xphone6Width(200));
    imageView.center = self.center;

    if ([model.contentImageName hasPrefix:@"http"]) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageName]];
    }else {
        imageView.image = [UIImage imageNamed:model.contentImageName];
    }

    
    CGRect frame = imageView.frame;
    [imageView.layer ensureAnchorPointIsSetToZero];
    
    imageView.layer.quadrilateral = AGKQuadMake(CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame)),
                                                      CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame)),
                                                      CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame)),
                                                      CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)));
    model.leftTopPoint     = CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame));
    model.rightTopPoint    = CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame));
    model.rightBottomPoint = CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame));
    model.leftBottomPoint  = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame));
    
    //设置4个拐角
    
    
    
    [self.models addObject:model];
    model.imageView = imageView;
    [self.imageViews addObject:imageView];
    self.CurrentImageView = imageView;
    
    [self changeNumberIconCenterWithModel:model];
    return imageView;
}

- (UILabel *)creatNumberIconWithKey:(NSString *)key {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, TJSystem2Xphone6Width(40), TJSystem2Xphone6Width(40));
    label.layer.cornerRadius = TJSystem2Xphone6Width(40) / 2;
    label.layer.masksToBounds = YES;
    label.center = self.center;
    label.hidden = !self.isShowNumbers;
    [self addSubview:label];
    
    NSString * number = @"";
    if ([key isEqualToString:kPOPLayerAGKQuadTopLeft]) {
        number = @"1";
    } else if ([key isEqualToString:kPOPLayerAGKQuadTopRight]) {
        number = @"2";
    } else if ([key isEqualToString:kPOPLayerAGKQuadBottomRight]) {
        number = @"3";
    } else if ([key isEqualToString:kPOPLayerAGKQuadBottomLeft]) {
        number = @"4";
    }
    label.text = number;
    return label;
}

- (void)changeNumberIconCenterWithModel:(TJCurtainContentImagemodel *)model {
    [self.numberIcons enumerateKeysAndObjectsUsingBlock:^(NSString * key, UILabel * obj, BOOL * _Nonnull stop) {
        obj.hidden = !self.isShowNumbers;
        [self insertSubview:obj belowSubview:model.imageView];
        
        if ([key isEqualToString:kPOPLayerAGKQuadTopLeft]) {
            obj.center = CGPointMake(model.leftTopPoint.x - TJSystem2Xphone6Width(14), model.leftTopPoint.y - TJSystem2Xphone6Width(14));
        } else if ([key isEqualToString:kPOPLayerAGKQuadTopRight]) {
            obj.center = CGPointMake(model.rightTopPoint.x + TJSystem2Xphone6Width(14), model.rightTopPoint.y - TJSystem2Xphone6Width(14));
        } else if ([key isEqualToString:kPOPLayerAGKQuadBottomRight]) {
            obj.center = CGPointMake(model.rightBottomPoint.x + TJSystem2Xphone6Width(14), model.rightBottomPoint.y + TJSystem2Xphone6Width(14));
        } else if ([key isEqualToString:kPOPLayerAGKQuadBottomLeft]) {
            obj.center = CGPointMake(model.leftBottomPoint.x - TJSystem2Xphone6Width(14), model.leftBottomPoint.y  + TJSystem2Xphone6Width(14));
        }
        
    }];
}
@end

//
//  TJCurtainContentImagemodel.h
//  omc
//
//  Created by 方焘 on 2018/3/12.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJCurtainContentImagemodel : TJBaseModel
@property (nonatomic, strong) UIImageView *imageView;
//编辑图片
@property (nonatomic, strong) NSString *contentImageName;

//当前拖拽属性
@property (nonatomic, copy) NSString *currentAnimationPreopert;

@property (nonatomic, assign) CGPoint leftTopPoint;

@property (nonatomic, assign) CGPoint rightTopPoint;

@property (nonatomic, assign) CGPoint rightBottomPoint;

@property (nonatomic, assign) CGPoint leftBottomPoint;
@end

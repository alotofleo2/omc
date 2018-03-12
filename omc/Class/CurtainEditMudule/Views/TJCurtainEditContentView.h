//
//  TJCurtainEditContentView.h
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"
#import "TJCurtainContentImagemodel.h"

@interface TJCurtainEditContentView : TJBaseView
@property (nonatomic, strong) UIImageView *backGroundImageView;

- (void)addImageWithModel:(TJCurtainContentImagemodel* )model;

- (UIImage *)getCapture;
@end

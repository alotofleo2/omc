//
//  TJSettingMainModel.h
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJSettingMainModel : TJBaseModel
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *targetControllerName;

@property (nonatomic, copy) NSString *iconImageName;

@property (nonatomic, copy) NSString *detial;
@end

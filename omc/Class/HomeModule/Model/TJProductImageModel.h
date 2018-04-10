//
//  TJProductImageModel.h
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJProductImageModel : TJBaseModel
/**图片地址*/
@property (nonatomic, copy) NSString *src;

/**高度*/
@property (nonatomic, assign) CGFloat height;

/**宽度度*/
@property (nonatomic, assign) CGFloat width;
@end

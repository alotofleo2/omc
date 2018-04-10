//
//  TJProductImageModel.m
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductImageModel.h"

@implementation TJProductImageModel
- (CGFloat)rowHeight {
    return DEVICE_SCREEN_WIDTH / self.width * self.height;
}
@end

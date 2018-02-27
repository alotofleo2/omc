//
//  TJHomeMiddleContentModel.m
//  omc
//
//  Created by 方焘 on 2018/2/27.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeMiddleContentModel.h"

@implementation TJHomeMiddleItemModel

@end

@implementation TJHomeMiddleContentModel
- (CGFloat)rowHeight {
    //内容的行数
    NSInteger multiply = (self.items.count + 1)/ 2;

    return TJHomeMiddleContentTopMargin + ((TJHomeMiddleContentItemWidth + TJHomeMiddleContentMargin) * multiply) + TJSystem2Xphone6Height(20);
}
@end

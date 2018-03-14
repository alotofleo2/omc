//
//  TJUploadBottomItem.h
//  omc
//
//  Created by 方焘 on 2018/3/14.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"

@interface TJUploadBottomItem : TJBaseView
@property (nonatomic, copy) void(^closeHandle)(NSInteger);

@property (nonatomic, copy) void(^imagePrssedHandle)(NSInteger);

- (void)setupViewWithModel:(id)model;
@end

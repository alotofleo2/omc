//
//  TJUploadListModel.h
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJUploadListModel : TJBaseModel
@property (nonatomic, copy)NSString *desc;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, copy)NSString *reason;

@property (nonatomic, copy)NSString *status;

@property (nonatomic, assign)NSInteger time;

@property (nonatomic, strong)NSArray *image;
@end

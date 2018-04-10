//
//  TJUploadListModel.h
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"
@class TJUploadListImageModel;
@interface TJUploadListModel : TJBaseModel
/**buyersShowId*/
@property (nonatomic, copy) NSString *buyersShowId;

@property (nonatomic, copy)NSString *desc;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, copy)NSString *reason;

@property (nonatomic, copy)NSString *status;

@property (nonatomic, assign)NSInteger time;

@property (nonatomic, strong)NSArray <TJUploadListImageModel *>*image;
@end

@interface TJUploadListImageModel : TJBaseModel
/**原图*/
@property (nonatomic, copy) NSString *original;

/**缩略图*/
@property (nonatomic, copy) NSString *thumb;
@end

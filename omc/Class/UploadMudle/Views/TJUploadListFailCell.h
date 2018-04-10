//
//  TJUploadListFailCell.h
//  omc
//
//  Created by 方焘 on 2018/3/25.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"
@class TJUploadListModel;
typedef  void(^reUploadHandle)(TJUploadListModel *);
typedef  void(^deleteHandle)(TJUploadListModel *);
/**
 未通过的Cell
 */
@interface TJUploadListFailCell : TJBaseTableViewCell
//重新上传的回调
@property (nonatomic, strong) reUploadHandle reuploadHandle;

//删除的回调
@property (nonatomic, copy) deleteHandle deleteHandle;
@end

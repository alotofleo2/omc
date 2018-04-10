//
//  TJUploadListHeaderView.h
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"

@interface TJUploadListHeaderView : TJBaseView
//回调 0待审核 1已上传 2 未通过
@property (nonatomic, copy) void(^buttonPressedHandle)(NSInteger);
@end

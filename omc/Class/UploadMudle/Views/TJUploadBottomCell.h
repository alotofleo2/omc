//
//  TJUploadBottomCell.h
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@class TJUploadBottomItemModel;
@interface TJUploadBottomCell : TJBaseTableViewCell
//站位相机点击事件
@property (nonatomic, copy) void(^placeHolderPressedHandle)(void);

//上传点击事件
@property (nonatomic, copy) void(^uploadPressedHandle)(void);

//照片关闭点击事件
@property (nonatomic, copy) void(^closeHandle)(NSInteger);
//照片点击事件
@property (nonatomic, copy) void(^imagePrssedHandle)(NSInteger);
@end


@interface TJUploadBottomImagesView : UIView
@property (nonatomic, strong) NSMutableArray <TJUploadBottomItemModel *> *imageModels;

//站位相机点击事件
@property (nonatomic, copy) void(^placeHolderPressedHandle)(void);

//照片关闭点击事件
@property (nonatomic, copy) void(^closeHandle)(NSInteger);
//照片点击事件
@property (nonatomic, copy) void(^imagePrssedHandle)(NSInteger);
@end

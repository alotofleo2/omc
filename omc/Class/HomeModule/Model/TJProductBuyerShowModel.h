//
//  TJProductBuyerShowModel.h
//  omc
//
//  Created by 方焘 on 2018/3/31.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

#define kMargin TJSystem2Xphone6Width(20)
#define kImageWidth ((DEVICE_SCREEN_WIDTH - kMargin * 3.5) / 4)
#define kMiddleMargin TJSystem2Xphone6Height(40)
@class TJProductBuyerShowImageModel;
@interface TJProductBuyerShowModel : TJBaseModel
/**买家秀Id*/
@property (nonatomic, copy) NSString *showsId;

/**买家描述*/
@property (nonatomic, copy) NSString *showsDesc;

/**时间*/
@property (nonatomic, copy) NSString *showsTime;

//是否需要顶部空出
@property (nonatomic, assign) BOOL isMarginTop;

@property (nonatomic, strong) NSMutableArray <TJProductBuyerShowImageModel *>*showsImage;
@end


@interface TJProductBuyerShowImageModel : TJBaseModel
/**原图*/
@property (nonatomic, copy) NSString *original;

/**缩略图*/
@property (nonatomic, copy) NSString *thumb;
@end

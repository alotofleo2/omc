//
//  TJVideoListModel.h
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJVideoListModel : TJBaseModel
//视频名字
@property (nonatomic, copy) NSString *videoName;

//视频介绍
@property (nonatomic, copy) NSString *videoDesc;

//视频地址
@property (nonatomic, copy) NSString *videoUrl;

//视频时长
@property (nonatomic, assign) NSTimeInterval videoTime;

//视频截图url
@property (nonatomic, copy) NSString *videoImage;
@end

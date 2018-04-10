//
//  TJCollectMessageManager.h
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"

@interface TJCollectMessageManager : TJBaseSharedInstance
- (void)uploadFirstDownloadApp;

- (void)uploadProductDetailStayTimeWithPorductId:(NSString *)productId
                                        stayTime:(NSTimeInterval)stayTime;
@end

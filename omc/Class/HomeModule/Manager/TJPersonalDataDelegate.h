//
//  TJPersonalDataDelegate.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPersonalView.h"

@interface TJPersonalDataDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) TJPersonalView *owner;

@property (nonatomic, strong, readonly) NSMutableArray *taskArray;

- (void)iconImageViewPressed:(UITapGestureRecognizer *)recognizer;

/**
 *  取消请求
 */
- (void)cancleTask;
@end

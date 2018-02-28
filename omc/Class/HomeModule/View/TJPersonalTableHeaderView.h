//
//  TJPersonalTableHeaderView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  个人页面的表头
 */
@interface TJPersonalTableHeaderView : UIView

@property (nonatomic, strong, readonly) UIImageView *iconImageView;

- (void)reloadData;
@end

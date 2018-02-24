//
//  TJTabBar.h
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJTabBar;

@protocol TJTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(TJTabBar *)tabBar;
@end


@interface TJTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<TJTabBarDelegate> myDelegate;

@end

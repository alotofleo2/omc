//
//  TJSearchManager.h
//  omc
//
//  Created by 方焘 on 2018/3/21.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"

@interface TJSearchManager : TJBaseSharedInstance
- (void)updateHotSearch;

- (void)startSearchInViewController:(UIViewController *)viewController;
@end

//
//  TJSearchManager.m
//  omc
//
//  Created by 方焘 on 2018/3/21.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSearchManager.h"
#import "PYSearch.h"

@interface TJSearchManager () <PYSearchViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *hotSearchs;
@end

@implementation TJSearchManager

#pragma mark - public
- (void)updateHotSearch {
    self.hotSearchs = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"].mutableCopy;
}

- (void)startSearchInViewController:(UIViewController *)viewController {
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchs searchBarPlaceholder:@"搜索你需要的商品" ];
    searchViewController.hotSearchStyle = PYHotSearchStyleNormalTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    
    searchViewController.delegate = self;
    TJNavigationController *nav = [[TJNavigationController alloc] initWithRootViewController:searchViewController];
    [viewController presentViewController:nav animated:YES completion:nil];
}


@end

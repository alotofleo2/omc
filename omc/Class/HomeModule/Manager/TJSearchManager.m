//
//  TJSearchManager.m
//  omc
//
//  Created by 方焘 on 2018/3/21.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSearchManager.h"
#import "TJCategoryProductModel.h"
#import "TJCategoryTask.h"
#import "TJHomeTask.h"
#import "PYSearch.h"

@interface TJSearchManager () <PYSearchViewControllerDelegate>
@property (nonatomic, strong) NSArray *hotSearchs;

@property (nonatomic, strong) NSMutableArray <TJCategoryProductModel *> *resultModels;
@end

@implementation TJSearchManager

#pragma mark - public
- (void)updateHotSearch {

    
    [TJHomeTask getSearchHotKeysWithSuccessBlock:^(TJResult *result) {
        
        if (result.errcode >= 200 && result.errcode < 300) {
            self.hotSearchs = result.data[@"hots"];
        }
    } failureBlock:^(TJResult *result) {
        
        self.hotSearchs = @[].mutableCopy;
    }];
}

- (void)startSearchInViewController:(UIViewController *)viewController {
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchs searchBarPlaceholder:@"搜索你需要的商品" ];
    searchViewController.hotSearchStyle = PYHotSearchStyleNormalTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    
    searchViewController.delegate = self;
    TJNavigationController *nav = [[TJNavigationController alloc] initWithRootViewController:searchViewController];
    [viewController presentViewController:nav animated:YES completion:nil];
}

#pragma private
- (void)makeSearchWithViewController:(PYSearchViewController *)searchViewController Text:(NSString *)text {
    
    [TJCategoryTask getCategoryContentWithCateId:nil keywords:text pageNumber:0 successBlock:^(TJResult *result) {
        
        if (result.errcode == 200) {
            
            self.resultModels = [TJCategoryProductModel mj_objectArrayWithKeyValuesArray:result.data];
        }
        searchViewController.searchSuggestions =  [self.resultModels mutableArrayValueForKey:@"productName"].copy;
        
    } failureBlock:^(TJResult *result) {
        
        [TJAlertUtil toastWithString:result.message];
    }];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        [self makeSearchWithViewController:searchViewController Text:searchText];
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText {
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        if (searchText.length) {
            // Simulate a send request to get a search suggestions
            [self makeSearchWithViewController:searchViewController Text:searchText];
        }
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchHistoryAtIndex:(NSInteger)index searchText:(NSString *)searchText {
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        [self makeSearchWithViewController:searchViewController Text:searchText];
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath searchBar:(UISearchBar *)searchBar {
    
    //这里由于searchViewController 没有继承与 TJBaseViewController 所以要用系统push
    Class class = NSClassFromString(@"TJDetialProductViewController");
    UIViewController *detialProductVc = [class new];
    
    [detialProductVc setValue:self.resultModels[indexPath.row].productId forKey:@"productId"];
    [searchViewController.navigationController pushViewController:detialProductVc animated:YES];

}




@end

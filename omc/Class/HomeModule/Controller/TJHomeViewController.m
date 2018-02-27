//
//  TJHomeViewController.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeViewController.h"
#import "TJHomeTopBannerCell.h"
#import "TJHomeDateManager.h"
#import "TJHomeMiddleContentCell.h"

@interface TJHomeViewController ()

@end

@implementation TJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"欧曼辰";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //消除阴影
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self registerCellWithClassName:@"TJHomeTopBannerCell" reuseIdentifier:@"TJHomeTopBannerCell"];
    [self registerCellWithClassName:@"TJHomeCategoryCell" reuseIdentifier:@"TJHomeCategoryCell"];
    [self registerCellWithClassName:@"TJHomeMiddleContentCell" reuseIdentifier:@"TJHomeMiddleContentCell"];
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTopBannerCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].bannerModels];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeCategoryCell" forIndexPath:indexPath];
            
            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainCategoryModel];
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeMiddleContentCell" forIndexPath:indexPath];

            [cell setupViewWithModel:[TJHomeDateManager sharedInstance].curtainCategoryModel];
        }
            break;
            
        default:
            break;
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heigt = 0.0;
    switch (indexPath.row) {
        case 0:
            heigt = TJSystem2Xphone6Height(250);
            break;
            
        case 1:
            heigt = DEVICE_SCREEN_WIDTH / 4 + TJSystem2Xphone6Height(103) + 2;
            break;
        case 2:
            heigt = TJSystem2Xphone6Height(600);
            break;
    }
    return heigt;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}
@end

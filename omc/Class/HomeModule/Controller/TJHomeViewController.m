//
//  TJHomeViewController.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeViewController.h"
#import "TJHomeTopBannerCell.h"

@interface TJHomeViewController ()

@end

@implementation TJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClassName:@"TJHomeTopBannerCell" reuseIdentifier:@"TJHomeTopBannerCell"];
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJHomeTopBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTopBannerCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TJSystem1080Height(500);
}

@end

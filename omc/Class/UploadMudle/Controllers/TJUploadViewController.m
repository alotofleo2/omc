
//
//  TJUploadViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadViewController.h"
#import "TJUploadNormalCell.h"

@interface TJUploadViewController ()

@end

@implementation TJUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"实景案例上传";
    [self registerCellWithClassName:@"TJUploadNormalCell" reuseIdentifier:@"TJUploadNormalCell"];
    [self registerCellWithClassName:@"TJUploadBottomCell" reuseIdentifier:@"TJUploadBottomCell"];
    
}
#pragma mark tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TJBaseTableViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadNormalCell" forIndexPath:indexPath];
        TJUploadNormalCell *normalCell =(TJUploadNormalCell *)cell;
        normalCell.placeHolderLabel.text = @"请输入产品编号";
        
    } else {
        
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadNormalCell" forIndexPath:indexPath];
            TJUploadNormalCell *normalCell =(TJUploadNormalCell *)cell;
            normalCell.placeHolderLabel.text = @"请输入文字介绍";
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadBottomCell" forIndexPath:indexPath];

        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return TJSystem2Xphone6Height(133);
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        
        return TJSystem2Xphone6Height(300);
    }else if (indexPath.row == 1 && indexPath.section == 1) {
        
        return DEVICE_SCREEN_HEIGHT - DEVICE_STATUSBAR_HEIGHT - TJSystem2Xphone6Height(470) ;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return section == 1 ? TJSystem2Xphone6Height(24): 0;
}

@end

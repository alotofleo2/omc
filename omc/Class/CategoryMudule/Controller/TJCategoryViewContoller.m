//
//  TJCategoryViewContoller.m
//  omc
//
//  Created by 方焘 on 2018/3/9.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryViewContoller.h"

@interface TJCategoryViewContoller () <UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UISearchBar *mySearchBar;
@end

@implementation TJCategoryViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMysearchBarAndMysearchDisPlay];
}
-(void)initMysearchBarAndMysearchDisPlay

{
    
    self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, DEVICE_STATUSBAR_HEIGHT, DEVICE_SCREEN_WIDTH, 44)];
    
    self.mySearchBar.delegate = self;
    
    //设置选项
    
    self.mySearchBar.barTintColor = [UIColor redColor];
    
    self.mySearchBar.searchBarStyle = UISearchBarStyleDefault;
    
    self.mySearchBar.translucent = NO; //是否半透明
    
    [self.mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [self.mySearchBar sizeToFit];
    
    
    
   UISearchDisplayController *  mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.mySearchBar contentsController:self];
    
    mySearchDisplayController.delegate = self;
    
    mySearchDisplayController.searchResultsDataSource = self;
    
    mySearchDisplayController.searchResultsDelegate = self;
    
    mySearchDisplayController.displaysSearchBarInNavigationBar = YES;
    
//    suggestResults = [NSMutableArray arrayWithArray:@[@"此处为推荐词", @"也可以为历史记录"]];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

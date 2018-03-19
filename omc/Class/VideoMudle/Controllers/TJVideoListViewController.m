//
//  TJVideoListViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

NSString *const TJVideoListCellIdertifier = @"TJVideoListCellIdertifier";

#define kVideoListItemMargin TJSystem2Xphone6Width(20)

#import "TJVideoListViewController.h"
#import "TJVideoListModel.h"
#import "TJVideoListCell.h"
#import "TJVideoTask.h"

@interface TJVideoListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *videoModels;
@end

@implementation TJVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.collectionView registerClass:[TJVideoListCell class] forCellWithReuseIdentifier:TJVideoListCellIdertifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(0);
        
    }];
    
    [self requestTableViewDataSource];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)requestTableViewDataSource {
    [self cancelTask];
    BLOCK_WEAK_SELF
    TJRequest *request = [TJVideoTask getVideoListWithSuccessBlock:^(TJResult *result) {
        
        weakSelf.videoModels = [TJVideoListModel mj_objectArrayWithKeyValuesArray:result.data];
        
        [weakSelf.collectionView reloadData];
        
    } failureBlock:^(TJResult *result) {
        
        [self showToastWithString:result.message];
    }];
    [self.taskArray addObject:request];
}
#pragma mark - 各种代理<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.videoModels.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TJVideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TJVideoListCellIdertifier forIndexPath:indexPath];
    TJVideoListModel *model = self.videoModels[indexPath.row];
    [cell setupViewWithModel:model];
    
    
    cell.imagePressedHandele = ^{
        
       NSDictionary * params = @{@"videoUrlString" : model.videoUrl};
        [[TJPageManager sharedInstance] pushViewControllerWithName:@"TJVideoPlayerViewController" params:params];
    };
    
    return cell;
}

#pragma mark - Getter
#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.itemSize = CGSizeMake((DEVICE_SCREEN_WIDTH - 3 * kVideoListItemMargin ) / 2, (DEVICE_SCREEN_HEIGHT - DEVICE_NAVIGATIONBAR_HEIGHT - DEVICE_TABBAR_HEIGHT - TJSystem2Xphone6Height(35) - kVideoListItemMargin * 3) / 3 );
        
        _layout.sectionInset = UIEdgeInsetsMake(TJSystem2Xphone6Height(35), kVideoListItemMargin, TJSystem2Xphone6Height(35), kVideoListItemMargin);
        
        _layout.minimumLineSpacing = kVideoListItemMargin;
        
        _layout.minimumInteritemSpacing = kVideoListItemMargin;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}
@end

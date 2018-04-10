//
//  TJHomeCategoryCell.m
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//
static NSString * const categoryViewIdentifier = @"categoryViewIdentifier";

#import "TJHomeCategoryCell.h"
#import "UIImageView+WebCache.h"

#pragma  mark - TJCategoryCell
@interface TJCategoryCell ()
@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) TJCategoryModel *categoryModel;
@end


@implementation TJCategoryCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
    }
    return self;
}

- (void)setupSubviews {
    self.iconImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImage];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [UIFont systemFontOfSize:11];
    self.nameLabel.textColor = UIColorFromRGB(0xdad9d3);
    [self.contentView addSubview:self.nameLabel];
}

- (void)setupLayoutSubviews {
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).mas_offset(- TJSystem2Xphone6Height(20));
        make.width.height.equalTo(@(TJSystem2Xphone6Width(100)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconImage.mas_bottom).offset(TJSystem2Xphone6Height(10));
    }];
}
- (void)setCategoryModel:(TJCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    if (categoryModel.isSelected  ) {
        
        if ([categoryModel.activeIcon hasPrefix:@"http"]) {
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:categoryModel.activeIcon]];
        } else {
            self.iconImage.image =  [UIImage imageNamed:categoryModel.activeIcon];
            
        }
        self.nameLabel.textColor = UIColorFromRGB(0x808283);
    } else {
        BLOCK_WEAK_SELF
        if ([categoryModel.activeIcon hasPrefix:@"http"]) {
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:categoryModel.inactiveIcon]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image && cacheType == SDImageCacheTypeNone) {
                    CATransition *transition = [CATransition animation];
                    transition.type = kCATransitionFade;
                    transition.duration = 0.3;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    [weakSelf.iconImage.layer addAnimation:transition forKey:nil];
                }
            }];
        } else {
            
            self.iconImage.image = [UIImage imageNamed:categoryModel.inactiveIcon];
            
        }
        self.nameLabel.textColor = UIColorFromRGB(0xdad9d3);
    }
    
    
    
    self.nameLabel.text = categoryModel.name;
    
}
@end

//------------------------------------------------------------------------------------------------
#pragma mark - TJHomeCategoryCell
@interface TJHomeCategoryCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) TJHomeCategoryModel *HomeCategorymodel;

@end

@implementation TJHomeCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    //添加collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.collectionView registerClass:[TJCategoryCell class] forCellWithReuseIdentifier:categoryViewIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    //添加titleLabel
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    //添加imageView
    self.titleImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.titleImageView];
    self.titleImageView.image = [UIImage imageNamed:@"xinpintuijian"];
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //lineView
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = UIColorFromRGB(0xf1f2f6);
    [self.contentView addSubview:self.lineView];
}

- (void)setupLayoutSubviews {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_top).mas_offset(TJSystem2Xphone6Height(103) / 2);
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(15));
        make.width.equalTo(@(TJSystem2Xphone6Width(219)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@(1));
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(TJSystem2Xphone6Height(103));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.lineView.mas_bottom);
        
    }];
    
}
- (void)setupViewWithModel:(TJHomeCategoryModel *)model {
    
    self.HomeCategorymodel = model;
    
    self.titleLabel.text = model.cateName;
    [self.titleImageView sizeToFit];
    
    [self.collectionView reloadData];
    
}

#pragma mark - Getter
#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.itemSize = CGSizeMake(DEVICE_SCREEN_WIDTH / 4, DEVICE_SCREEN_WIDTH / 4);
        
        _layout.minimumLineSpacing = 0;
        
        _layout.minimumInteritemSpacing = 0;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

#pragma mark - 各种代理<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.HomeCategorymodel.categoryModels.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TJCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryViewIdentifier forIndexPath:indexPath];

    cell.categoryModel = self.HomeCategorymodel.categoryModels[indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //状态改变
    [self selectedWithIndex:indexPath.row];
    
    //回调
    if (self.itemActionHandle) {
        self.itemActionHandle(indexPath.row);
    }
}
#pragma mark prvite
- (void)selectedWithIndex:(NSInteger)index {
    if (index == 0) {
        
        return;
    }
    for (int i = 1; i< self.HomeCategorymodel.categoryModels.count; i++) {
        self.HomeCategorymodel.categoryModels[i].isSelected = index == i;
    }

    [self.collectionView reloadData];

}
@end



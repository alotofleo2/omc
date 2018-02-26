//
//  TJHomeDateManager.m
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeDateManager.h"

@implementation TJHomeDateManager
- (NSMutableArray<TJHomeBannerModel *> *)bannerModels {
    if (!_bannerModels) {
        _bannerModels = [NSMutableArray arrayWithCapacity:6];
        
        for (int i = 0; i < 6; i++) {
            
            TJHomeBannerModel *model = [[TJHomeBannerModel alloc]init];
            model.imageUrl = @"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
            [_bannerModels addObject:model];
        }
        
    }
    return _bannerModels;
}
- (TJHomeCategoryModel *)curtainCategoryModel {
    if (!_curtainCategoryModel) {
        
        _curtainCategoryModel = [[TJHomeCategoryModel alloc]init];
        _curtainCategoryModel.titleImageName = @"xinpintuijian";
        
        NSMutableArray *categoryModels = [NSMutableArray arrayWithCapacity:4];
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部"];
        firstModel.isSelected = YES;
        [categoryModels addObject:firstModel];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"ertongfnag" selectedImageName:@"ertongfang_selected" titleName:@"卡通房"]];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shufang" selectedImageName:@"shufang_selected" titleName:@"书房"]];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shangyekongjian" selectedImageName:@"shangyekongjian_selected" titleName:@"商业空间"]];
        
        
        _curtainCategoryModel.categoryModels = categoryModels;
        
    }
    return _curtainCategoryModel;
}
- (TJCategoryModel *)creatCategoryModelWithNormalImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName titleName:(NSString *)titleName {
    TJCategoryModel *model = [[TJCategoryModel alloc]init];
    
    model.iconImageName = imageName;
    
    model.selectedIconImageName = selectedImageName;
    
    model.titleName = titleName;
    
    return model;
}
@end

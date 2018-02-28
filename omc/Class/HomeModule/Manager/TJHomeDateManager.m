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
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        firstModel.isSelected = YES;
        [categoryModels addObject:firstModel];
        TJCategoryModel *secendModel =[self creatCategoryModelWithNormalImageName:@"ertongfnag" selectedImageName:@"ertongfang_selected" titleName:@"卡通房" categoryNumb:1];
        secendModel.isSelected = YES;
        [categoryModels addObject:secendModel];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shufang" selectedImageName:@"shufang_selected" titleName:@"书房" categoryNumb:2]];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shangyekongjian" selectedImageName:@"shangyekongjian_selected" titleName:@"商业空间" categoryNumb:3]];
        
        
        _curtainCategoryModel.categoryModels = categoryModels;
        
    }
    return _curtainCategoryModel;
}
- (TJCategoryModel *)creatCategoryModelWithNormalImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName titleName:(NSString *)titleName categoryNumb:(NSInteger)categoryNumb{
    TJCategoryModel *model = [[TJCategoryModel alloc]init];
    
    model.iconImageName = imageName;
    
    model.selectedIconImageName = selectedImageName;
    
    model.titleName = titleName;
    
    model.categoryNumb = categoryNumb;
    
    return model;
}


- (TJHomeMiddleContentModel *)curtainContentModel {
    if (!_curtainContentModel) {
        _curtainContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainContentModel.titleName = @"热销窗帘";
        _curtainContentModel.items = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < 6; i++) {
            TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
            
            model.imageUrl =@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
            model.titleName =@"雨后星晴";
            model.number = @"123123123";
            [_curtainContentModel.items addObject:model];
        }
    }
    return _curtainContentModel;
}

- (TJHomeCategoryModel *)curtainHeadCategoryModel {
    if (!_curtainHeadCategoryModel) {
        
        _curtainHeadCategoryModel = [[TJHomeCategoryModel alloc]init];
        _curtainHeadCategoryModel.titleImageName = @"xinpintuijian";
        
        NSMutableArray *categoryModels = [NSMutableArray arrayWithCapacity:4];
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        firstModel.isSelected = YES;
        [categoryModels addObject:firstModel];
        TJCategoryModel *secendModel =[self creatCategoryModelWithNormalImageName:@"ertongfnag" selectedImageName:@"ertongfang_selected" titleName:@"卡通房" categoryNumb:1];
        secendModel.isSelected = YES;
        [categoryModels addObject:secendModel];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shufang" selectedImageName:@"shufang_selected" titleName:@"书房" categoryNumb:2]];
        
        
        _curtainHeadCategoryModel.categoryModels = categoryModels;
        
    }
    return _curtainHeadCategoryModel;
}

- (TJHomeMiddleContentModel *)curtainHeadContentModel {
    if (!_curtainHeadContentModel) {
        _curtainHeadContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainHeadContentModel.titleName = @"热销窗帘";
        _curtainHeadContentModel.items = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < 6; i++) {
            TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
            
            model.imageUrl =@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
            model.titleName =@"雨后星晴";
            model.number = @"123123123";
            [_curtainHeadContentModel.items addObject:model];
        }
    }
    return _curtainHeadContentModel;
}
#pragma mark 窗帘头部分类请求
- (void)requestCurtainCategoryWithCompleteHandle:(void(^)(void))completeHandle {
    if (completeHandle) {
        completeHandle();
    }
}

#pragma mark  窗帘内容请求
- (void)requestCurtainContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle {
    _curtainContentModel = [[TJHomeMiddleContentModel alloc]init];
    _curtainContentModel.titleName = @"热销窗帘";
    _curtainContentModel.items = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < categoryNumb + 2; i++) {
        TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
        
        model.imageUrl =@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
        model.titleName =@"雨后星晴";
        model.number = @"123123123";
        [_curtainContentModel.items addObject:model];
    }
    if (completeHandle) {
        completeHandle();
    }
}
#pragma mark 窗头头部分类请求
- (void)requestCurtainHeadCategoryWithCompleteHandle:(void(^)(void))completeHandle {
    if (completeHandle) {
        completeHandle();
    }
}

#pragma mark  窗头内容请求
- (void)requestCurtainHeadContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle {
    
    _curtainHeadContentModel = [[TJHomeMiddleContentModel alloc]init];
    _curtainHeadContentModel.titleName = @"热销窗头";
    _curtainHeadContentModel.items = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < categoryNumb + 3; i++) {
        TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
        
        model.imageUrl = @"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
        model.titleName = @"雨后星晴";
        model.number = @"123123123";
        [_curtainHeadContentModel.items addObject:model];
    }
    
    if (completeHandle) {
        completeHandle();
    }
}
@end

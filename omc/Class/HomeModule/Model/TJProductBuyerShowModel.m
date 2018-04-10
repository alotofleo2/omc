//
//  TJProductBuyerShowModel.m
//  omc
//
//  Created by 方焘 on 2018/3/31.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductBuyerShowModel.h"

@implementation TJProductBuyerShowModel
-(void)setShowsImage:(NSMutableArray<TJProductBuyerShowImageModel *> *)showsImage {
    NSMutableArray *imageItemModelArr = [NSMutableArray arrayWithCapacity:showsImage.count];
    for (NSDictionary *imageItem in showsImage) {
        TJProductBuyerShowImageModel *imageModel = [[TJProductBuyerShowImageModel alloc]init];
        if ([imageItem valueForKey:@"original"]) {
            imageModel.original = imageItem[@"original"];
        }
        if ([imageItem valueForKey:@"thumb"]) {
            imageModel.thumb = imageItem[@"thumb"];
        }
        [imageItemModelArr addObject:imageModel];
    }
    _showsImage = imageItemModelArr.copy;
}

- (CGFloat)rowHeight {
    
    CGSize DescSize = [self.showsDesc boundingRectWithSize:CGSizeMake(DEVICE_SCREEN_WIDTH - 2 *kMargin, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]]} context:nil].size;
    
    CGFloat bottomHeight = DescSize.height + 3 * kMiddleMargin + TJSystem2Xphone6Height(36);
    CGFloat imageHeight =  (kMargin + kImageWidth) * (self.showsImage.count / 4 + 1)  ;
    
    return bottomHeight + imageHeight;
}
@end

@implementation TJProductBuyerShowImageModel
@end

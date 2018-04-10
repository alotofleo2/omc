//
//  TJUploadListModel.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListModel.h"

@implementation TJUploadListModel

- (void)setImage:(NSArray *)image {
    
    NSMutableArray *imageItemModelArr = [NSMutableArray arrayWithCapacity:image.count];
    for (NSDictionary *imageItem in image) {
        TJUploadListImageModel *imageModel = [[TJUploadListImageModel alloc]init];
        if ([imageItem valueForKey:@"original"]) {
            imageModel.original = imageItem[@"original"];
        }
        if ([imageItem valueForKey:@"thumb"]) {
            imageModel.thumb = imageItem[@"thumb"];
        }
        [imageItemModelArr addObject:imageModel];
    }
    _image = imageItemModelArr.copy;
}

@end
@implementation TJUploadListImageModel

@end

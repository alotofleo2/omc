//
//  TJBaseView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseView.h"

@implementation TJBaseView

+ (instancetype)viewFromNib {
    
    return [self viewFromNibWithIndex:0];
}

+ (instancetype)viewFromNibWithIndex:(NSInteger)index {
    
    NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    if ([nibs count] <= index) {
        return nil;
    }
    
    id view = [nibs objectAtIndex:index];
    
    if (!view) {
        return nil;
    }
    return view;
}

- (void)setupViewWithModel:(id)model {
    
}
@end

//
//  TJHomeTopBannerCell.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeTopBannerCell.h"


@interface TJHomeTopBannerCell ()

@end

@implementation TJHomeTopBannerCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    self.backgroundColor = [UIColor redColor];
}

- (void)setupLayoutSubviews {
    
}
@end

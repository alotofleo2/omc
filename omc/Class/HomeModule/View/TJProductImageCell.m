//
//  TJProductImageCell.m
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductImageCell.h"
#import "TJProductImageModel.h"
@interface TJProductImageCell ()
@property (nonatomic, strong) UIImageView *displayImageView;
@end

@implementation TJProductImageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    
    self.displayImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.displayImageView];

    
}

- (void)setupLayoutSubviews {
    
    [self.displayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_offset(0);
    }];

    
}

- (void)setupViewWithModel:(TJProductImageModel *)model {
    BLOCK_WEAK_SELF
    [self.displayImageView sd_setImageWithURL:[NSURL URLWithString:model.src] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakSelf.displayImageView.layer addAnimation:transition forKey:nil];
        }
    }];
}
@end

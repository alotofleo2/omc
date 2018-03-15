//
//  TJUploadListCell.m
//  omc
//
//  Created by 方焘 on 2018/3/15.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListCell.h"
#import "TJUploadListModel.h"
#import "UIImageView+WebCache.h"

#define kMargin TJSystem2Xphone6Width(20)
#define kImageWidth ((DEVICE_SCREEN_WIDTH - kMargin * 3.5) / 4)

@interface TJUploadListCell ()
@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *timeIconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray *imageViews;
@end

@implementation TJUploadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.imageViews = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)setupSubviews {
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.textColor = [UIColor blackColor];
    self.titlelabel.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    self.titlelabel.numberOfLines = 0;
    [self.contentView addSubview:self.titlelabel];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.textColor = UIColorFromRGB(0xb8b8b8);
    self.numberLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.numberLabel];
    
    self.timeIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:self.timeIconImageView];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = UIColorFromRGB(0xb8b8b8);
    self.timeLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.timeLabel];
    
}

- (void)setupLayoutSubviews {
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_offset(kMargin);
        make.top.mas_offset(TJSystem2Xphone6Height(30));
        make.right.mas_offset(-kMargin);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_offset(- kMargin);
        make.bottom.mas_offset(TJSystem2Xphone6Height(30));
    }];
    
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.timeLabel.mas_left).mas_offset(- TJSystem2Xphone6Width(10));
        make.centerY.equalTo(self.timeLabel);
        make.height.width.equalTo(@(TJSystem2Xphone6Width(36)));
    }];
    
}

- (void)setupViewWithModel:(TJUploadListModel *)model {
    NSLog(@"%@", model.image);
    for (UIImageView *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
    
    for (NSString *imageUrl in model.image) {
      UIImageView *imageView =  [self createImageViewWithImageName:imageUrl];
        [self.contentView addSubview:imageView];
        [self.imageViews addObject:imageView];
        NSInteger index = [model.image indexOfObject:imageUrl];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.height.equalTo(@(kImageWidth));
            make.top.equalTo(self.titlelabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(35) + (kImageWidth + kMargin / 2) *(index / 4));
            make.left.mas_offset(kMargin + (kImageWidth + kMargin / 2) * (index % 4));
        }];
    }
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (model.image.count > 0) {
            
        }
    }];
}

- (UIImageView *)createImageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""]];
    
    return imageView;
}
@end

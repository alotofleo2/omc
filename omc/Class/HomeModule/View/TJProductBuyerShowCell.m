//
//  TJProductBuyerShowCell.m
//  omc
//
//  Created by 方焘 on 2018/3/31.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductBuyerShowCell.h"
#import "TJProductBuyerShowModel.h"
#import "UIImageView+WebCache.h"
#import "SCPictureBrowser.h"


@interface TJProductBuyerShowCell ()<SCPictureBrowserDelegate>

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) UIImageView *timeIconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation TJProductBuyerShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.imageViews = [NSMutableArray arrayWithCapacity:0];
        
        self.items = [NSMutableArray arrayWithCapacity:0];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setupSubviews {
    
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backGroundView];
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.textColor = [UIColor blackColor];
    self.titlelabel.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    self.titlelabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.titlelabel];
    
    
    self.timeIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"upLoad_time"]];
    [self.backGroundView addSubview:self.timeIconImageView];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = UIColorFromRGB(0xb8b8b8);
    self.timeLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.backGroundView addSubview:self.timeLabel];
    
}

- (void)setupLayoutSubviews {
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(self.contentView);
        
    }];
    

    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_offset(kMargin);
        make.bottom.equalTo(self.timeLabel.mas_top).mas_offset(- kMiddleMargin);
        make.right.mas_offset(-kMargin);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_offset( - kMiddleMargin);
    }];
    
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.timeLabel.mas_left).mas_offset(- TJSystem2Xphone6Width(10));
        make.centerY.equalTo(self.timeLabel);
        make.left.mas_offset(kMargin);
        make.height.width.equalTo(@(TJSystem2Xphone6Width(36)));
    }];
    
}

- (void)setupViewWithModel:(TJProductBuyerShowModel *)model {
    //删除imageview
    for (UIImageView *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
    [self.items removeAllObjects];
    
    //重新创建imageview
    for (TJProductBuyerShowImageModel *imageUrl in model.showsImage) {
        UIImageView *imageView =  [self createImageViewWithImageName:imageUrl.thumb];
        [self.backGroundView addSubview:imageView];
        [self.imageViews addObject:imageView];
        NSInteger index = [model.showsImage indexOfObject:imageUrl];
        //imageview 约束
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.equalTo(@(kImageWidth));
            make.top.equalTo(self.backGroundView).mas_offset(kMargin + (kImageWidth + kMargin) *(index / 4));
            make.left.mas_offset(kMargin + (kImageWidth + kMargin / 2) * (index % 4));
        }];
        
        //添加图片浏览模型数组
        SCPictureItem *item = [[SCPictureItem alloc] init];
        item.url = [NSURL URLWithString:imageUrl.original];
        
        // 如果sourceView为nil，则以其他动画开启和关闭
        item.sourceView = imageView;
        [self.items addObject:item];
    }
    
    //设置数据
    self.titlelabel.text = model.showsDesc;
    
    if (model.showsTime != nil) {
        
        NSTimeInterval interval    = [model.showsTime doubleValue];
        NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd"];
        self.timeLabel.text = [formatter stringFromDate: date];
    }
    
    //设置顶部是否偏离
    [self.backGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.contentView);
        make.top.mas_offset(model.isMarginTop ? TJSystem2Xphone6Height(24) : 0);
    }];
}
- (UIImageView *)createImageViewWithImageName:(NSString *)imageName {
    BLOCK_WEAK_SELF
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        for (SCPictureItem *item in weakSelf.items) {
            if (item.sourceView == imageView) {
                item.originImage = image;
                break;
            }
        }
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [imageView.layer addAnimation:transition forKey:nil];
        }
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagePressed:)];
    [imageView addGestureRecognizer:gesture];
    return imageView;
}

- (void)imagePressed:(UITapGestureRecognizer *)recognizer {
    SCPictureBrowser *browser = [[SCPictureBrowser alloc] init];
    browser.delegate = self;
    browser.items = self.items;
    browser.index = [self.imageViews indexOfObject:(UIImageView *)recognizer.view];
    browser.numberOfPrefetchURLs = 2;
    browser.supportDelete = YES;
    [browser show];
}
@end

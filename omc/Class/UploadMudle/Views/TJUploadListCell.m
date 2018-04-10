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
#import "SCPictureBrowser.h"

#define kMargin TJSystem2Xphone6Width(20)
#define kImageWidth ((DEVICE_SCREEN_WIDTH - kMargin * 3.5) / 4)

@interface TJUploadListCell ()<SCPictureBrowserDelegate>
@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *timeIconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation TJUploadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
        self.imageViews = [NSMutableArray arrayWithCapacity:0];
        
        self.items = [NSMutableArray arrayWithCapacity:0];
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
    
    self.timeIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"upLoad_time"]];
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
        make.bottom.mas_offset( - TJSystem2Xphone6Height(30));
    }];
    
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.timeLabel.mas_left).mas_offset(- TJSystem2Xphone6Width(10));
        make.centerY.equalTo(self.timeLabel);
        make.height.width.equalTo(@(TJSystem2Xphone6Width(36)));
    }];
    
}

- (void)setupViewWithModel:(TJUploadListModel *)model {
    
    //删除imageview
    for (UIImageView *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
    [self.items removeAllObjects];
    
    //重新创建imageview
    for (TJUploadListImageModel *imageUrl in model.image) {
      UIImageView *imageView =  [self createImageViewWithImageName:imageUrl.thumb];
        [self.contentView addSubview:imageView];
        [self.imageViews addObject:imageView];
        NSInteger index = [model.image indexOfObject:imageUrl];
        //imageview 约束
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.height.equalTo(@(kImageWidth));
            make.top.equalTo(self.titlelabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(35) + (kImageWidth + kMargin / 2) *(index / 4));
            make.left.mas_offset(kMargin + (kImageWidth + kMargin / 2) * (index % 4));
        }];
        
        //添加图片浏览模型数组
        SCPictureItem *item = [[SCPictureItem alloc] init];
        item.url = [NSURL URLWithString:imageUrl.original];
        
        
        // 如果sourceView为nil，则以其他动画开启和关闭
        item.sourceView = imageView;
        [self.items addObject:item];
    }
    //从新设置底部view
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-TJSystem2Xphone6Height(30));
        make.left.mas_offset(kMargin);
        if (model.image.count > 0) {
            make.top.equalTo(self.imageViews.lastObject.mas_bottom).mas_offset(TJSystem2Xphone6Height(40));
        } else {
             make.top.equalTo(self.titlelabel).mas_offset(TJSystem2Xphone6Height(40));
        }
    }];
    
    //设置数据
    self.titlelabel.text = model.desc;
    self.numberLabel.text = [NSString stringWithFormat:@"窗帘编号:%@", model.number];
    
    NSTimeInterval interval    = model.time;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    self.timeLabel.text = [formatter stringFromDate: date];
}

- (UIImageView *)createImageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc]init];
    BLOCK_WEAK_SELF
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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
    browser.supportDelete = NO;
    [browser show];
}
@end

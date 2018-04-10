//
//  TJUploadListFailCell.m
//  omc
//
//  Created by 方焘 on 2018/3/25.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadListFailCell.h"
#import "TJUploadListModel.h"
#import "UIImageView+WebCache.h"
#import "SCPictureBrowser.h"

#define kMargin TJSystem2Xphone6Width(20)
#define kImageWidth ((DEVICE_SCREEN_WIDTH - kMargin * 3.5) / 4)
@interface TJUploadListFailCell () <SCPictureBrowserDelegate>

@property (nonatomic, strong) TJUploadListModel *model;

@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *timeIconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *failReasonLabel;
@end
@implementation TJUploadListFailCell

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
    
    [self.contentView addSubview:self.bottomView];
    
}

- (void)setupLayoutSubviews {
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_offset(kMargin);
        make.top.equalTo(self.timeLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(40));
        make.right.mas_offset(-kMargin);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_offset(- kMargin);
        make.top.mas_offset(TJSystem2Xphone6Height(38));
    }];
    
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.timeLabel.mas_left).mas_offset(- TJSystem2Xphone6Width(10));
        make.centerY.equalTo(self.timeLabel);
        make.height.width.equalTo(@(TJSystem2Xphone6Width(36)));
    }];
    
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.timeLabel);
        make.left.mas_offset(kMargin);

    }];
    
}

- (void)setupViewWithModel:(TJUploadListModel *)model {
    
    _model = model;
    
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
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(TJSystem2Xphone6Height(168)));
        if (model.image.count > 0) {
            make.top.equalTo(self.imageViews.lastObject.mas_bottom);
        } else {
            make.top.equalTo(self.titlelabel);
        }
    }];
    
    //设置数据
    self.titlelabel.text = model.desc;
    self.numberLabel.text = [NSString stringWithFormat:@"窗帘编号:%@", model.number];
    if (model.reason.length > 0) {
        self.failReasonLabel.text = model.reason;
    }
    
    NSTimeInterval interval    = model.time;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    self.timeLabel.text = [formatter stringFromDate: date];
}

#pragma mark - getter
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        
        //未通过icon
        UIImageView *icon = [[UIImageView alloc]init];
        icon.image = [UIImage imageNamed:@"upLoad_time"];
        [_bottomView addSubview:icon];

        //未通过label
        UILabel *failLabel = [[UILabel alloc]init];
        failLabel.text = @"未通过原因";
        failLabel.textColor = UIColorFromRGB(0xb9b9b9);
        failLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
        [_bottomView addSubview:failLabel];
        
        UILabel *failReasonLabel = [[UILabel alloc]init];
        failReasonLabel.textColor = UIColorFromRGB(0xfe0200);
        failReasonLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
        self.failReasonLabel = failReasonLabel;
        [_bottomView addSubview:failReasonLabel];
        
        UILabel *reUploadLabel = [[UILabel alloc]init];
        reUploadLabel.textColor = [UIColor whiteColor];
        reUploadLabel.text = @"重新上传";
        reUploadLabel.textAlignment = NSTextAlignmentCenter;
        reUploadLabel.font = [UIFont systemFontOfSize:14 * [TJAdaptiveManager adaptiveScale]];
        reUploadLabel.userInteractionEnabled = YES;
        reUploadLabel.backgroundColor = [UIColor blackColor];
        reUploadLabel.layer.cornerRadius = 4;
        reUploadLabel.layer.masksToBounds = YES;
        reUploadLabel.layer.shouldRasterize = YES;
        reUploadLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
        UITapGestureRecognizer *reUploadGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reUploadPressed)];
        [reUploadLabel addGestureRecognizer:reUploadGesture];
        [_bottomView addSubview:reUploadLabel];
        
        
        UILabel *deleteLabel = [[UILabel alloc]init];
        deleteLabel.textColor = [UIColor blackColor];
        deleteLabel.text = @"删除";
        deleteLabel.font = [UIFont systemFontOfSize:14 * [TJAdaptiveManager adaptiveScale]];
        deleteLabel.textAlignment = NSTextAlignmentCenter;
        deleteLabel.userInteractionEnabled = YES;
        deleteLabel.layer.cornerRadius = 4;
        deleteLabel.layer.masksToBounds = YES;
        deleteLabel.layer.shouldRasterize = YES;
        deleteLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
        deleteLabel.layer.borderColor = UIColorFromRGB(0xb9b9b9).CGColor;
        deleteLabel.layer.borderWidth = 0.5;
        UITapGestureRecognizer *deleteLabelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deletePressed)];
        [deleteLabel addGestureRecognizer:deleteLabelGesture];
        [_bottomView addSubview:deleteLabel];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_offset(kMargin);
            make.top.mas_offset(TJSystem2Xphone6Height(30));
            make.height.width.equalTo(@(TJSystem2Xphone6Width(36)));
        }];
        
        [failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(icon);
            make.left.equalTo(icon.mas_right).mas_offset(TJSystem2Xphone6Width(10));
        }];
        
        [failReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(icon.mas_bottom).mas_offset(TJSystem2Xphone6Height(40));
            make.left.mas_offset(kMargin);
        }];
        
        [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(failReasonLabel);
            make.height.equalTo(@(TJSystem2Xphone6Height(60)));
            make.width.equalTo(@(TJSystem2Xphone6Width(90)));
            make.right.mas_offset(- kMargin);
        }];
        
        [reUploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(failReasonLabel);
            make.height.equalTo(@(TJSystem2Xphone6Height(60)));
            make.width.equalTo(@(TJSystem2Xphone6Width(135)));
            make.right.equalTo(deleteLabel.mas_left).mas_offset(- kMargin);
        }];
        
    }
    return _bottomView;
}
#pragma mark - private
- (UIImageView *)createImageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc]init];
    BLOCK_WEAK_SELF
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
#pragma mark - 点击事件
- (void)reUploadPressed {
    if (self.reuploadHandle) {
        self.reuploadHandle(self.model);
    }
}

- (void)deletePressed {
    if (self.deleteHandle) {
        self.deleteHandle(self.model);
    }
}
@end

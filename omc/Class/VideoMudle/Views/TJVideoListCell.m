//
//  TJVideoListCell.m
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJVideoListCell.h"
#import "TJVideoListModel.h"
#import <AVFoundation/AVFoundation.h>

@interface TJVideoListCell ()
@property (nonatomic, strong) UIImageView *videoImageView;

@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detialLabel;
@end

@implementation TJVideoListCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
    }
    return self;
}

- (void)setupSubviews {
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.videoImageView = [[UIImageView alloc]init];
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.videoImageView.layer.cornerRadius = 4;
    self.videoImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.videoImageView];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont systemFontOfSize:10 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.timeLabel];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.actionButton setImage:[UIImage imageNamed:@"video_action"] forState:UIControlStateNormal];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = UIColorFromRGB(0x696a67);
    self.titleLabel.font = [UIFont systemFontOfSize:13 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.titleLabel];
    
    self.detialLabel = [[UILabel alloc]init];
    self.detialLabel.textColor = UIColorFromRGB(0xa0a0a0);
    self.detialLabel.font = [UIFont systemFontOfSize:12 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.detialLabel];
}

- (void)setupLayoutSubviews {
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.videoImageView.mas_width).multipliedBy(215.f / 341.f);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.videoImageView.mas_bottom).mas_offset(- TJSystem2Xphone6Width(10));
        make.left.equalTo(self.videoImageView).mas_offset(TJSystem2Xphone6Width(10));
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.videoImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.videoImageView.mas_bottom).mas_offset(TJSystem2Xphone6Height(26));
    }];
    
    [self.detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(26));
    }];
}

- (void)setupViewWithModel:(TJVideoListModel *)model {
    BLOCK_WEAK_SELF
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.videoImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakSelf.videoImageView.layer addAnimation:transition forKey:nil];
        }

    }];
    
    self.titleLabel.text = model.videoName;
    
    self.detialLabel.text = model.videoDesc;
    
    self.timeLabel.text = @"00:00";
    
    //设置图片
    //读取缓存文件
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithUrlString:model.videoUrl]];
    NSLog(@"%@", plistDic[@"timeString"]);
    if ([plistDic valueForKey:@"timeString"]) {
//        NSData *data = [[NSData alloc]initWithBase64EncodedString:[plistDic valueForKey:@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        self.videoImageView.image = [UIImage imageWithData:data];
        
        self.timeLabel.text = [plistDic valueForKey:@"timeString"];
        
    } else {
        [TJGCDManager asyncGlobalQueueThreadBlock:^{
            //获取视频时长
            NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                             forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
            AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:model.videoUrl] options:opts];  // 初始化视频媒体文件
            NSInteger  minute = 0, second = 0;
            second = (NSInteger)urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
            //NSLog(@"movie duration : %d", second);
            if (second >= 60) {
                NSInteger index = second / 60;
                minute = index;
                second = second - index*60;
            }
            
            //从网络获取
//            UIImage *image = [weakSelf thumbnailImageForVideo:[NSURL URLWithString:model.videoUrl] atTime:1];
            //缓存图片
            [self cacheImageWithImage:nil urlString:model.videoUrl timeString:[NSString stringWithFormat:@"%02ld:%02ld", (long)minute, (long)second]];
            //转主线程设置图片和时间
            [TJGCDManager asyncMainThreadBlock:^{
//                self.videoImageView.image = image;
                weakSelf.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minute, (long)second];
            }];
        }];
        
    }
}
#pragma mark 点击事件
- (void)actionButtonPressed {
    
    if (self.imagePressedHandele) {
        self.imagePressedHandele();
    }
}

- (void)cacheImageWithImage:(UIImage *)image urlString:(NSString *)urlString timeString:(NSString *)timeString {

    
    NSMutableDictionary *addDic = @{@"timeString" : timeString ?: @""}.mutableCopy;
    if (image) {
        
        NSData *data = UIImagePNGRepresentation(image);
        NSString *base64StringImage = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        addDic[@"image"] = base64StringImage;
    }
    NSString *filePath = [self getFilePathWithUrlString:urlString];
    //将字典写入文件
    [TJGCDManager asyncGlobalQueueThreadBlock:^{
        
        [addDic writeToFile:filePath atomically:YES];
    }];

}

- (NSString *)getFilePathWithUrlString:(NSString *)urlString {
    //将字典保存到document文件->获取appdocument路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //截取文件名
    NSRange range = NSMakeRange(urlString.length - 36, 32);
    NSString *douName =  [urlString substringWithRange:range];
    //要创建的plist文件名 -> 路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", douName]];
    return filePath;
}

- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}
@end

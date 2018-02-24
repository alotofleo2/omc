//
//  UIImage+Extension.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenScale ([UIScreen mainScreen].scale)


#define MAX_IMAGEPIX 600.0          // max pix 600.0px
#define MAX_IMAGEDATA_LEN 100000.0   // max data length 100K


#define MAX_IMAGEPIX 600.0          // max pix 600.0px
#define MAX_IMAGEDATA_LEN 100000.0   // max data length 100K

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius)
{
    return cornerRadius * 2 + 1;
}


@implementation UIImage (Extension)


#pragma mark -
#pragma mark Public Methods
#pragma mark 根据UIColor生成UIImage
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}


#pragma mark 根据UIColor生成指定大小的UIImage
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage * theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark 根据UIColor和cornerRadius生成圆角的UIImage
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}


#pragma mark 生成返回按钮图片
+ (UIImage *)backButtonImageWithColor:(UIColor *)color barMetrics:(UIBarMetrics)metrics cornerRadius:(CGFloat)cornerRadius
{
    CGSize size;
    
    if (metrics == UIBarMetricsDefault)
    {
        size = CGSizeMake(50, 30);
        
    } else {
        
        size = CGSizeMake(60, 23);
    }
    
    UIBezierPath * path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [path addClip];
    [path fill];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, 15, cornerRadius, cornerRadius)];
}


#pragma mark 生成毛玻璃效果的图片
- (UIImage *)imageWithBlur
{
    return [self imageWithalpha:0.1 radius:10 colorSaturationFactor:1];
}


#pragma mark 生成自定义毛玻璃效果的图片
- (UIImage *)imageWithalpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor
{
    UIColor * tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    return [self imageBluredWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}


+ (UIImage *)screenshots
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth * kScreenScale, kScreenHeight * kScreenScale), YES, 0);
    
    // 设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, kScreenWidth * kScreenScale, kScreenHeight * kScreenScale);
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return sendImage;
}


#pragma mark 根据maxImagePix设定的图片最大显示像素压缩图片
- (UIImage *)compressedImage:(float)maxImagePix
{
    if (maxImagePix < 0 || maxImagePix > 1000.0)
    {
        maxImagePix = MAX_IMAGEPIX;
    }
    
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= maxImagePix && height <= maxImagePix)
    {
        // 无需压缩
        return self;
    }
    
    if (width == 0 || height == 0)
    {
        // void zero exception
        return self;
    }
    
    UIImage * newImage = nil;
    
    
    CGFloat widthFactor = maxImagePix / width;
    CGFloat heightFactor = maxImagePix / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    // 等比例缩放
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    // 重绘图片
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark 根据compressionQuality缩放比率压缩图片并返回NSData数据
- (NSData *)compressedData:(CGFloat)compressionQuality
{
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    
    return UIImageJPEGRepresentation(self, compressionQuality);
}


#pragma mark -
#pragma mark Private Methods
#pragma mark 计算图片需要被压缩的比率
- (CGFloat)compressionQuality
{
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    
    NSUInteger dataLength = [data length];
    
    if(dataLength > MAX_IMAGEDATA_LEN)
    {
        return 1.0 - MAX_IMAGEDATA_LEN / dataLength;
        
    } else {
        
        return 1.0;
    }
}


#pragma mark 根据计算所得的图片压缩比率压缩图片
- (NSData *)compressedData
{
    CGFloat quality = [self compressionQuality];
    return [self compressedData:quality];
}


+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:(float)M_PI + (float)M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:(float)M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + (10.0f);
    [path addLineToPoint:mPoint];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    mPoint.y = rect.origin.y;
    [path addLineToPoint:mPoint];
    
    [path closePath];
    return path;
}


#pragma mark 圆形图片裁剪
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            
            unsigned int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        
        BOOL effectImageBuffersAreSwapped = NO;
        
        if (hasSaturationChange) {
            
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            
            if (hasBlur) {
                
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
                
            } else {
                
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        
        
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, kScreenScale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


@end

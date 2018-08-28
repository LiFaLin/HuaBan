//
//  CRGradientLabel.m
//  CRGradientLabel
//
//  Created by Christian Roman on 4/1/14.
//  Copyright (c) 2014 Christian Roman. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CRGradientImage.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
@implementation UIImage (GradientColor)

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

//图片剪切到指定kb
+(NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1024.0;
        CGFloat maxQuality = 0.9f;
        NSLog(@"1M以下大小:%fkb",dataKBytes);
        while (dataKBytes > size&&maxQuality>0.01f)
        {
            
                maxQuality = maxQuality - 0.01f;
                data = UIImageJPEGRepresentation(image, maxQuality);
                dataKBytes = data.length / 1024.0;
        }
    
        NSLog(@"压缩完大小:%fkb",(float)[data length]/1024.0f);
    
    
        return data;
    
    
    /*
     1.获取照片文件大小
     2.当文件大小 小于我们设定的最高大小时，直接返回照片，不做处理
     3.当文件大小大于我们设定的值时，进行while循环，每循坏一次在原有基础上压缩照片0.01 直到文件大小在我们设定的值得10kb左右。
     
     */
   
}

+ (NSData *)compressQualityImage:(UIImage *)image WithMaxLength:(NSInteger)maxLength {
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    NSLog(@"%lu",data.length/1024);
    return data;
}


//图片按照指定尺寸裁剪
+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size

{
    
    CGSize originalsize = [originalImage size];
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    
    if (originalsize.width<size.width && originalsize.height<size.height)
        
    {
        
        return originalImage;
        
    }
    
    
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    
    else if(originalsize.width>size.width && originalsize.height>size.height)
        
    {
        
        CGFloat rate = 1.0;
        
        CGFloat widthRate = originalsize.width/size.width;
        
        CGFloat heightRate = originalsize.height/size.height;
        
        
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        
        
        CGImageRef imageRef = nil;
        
        
        
        if (heightRate>widthRate)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
            
        }
        
        else
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
            
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    
    else if(originalsize.height>size.height || originalsize.width>size.width)
        
    {
        
        CGImageRef imageRef = nil;
        
        
        
        if(originalsize.height>size.height)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
            
        }
        
        else if (originalsize.width>size.width)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
            
        }
        
        
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        
        
      　CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图为标准长宽的，不做处理
    
    else
        
    {
        
        return originalImage;
        
    }
    
    
    
}
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time1      = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error   = nil;
    
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time1 actualTime:&actualTime error:&error];
    UIImage *img     = [[UIImage alloc] initWithCGImage:image];
    return img;
}
+ (UIImage*)videoImageWithvideoURL:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    //先从缓存中找是否有图片
    SDImageCache *cache =  [SDImageCache sharedImageCache];
    UIImage *memoryImage =  [cache imageFromMemoryCacheForKey:videoURL.absoluteString];
    if (memoryImage) {
       
        return memoryImage;
    }else{
        UIImage *diskImage =  [cache imageFromDiskCacheForKey:videoURL.absoluteString];
        if (diskImage) {
            
            return diskImage;
        }
    }
    
    if (!time) {
        time = 1;
    }
   
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
        
        
            SDImageCache *cache1 =  [SDImageCache sharedImageCache];
            [cache1 storeImage:thumbnailImage forKey:videoURL.absoluteString toDisk:YES];
           
       
         return  thumbnailImage;
   
    
}


+ (UIImage*) lflthumbnailImageForVideo:(NSURL *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

+ (UIImage*) imageToTransparent:(UIImage*) image

{
    
    // 分配内存
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    
    
    // 创建context
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
        
    {
        
        //接近粉色
        
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        
        //分别取出RGB值后。进行判断需不需要设成透明。
        
        uint8_t* ptr = (uint8_t*)pCurPtr;
        // NSLog(@"1是%d,2是%d,3是%d",ptr[1],ptr[2],ptr[3]);
        if(ptr[1] >= 200 || ptr[2] >= 200 || ptr[3] >= 200){
            ptr[0] = 0;
        }
        
        
    }
    
    // 将内存转成image
    
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    
    
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true,kCGRenderingIntentDefault);
    
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
    
}
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}



//图片按照指定尺寸裁剪
+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage

{
    
    CGSize originalsize = [originalImage size];
    CGSize  size=CGSizeMake(originalsize.width/2.0, originalsize.height/2.0);
    //原图长宽均小于标准长宽的，不作处理返回原图
    
    if (originalsize.width<size.width && originalsize.height<size.height)
        
    {
        
        return originalImage;
        
    }
    
    
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    
    else if(originalsize.width>size.width && originalsize.height>size.height)
        
    {
        
        CGFloat rate = 1.0;
        
        CGFloat widthRate = originalsize.width/size.width;
        
        CGFloat heightRate = originalsize.height/size.height;
        
        
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        
        
        CGImageRef imageRef = nil;
        
        
        
        if (heightRate>widthRate)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
            
        }
        
        else
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
            
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    
    else if(originalsize.height>size.height || originalsize.width>size.width)
        
    {
        
        CGImageRef imageRef = nil;
        
        
        
        if(originalsize.height>size.height)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
            
        }
        
        else if (originalsize.width>size.width)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
            
        }
        
        
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        
        
        　CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图为标准长宽的，不做处理
    
    else
        
    {
        
        return originalImage;
        
    }
    
    
    
}
@end

//
//  UIImage+Additions.h
//  GeneralFramework
//
//  Created by ZMJ on 15/5/7.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
// 设置颜色
#define BXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BXAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


@interface UIImage (Additions)
+(NSData *)base64ImageThumbnaiWith:(UIImage *)image;
+(UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)createImageWithColor:(UIColor *)color;

//获取视频封面  videoURL:视频网络地址
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL withTitle:(NSString *)title;


+ (instancetype)st_imageFromVideoOutput:(AVPlayerItemVideoOutput *)output itemTime:(CMTime)itemTime;


//根据图片地址计算大小
+(CGSize)getImageSizeWithURL:(id)imageURL;

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
@end

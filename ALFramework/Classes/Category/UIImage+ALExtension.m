//
//  UIImage+ALExtension.m
//  TestImagePicker
//
//  Created by AlancLiu on 05/07/2017.
//  Copyright © 2017 Zhujian. All rights reserved.
//

#import "UIImage+ALExtension.h"

@implementation UIImage (ALExtension)

-(UIImage *)scaleImage:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
}

-(UIImage*)getSubImage:(CGRect)clipRect
{
    UIGraphicsBeginImageContext(clipRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-clipRect.origin.x, -clipRect.origin.y, self.size.width, self.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, clipRect.size.width, clipRect.size.height));
    
    // draw image
    [self drawInRect:drawRect];
    
    // grab image
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return subImage;
}

-(UIImage *)rotation:(UIImageOrientation)orientation{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
            case UIImageOrientationLeft:
                rotate = M_PI_2;
                rect = CGRectMake(0, 0, self.size.height, self.size.width);
                translateX = 0;
                translateY = -rect.size.width;
                scaleY = rect.size.width/rect.size.height;
                scaleX = rect.size.height/rect.size.width;
                break;
            case UIImageOrientationRight:
                rotate = 3 * M_PI_2;
                rect = CGRectMake(0, 0, self.size.height, self.size.width);
                translateX = -rect.size.height;
                translateY = 0;
                scaleY = rect.size.width/rect.size.height;
                scaleX = rect.size.height/rect.size.width;
                break;
            case UIImageOrientationDown:
                rotate = M_PI;
                rect = CGRectMake(0, 0, self.size.width, self.size.height);
                translateX = -rect.size.width;
                translateY = -rect.size.height;
                break;
            default:
                rotate = 0.0;
                rect = CGRectMake(0, 0, self.size.width, self.size.height);
                translateX = 0;
                translateY = 0;
                break;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);

    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);

    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();

    return newPic;
}

@end

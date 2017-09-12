//
//  UIImage+ALExtension.h
//  TestImagePicker
//
//  Created by AlancLiu on 05/07/2017.
//  Copyright © 2017 Zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALExtension)

-(UIImage *)scaleImage:(float)scaleSize;
-(UIImage*)getSubImage:(CGRect)clipRect;
-(UIImage *)rotation:(UIImageOrientation)orientation;

@end

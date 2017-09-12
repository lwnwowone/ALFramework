//
//  ALImageAdjustmentView.h
//  TestImagePicker
//
//  Created by AlancLiu on 05/07/2017.
//  Copyright © 2017 Zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALImageCropView : UIView

@property (nonatomic) CGRect clipRect;
@property (nonatomic) UIColor *strokeColor;

@end

@interface ALImageAdjustmentView : UIView

-(void)setImage:(UIImage *)image;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGRect cropRect;
@property (nonatomic) UIButton *btnFinish;

@property (nonatomic) bool needTool;

@property (nonatomic) void(^editComplete)(UIImage *editedImage);

@property (nonatomic) ALImageCropView *icv;


@end

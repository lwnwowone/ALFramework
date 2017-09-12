//
//  ALImagePickerView.h
//  TestImagePicker
//
//  Created by Zhujian on 2017/7/3.
//  Copyright © 2017年 Zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageAdjustmentView.h"

@interface ALImagePickerView : UIImageView

@property (nonatomic) bool needAdjustment;
@property (nonatomic) UINavigationController *currentNavC;
@property (nonatomic) NSData *imageData;

@property (nonatomic) ALImageAdjustmentView *iav;

@property (nonatomic) void(^imageChanged)();

-(void)setNavigationController:(UINavigationController *)navC;
-(void)setNeedTool:(bool)needTool;
-(bool)needTool;

@property (nonatomic) void(^picFromPhotoLib)();
@property (nonatomic) void(^picFromCamera)();

@end



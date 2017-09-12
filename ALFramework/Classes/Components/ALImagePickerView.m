	//
//  ALImagePickerView.m
//  TestImagePicker
//
//  Created by Zhujian on 2017/7/3.
//  Copyright © 2017年 Zhujian. All rights reserved.
//

#import "ALImagePickerView.h"
#import "ALBasicToolBox.h"
#import "ALCommonMacros.h"
#import "ALAlertMessage.h"

@interface ALImagePickerView()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) UIActionSheet *actionSheet;

@end

@implementation ALImagePickerView

-(id)initWithLocalizedTitles:(NSDictionary *)localizationDic{
    self = [self init];
    
    _actionSheet = nil;
    _actionSheet = [UIActionSheet new];
    [_actionSheet addButtonWithTitle:localizationDic[@"photoLib"]];
    [_actionSheet addButtonWithTitle:localizationDic[@"camera"]];
    [_actionSheet addButtonWithTitle:localizationDic[@"close"]];
    _actionSheet.delegate = self;
    
    return self;
}

-(id)init{
    self = [super init];
    self.userInteractionEnabled = true;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    _needAdjustment = true;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGR];
    
    _actionSheet = [UIActionSheet new];
    [_actionSheet addButtonWithTitle:@"Photh album"];
    [_actionSheet addButtonWithTitle:@"Camera"];
    [_actionSheet addButtonWithTitle:@"Close"];
    _actionSheet.delegate = self;
    
    _imagePickerController = [UIImagePickerController new];
    _imagePickerController.delegate = self;
    
    return self;
}

-(void)setNavigationController:(UINavigationController *)navC{
    self.currentNavC = navC;
}

-(void)tapAction{
    [_actionSheet showInView:self];
}

-(void)GetPhotoFromLib{
    [_picFromPhotoLib invoke];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

-(void)GetPhotoFromCamera{
    [_picFromCamera invoke];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
}

-(void)setNeedTool:(bool)needTool{
    _iav.needTool = needTool;
}

-(bool)needTool{
    return _iav.needTool;
}

#pragma UIActionSheetDelegate\

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(0 == buttonIndex){
        [self GetPhotoFromLib];
        [ALBasicToolBox runFunctionInMainThread:^{
            [self.currentNavC presentViewController:_imagePickerController animated:true completion:nil];
        } WithDelay:0.3];
    }
    else if(1 == buttonIndex){
        if(IS_SIMULATOR){
            [ALAlertMessage operationFailedWithMessage:@"You can not use this feature on the SIMULATOR"];
            return;
        }
        [self GetPhotoFromCamera];
        [ALBasicToolBox runFunctionInMainThread:^{
            [self.currentNavC presentViewController:_imagePickerController animated:true completion:nil];
        } WithDelay:0.3];
    }
}

#pragma UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *judgementStr = info[UIImagePickerControllerMediaType];
    bool isImage = [judgementStr isEqualToString:@"public.image"] ? true : false;
    if(isImage){
        UIImage *theImage = info[UIImagePickerControllerOriginalImage];
        if(_needAdjustment){
            if(!_iav)
                _iav = [ALImageAdjustmentView new];
            [_iav setImage:theImage];
            _iav.frame = _imagePickerController.view.bounds;
            [_imagePickerController.view addSubview:_iav];
            
            __weak typeof(self) weakSelf = self;
            _iav.editComplete = ^(UIImage *editedImage) {
                weakSelf.image = editedImage;
                weakSelf.imageData = UIImageJPEGRepresentation(editedImage, 1);
                if(weakSelf.imageChanged)
                    weakSelf.imageChanged();
                [weakSelf.currentNavC dismissViewControllerAnimated:true completion:nil];
            };
        }
        else{
            self.image = theImage;
            self.imageData = UIImageJPEGRepresentation(theImage, 0.5);
            if(self.imageChanged)
                self.imageChanged();
            [self.currentNavC dismissViewControllerAnimated:true completion:nil];

        }
    }
}

@end

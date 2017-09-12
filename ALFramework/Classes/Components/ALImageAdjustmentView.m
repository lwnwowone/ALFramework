//
//  ALImageAdjustmentView.m
//  TestImagePicker
//
//  Created by AlancLiu on 05/07/2017.
//  Copyright © 2017 Zhujian. All rights reserved.
//

#define CROP_RECT_PADDING 20
#define BUTTON_LENGTH 60

#import "ALImageAdjustmentView.h"
#import "UIImage+ALExtension.h"

#import "UIView+ALTestingFunction.h"

@implementation ALImageAdjustmentView{

@private UIButton *btnLittleLeft;
@private UIButton *btnLeft;
    
@private UIButton *btnLittleRitht;
@private UIButton *btnRight;

}

-(id)init {
    self = [super init];
    // Do any additional setup after loading the view.
    self.backgroundColor =[UIColor blackColor];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addGestureRecognizerToView:_imageView];
    [_imageView setUserInteractionEnabled:YES];
    [_imageView setMultipleTouchEnabled:YES];
    _imageView.frame = CGRectZero;
    [self addSubview:_imageView];
    
    float ovWidth = [UIScreen mainScreen].bounds.size.width - 2 * CROP_RECT_PADDING;
    float ovHeight = ovWidth *0.618;
    float ovY = ([UIScreen mainScreen].bounds.size.height - ovHeight) / 2;
    _cropRect = CGRectMake(CROP_RECT_PADDING, ovY, ovWidth, ovHeight);
    
    _icv = [ALImageCropView new];
    _icv.userInteractionEnabled = false;
    [self addSubview:_icv];
    
    _btnFinish = [UIButton new];
    _btnFinish.layer.masksToBounds = true;
    _btnFinish.layer.cornerRadius = BUTTON_LENGTH/2;
    _btnFinish.backgroundColor = [UIColor whiteColor];
    [_btnFinish addTarget:self action:@selector(adjustFinished) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnFinish];
    
    btnLittleLeft = [UIButton new];
    btnLittleLeft.layer.masksToBounds = true;
    btnLittleLeft.layer.cornerRadius = BUTTON_LENGTH/4;
    btnLittleLeft.backgroundColor = [UIColor redColor];
    [btnLittleLeft addTarget:self action:@selector(rotationHandle:) forControlEvents:UIControlEventTouchUpInside];
    btnLittleLeft.tag = 11;
//    [self addSubview:btnLittleLeft];
    
    btnLittleRitht = [UIButton new];
    btnLittleRitht.layer.masksToBounds = true;
    btnLittleRitht.layer.cornerRadius = BUTTON_LENGTH/4;
    btnLittleRitht.backgroundColor = [UIColor redColor];
    [btnLittleRitht addTarget:self action:@selector(rotationHandle:) forControlEvents:UIControlEventTouchUpInside];
    btnLittleRitht.tag = 21;
//    [self addSubview:btnLittleRitht];

    btnLeft = [UIButton new];
    btnLeft.layer.masksToBounds = true;
    btnLeft.layer.cornerRadius = BUTTON_LENGTH/4;
    btnLeft.backgroundColor = [UIColor blueColor];
    [btnLeft addTarget:self action:@selector(rotationHandle:) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.tag = 12;
//    [self addSubview:btnLeft];

    btnRight = [UIButton new];
    btnRight.layer.masksToBounds = true;
    btnRight.layer.cornerRadius = BUTTON_LENGTH/4;
    btnRight.backgroundColor = [UIColor blueColor];
    [btnRight addTarget:self action:@selector(rotationHandle:) forControlEvents:UIControlEventTouchUpInside];
    btnRight.tag = 22;
//    [self addSubview:btnRight];

    return self;
}

-(void)setNeedTool:(bool)needTool{

}

-(void)layoutSubviews{
    float ovWidth = self.bounds.size.width - 2 * CROP_RECT_PADDING;
    float ovHeight = ovWidth * (54 / 85.6);
    float ovY = (self.bounds.size.height - ovHeight) / 2;
    _cropRect = CGRectMake(CROP_RECT_PADDING, ovY, ovWidth, ovHeight);
    
    _icv.frame = self.bounds;
    _icv.clipRect = _cropRect;
    
    _btnFinish.frame = CGRectMake((self.bounds.size.width - BUTTON_LENGTH)/2, self.bounds.size.height - BUTTON_LENGTH - 30, BUTTON_LENGTH, BUTTON_LENGTH);
    
    float rotationButtonLength = BUTTON_LENGTH / 2;
    float rotationButtonInsidePadding = 15;
    btnLittleLeft.frame = CGRectMake(CGRectGetMaxX(_btnFinish.frame) + rotationButtonLength, CGRectGetMinY(_btnFinish.frame), rotationButtonLength, rotationButtonLength);
    btnLittleRitht.frame = CGRectMake(CGRectGetMaxX(btnLittleLeft.frame) + rotationButtonInsidePadding, CGRectGetMinY(_btnFinish.frame), rotationButtonLength, rotationButtonLength);
    
    btnLeft.frame = CGRectMake(CGRectGetMinX(btnLittleLeft.frame), CGRectGetMaxY(btnLittleLeft.frame) + rotationButtonInsidePadding, rotationButtonLength, rotationButtonLength);
    btnRight.frame = CGRectMake(CGRectGetMinX(btnLittleRitht.frame), CGRectGetMaxY(btnLittleRitht.frame) + rotationButtonInsidePadding, rotationButtonLength, rotationButtonLength);
    
    if(CGRectEqualToRect(_imageView.frame,CGRectZero)){
        _imageView.frame = self.bounds;
    }
}

-(void)adjustFinished{
    if(self.editComplete)
        self.editComplete([self getCropedImage]);
    [self removeFromSuperview];
}

-(void)setImage:(UIImage *)image{
    //Recover state
    _imageView.transform = CGAffineTransformIdentity;
    _imageView.frame = self.bounds;
    
    _icv.hidden = false;
    _imageView.image = image;
}

-(UIImage *)scaleImageToScreenSize:(UIImage *)img{
    float scale = MAX(img.size.width / UIScreen.mainScreen.bounds.size.width, img.size.height / UIScreen.mainScreen.bounds.size.height);
    UIImage *scaledImage = [img scaleImage:1/scale];
    return scaledImage;
}

-(UIImage *)getCropedImage{
    _icv.hidden = true;;
    UIImage *viewScreenShow = [self viewScreenShot:self];
    UIImage *resultImg = [viewScreenShow getSubImage:_cropRect];
    return resultImg;
}

-(UIImage *)viewScreenShot:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)rotationHandle:(UIButton *)btn{
    if(11 == btn.tag){
        [self leftRotate:1];
    }
    else if(12 == btn.tag){
        [self leftRotate:90];
    }
    else if(21 == btn.tag){
        [self rightRotate:1];
    }
    else if(22 == btn.tag){
        [self rightRotate:90];
    }
}

-(void)leftRotate:(float)angle{
    UIView *rView = _imageView;
    rView.transform = CGAffineTransformRotate(rView.transform, -M_PI/180 * angle);
}

-(void)rightRotate:(float)angle{
    UIView *rView = _imageView;
    rView.transform = CGAffineTransformRotate(rView.transform, M_PI/180 * angle);
}

#pragma about gesture

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
//    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
//    NSLog(@"pinchView");
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if(view.frame.size.width > UIScreen.mainScreen.bounds.size.width || pinchGestureRecognizer.scale > 1){
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
            pinchGestureRecognizer.scale = 1;
        }
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

@end

#define BORDER_LENGTH 30
#define BORDER_WIDTH 3

@implementation ALImageCropView

-(id)init{
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    self.strokeColor = [UIColor greenColor];
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(con, BORDER_WIDTH);
    CGContextSetStrokeColorWithColor(con, self.strokeColor.CGColor);
    
    CGContextMoveToPoint(con, CGRectGetMinX(_clipRect) + BORDER_LENGTH, CGRectGetMinY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMinX(_clipRect), CGRectGetMinY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMinX(_clipRect), CGRectGetMinY(_clipRect) + BORDER_LENGTH);
    CGContextStrokePath(con);
    
    CGContextMoveToPoint(con, CGRectGetMaxX(_clipRect) - BORDER_LENGTH, CGRectGetMinY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMaxX(_clipRect), CGRectGetMinY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMaxX(_clipRect), CGRectGetMinY(_clipRect) + BORDER_LENGTH);
    CGContextStrokePath(con);
    
    CGContextMoveToPoint(con, CGRectGetMaxX(_clipRect) - BORDER_LENGTH, CGRectGetMaxY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMaxX(_clipRect), CGRectGetMaxY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMaxX(_clipRect), CGRectGetMaxY(_clipRect) - BORDER_LENGTH);
    CGContextStrokePath(con);
    
    CGContextMoveToPoint(con, CGRectGetMinX(_clipRect) + BORDER_LENGTH, CGRectGetMaxY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMinX(_clipRect), CGRectGetMaxY(_clipRect));
    CGContextAddLineToPoint(con, CGRectGetMinX(_clipRect), CGRectGetMaxY(_clipRect) - BORDER_LENGTH);
    CGContextStrokePath(con);
}

@end

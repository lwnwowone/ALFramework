//
//  ALCustomPopUp.m
//  DAE
//
//  Created by AlancLiu on 30/06/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALCustomPopUp.h"

#define SCALE_ZERO_VALUE 0.01
#define ANIMATION_TIME 0.3
#define BACKGROUND_ALPHA 0.5

@interface ALCustomPopUp()

@property (nonatomic) UIVisualEffectView *effectView;
@property (nonatomic) UIView *container;
@property (nonatomic) UITapGestureRecognizer *closeTap;

@end

@implementation ALCustomPopUp

-(id)init{
    self = [super init];
    
    self.keyboardPadding = 0;
    self.shown = false;
    self.backgroundColor = [UIColor whiteColor];
    _canCloseByClicking = false;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    _effectView.alpha = 0;
    
    _container = [UIView new];
    
    _closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_container addGestureRecognizer:_closeTap];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWillShow:(NSNotification*)notification{
    NSLog(@"keyboardWillShow");
    NSDictionary *info = notification.userInfo;
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = aValue.CGRectValue;
    CGRect keyboardFrame = [self convertRect:keyboardEndFrame toView:nil];
    float keyboardHeight = keyboardFrame.size.height;
    NSLog(@"keyboardHeight = %f",keyboardHeight);
    
    if(_keyboardPadding>0){
        CGRect tmpR = self.frame;
        tmpR.origin.y = [UIScreen mainScreen].bounds.size.height - keyboardHeight - tmpR.size.height - _keyboardPadding;
        if(tmpR.origin.y < 20)
            tmpR.origin.y = 20;
        if(tmpR.origin.y < self.frame.origin.y)
            self.frame = tmpR;
    }
}

-(void)keyboardWillHide:(NSNotification*)notification{
    NSLog(@"keyboardWillHide");
    if(_keyboardPadding>0){
        CGRect tmpR = self.frame;
        tmpR.origin.y = ([UIScreen mainScreen].bounds.size.height - tmpR.size.height) / 2;
        self.frame = tmpR;
    }
}

-(void)setCanCloseByClicking:(bool)canCloseByClicking{
    _canCloseByClicking = canCloseByClicking;
    if(_canCloseByClicking)
       [_container addGestureRecognizer:_closeTap];
    else
        [_container removeGestureRecognizer:_closeTap];
}

-(void)tapAction{
    if(self.canCloseByClicking)
        [self closeWithAnimate:true];
}

-(void)popWithAnimate:(bool)animate{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    _container.frame = win.bounds;
    
    float popLocX = (_container.frame.size.width - self.frame.size.width) / 2;
    float popLocY = (_container.frame.size.height - self.frame.size.height) / 2;    
    
    [_container addSubview:_effectView];
    [_container addSubview:self];
    
    _effectView.frame = _container.bounds;
    self.frame = CGRectMake(popLocX, popLocY, self.frame.size.width, self.frame.size.height);
    
    [win addSubview:_container];
    
    _effectView.alpha = BACKGROUND_ALPHA;
    if (animate) {
        self.transform = CGAffineTransformMakeScale(SCALE_ZERO_VALUE, SCALE_ZERO_VALUE);
        [UIView animateWithDuration:ANIMATION_TIME animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(self.popUpDidAppear)
                self.popUpDidAppear();
        }];
    }
    
    self.shown = true;
}

-(void)closeWithAnimate:(bool)animate{
    [_container endEditing:true];
    if (animate) {
        if(self.popUpWillDisappear)
            self.popUpWillDisappear();
        [UIView animateWithDuration:ANIMATION_TIME animations:^{
            self.transform = CGAffineTransformMakeScale(SCALE_ZERO_VALUE,SCALE_ZERO_VALUE);
        } completion:^(BOOL finished) {
            [_container removeFromSuperview];
            if(self.popUpDidDisappear)
                self.popUpDidDisappear();
        }];
    }
    else{
        if(self.popUpWillDisappear)
            self.popUpWillDisappear();
        [_container removeFromSuperview];
        if(self.popUpDidDisappear)
            self.popUpDidDisappear();
    }
    self.shown = false;
}

@end

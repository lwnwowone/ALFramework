//
//  ALCustomPopUp.h
//  DAE
//
//  Created by AlancLiu on 30/06/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALCustomPopUp : UIView

@property (nonatomic) bool canCloseByClicking;

-(void)popWithAnimate:(bool)animate;
-(void)closeWithAnimate:(bool)animate;

@property (nonatomic) int keyboardPadding;
@property (nonatomic) bool shown;

@property (nonatomic) void(^popUpDidAppear)();
@property (nonatomic) void(^popUpWillDisappear)();
@property (nonatomic) void(^popUpDidDisappear)();

@end

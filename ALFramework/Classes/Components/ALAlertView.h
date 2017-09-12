//
//  ALAlertView.h
//  DAE
//
//  Created by AlancLiu on 31/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALAlertView : NSObject

+(instancetype)sharedInstance;
+(void)setCancelTitle:(NSString *)title;

-(void)displayWithTitle:(NSString *)title andMessage:(NSString *)message andCloseAction:(void(^)())closeAction;
-(void)displayWithTitle:(NSString *)title andMessage:(NSString *)message andConfirmButtonTitle:(NSString *)confirmTitle andConfirmAction:(void(^)())confirmAction andCloseAction:(void(^)())closeAction;

@end

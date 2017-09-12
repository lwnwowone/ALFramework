//
//  ALAlertView.m
//  DAE
//
//  Created by AlancLiu on 31/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALAlertView.h"
#import "ALBasicToolBox.h"

static ALAlertView *instance;
static NSString *closeButtonTitle = @"Close";

@interface ALAlertView()<UIAlertViewDelegate>

@property bool hasConfirmButton;
@property UIAlertView *alert;

@property void(^closeAction)();
@property void(^confirmAction)();

@end

@implementation ALAlertView

+(instancetype)sharedInstance{
    @synchronized (self) {
        if(!instance)
            instance = [ALAlertView new];
        return instance;
    }
}

+(void)setCancelTitle:(NSString *)title{
    closeButtonTitle = title;
}

-(void)displayWithTitle:(NSString *)title andMessage:(NSString *)message andCloseAction:(void(^)())closeAction{
    NSString *localizedCancelButtonTitle = closeButtonTitle;
    self.hasConfirmButton = false;
    self.closeAction = closeAction;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:localizedCancelButtonTitle otherButtonTitles:nil];
    [ALBasicToolBox runFunctionInMainThread:^{
        [alert show];
    }];
}

-(void)displayWithTitle:(NSString *)title andMessage:(NSString *)message andConfirmButtonTitle:(NSString *)confirmTitle andConfirmAction:(void(^)())confirmAction andCloseAction:(void(^)())closeAction{
    NSString *localizedCancelButtonTitle = closeButtonTitle;
    self.hasConfirmButton = true;
    self.closeAction = closeAction;
    self.confirmAction = confirmAction;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:localizedCancelButtonTitle otherButtonTitles:confirmTitle,nil];
    [ALBasicToolBox runFunctionInMainThread:^{
        [alert show];
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(instance.hasConfirmButton){
        if(0 == buttonIndex){
            if(instance.closeAction){
                [instance.closeAction invoke];
                instance.closeAction = nil;
            }
        }
        else if(1 == buttonIndex){
            if(instance.confirmAction){
                [instance.confirmAction invoke];
                instance.confirmAction = nil;
            }
        }
    }
    else{
        if(instance.closeAction){
            [instance.closeAction invoke];
            instance.closeAction = nil;
        }
    }
}

//-(void)displayWithTitle:(NSString *)title andMessage:(NSString *)message andConfirmButtonTitle:(NSString *)confirmTitle andConfirmAction:(void(^)())confirmAction andCloseAction:(void(^)())closeAction{
//    NSString *localizedCancelButtonTitle = ToLocalized(common_close);
//    instance.hasConfirmButton = true;
//    instance.closeAction = closeAction;
//    instance.confirmAction = confirmAction;
//    [instance showAlertWith:title andMessage:message andConfirmButtonTitle:confirmTitle andConfirmAction:confirmAction andCloseAction:closeAction];
//}

@end

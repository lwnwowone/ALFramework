//
//  UINavigationController+ALExtension.m
//  DAE
//
//  Created by AlancLiu on 24/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "UINavigationController+ALExtension.h"
#import "ALLogHelper.h"

@implementation UINavigationController (ALExtension)

-(void)popToAKindOfClassController:(Class)targetClass{
    UIViewController *targetController = nil;
    int startIndex = (int)self.viewControllers.count - 1;
    for (int i = startIndex; i>=0; i--) {
        NSArray *viewControllers = self.viewControllers;
        UIViewController *tmpController = viewControllers[i];
        if([tmpController isKindOfClass:targetClass]){
            targetController = tmpController;
        }
    }
    if(targetController)
        [self popToViewController:targetController animated:true];
    else{
        [ALLogHelper writeLogWithType:ALLogTypeError andMessage:@"popToAKindOfClassController failed, can not find the targetController."];
    }
}

@end

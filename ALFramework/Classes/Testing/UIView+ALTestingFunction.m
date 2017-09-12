//
//  UIView+ALTestingFunction.m
//  DAE
//
//  Created by AlancLiu on 23/06/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "UIView+ALTestingFunction.h"

 @implementation UIView (ALTestingFunction)

-(void)printFrame{
    float locX = self.frame.origin.x;
    float locY = self.frame.origin.y;
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    NSLog(@"locX = %f, locY = %f, width = %f, height = %f",locX,locY,width,height);
}

-(void)printFrameWithID:(NSString *)identify{
    NSLog(@"identify is :%@, frame is :\n",identify);
    float locX = self.frame.origin.x;
    float locY = self.frame.origin.y;
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    NSLog(@"locX = %f, locY = %f, width = %f, height = %f",locX,locY,width,height);
}

@end

//
//  ALGradientLoadingIndicator.h
//  ALGradientLoadingIndicator
//
//  Created by Alanc on 6/2/17.
//  Copyright © 2017 Alanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALGradientLoadingIndicator : UIView

+(instancetype)instance;

-(void)startAnimation;
-(void)stopANimation;

-(void)showInView:(UIView *)aView;

@end

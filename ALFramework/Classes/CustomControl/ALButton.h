//
//  ALButton.h
//  DAE
//
//  Created by AlancLiu on 11/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALButton : UIButton

-(id)initWithTitle:(NSString *)title;

@property (nonatomic) void(^touchUpInside)();

@end

//
//  ALButton.m
//  DAE
//
//  Created by AlancLiu on 11/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALButton.h"

@implementation ALButton

-(id)initWithTitle:(NSString *)title{
    self = [self init];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    return self;
}

-(id)init{
    self = [super init];
    
    [self addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)touchAction{
    [_touchUpInside invoke];
}

@end

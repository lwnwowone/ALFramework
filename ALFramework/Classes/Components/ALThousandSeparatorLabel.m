//
//  ALThousandSeparatorLabel.m
//  ALThreadPool
//
//  Created by 刘文楠 on 6/8/17.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import "ALThousandSeparatorLabel.h"

@implementation ALThousandSeparatorLabel

-(id)init{
    self = [super init];
    _tsUitil = [ALThousandSeparatorUitil new];
    return self;
}

-(void)setNumber:(NSDecimalNumber *)dNumber{
    if(_needFixedDecimal>0)
        super.text = [_tsUitil getFixedFormattedStringByDecimalValue:dNumber andFixLength:_needFixedDecimal];
    else
        super.text = [_tsUitil getFormattedStringByDecimalValue:dNumber];
}

-(void)setText:(NSString *)text{
    NSDecimalNumber *dNumber = [[NSDecimalNumber alloc] initWithString:text];
    if(dNumber){
        [self setNumber:dNumber];
    }
}

@end

//
//  ALThousandSeparatorTextField.h
//  ALThreadPool
//
//  Created by 刘文楠 on 6/7/17.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALThousandSeparatorUitil.h"

@interface ALThousandSeparatorTextField : UITextField

@property (nonatomic) NSDecimalNumber *currentDecimalValue;
@property (nonatomic) int displayDigits;
@property (nonatomic) int maxDigits;

-(void)setIntValue:(int)aNumber;
-(void)setFloatValue:(float)aNumber;
-(void)setDoubleValue:(double)aNumber;
-(void)setStringValue:( NSString * _Nonnull )aNumber;
-(void)setDecimalValue:( NSDecimalNumber * _Nonnull )aNumber;

-(void)textFieldChanged;

@property ALThousandSeparatorUitil *tsUitil;

@end

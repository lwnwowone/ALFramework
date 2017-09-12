//
//  ALThousandSeparatorTextField.m
//  ALThreadPool
//
//  Created by 刘文楠 on 6/7/17.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import "ALThousandSeparatorTextField.h"
#import "ALThousandSeparatorUitil.h"

@interface ALThousandSeparatorTextField()

@property (nonatomic) NSString *lastValue;
@property (nonatomic) bool formatFlag;

@end

@implementation ALThousandSeparatorTextField{

@private bool needUpdatePlaceHolder;

}

-(id)init{
    self = [super init];
    
    needUpdatePlaceHolder = false;
    
    self.maxDigits = INT_MAX;
    self.currentDecimalValue = [NSDecimalNumber new];
    self.lastValue = @"";
    self.formatFlag = YES;
    self.placeholder = @"0.00";
    self.displayDigits = 2;
    self.tsUitil = [ALThousandSeparatorUitil new];
    self.keyboardType = UIKeyboardTypeDecimalPad;

    [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    super.placeholder = placeholder;
    needUpdatePlaceHolder = false;
}

-(void)setIntValue:(int)aNumber{
    NSDecimalNumber *calculateNumber = (NSDecimalNumber *)[NSNumber numberWithInt:aNumber];
    [self setDecimalValue:calculateNumber];
}

-(void)setFloatValue:(float)aNumber{
    NSDecimalNumber *calculateNumber = (NSDecimalNumber *)[NSNumber numberWithFloat:aNumber];
    [self setDecimalValue:calculateNumber];
}

-(void)setDoubleValue:(double)aNumber{
    NSDecimalNumber *calculateNumber = (NSDecimalNumber *)[NSNumber numberWithDouble:aNumber];
    [self setDecimalValue:calculateNumber];
}

-(void)setStringValue:(NSString * _Nonnull )aStr{
    NSDecimalNumber *calculateNumber = [NSDecimalNumber decimalNumberWithString:aStr];
    [self setDecimalValue:calculateNumber];
}

-(void)setDecimalValue:(NSDecimalNumber * _Nonnull )aNumber{
    self.currentDecimalValue = [aNumber copy];
    self.text = [self.tsUitil getFormattedStringByDecimalValue:aNumber andFractionDigits:_displayDigits];
    [self textFieldChanged];
}

-(void)setDisplayDigits:(int)displayDigits{
    _displayDigits = displayDigits;

    if(needUpdatePlaceHolder){
        NSString *holdStr = @"0.";
        for (int i = 0 ; i < displayDigits ; i++) {
            holdStr = [holdStr stringByAppendingString:@"0"];
        }
        self.placeholder = holdStr;
    }
}

-(void)textFieldChanged{
//    NSLog(@"self.text = %@",self.text);
    if(self.text.length < 1){
        self.currentDecimalValue = (NSDecimalNumber *)[NSNumber numberWithInt:0];
        _lastValue = @"";
    }
    else{
        if([self.tsUitil currentDot] == self.text){
            self.text = [NSString stringWithFormat:@"0%@",[self.tsUitil currentDot]];
            _formatFlag = YES;
            self.currentDecimalValue = [NSDecimalNumber decimalNumberWithString:@"0"];
            self.lastValue = @"";
        }
        else{
            NSInteger strCount = [self.text length] - [[self.text stringByReplacingOccurrencesOfString:[self.tsUitil currentDot] withString:@""] length];
            if(strCount>1){
                self.text = _lastValue;
            }
            else{
                NSString *currentLastChar = [self.text substringWithRange:NSMakeRange(self.text.length - 1, 1)];
                if([self.tsUitil currentDot] == currentLastChar && 0 == _displayDigits){
                    self.text = _lastValue;
                    return;
                }
                
                if([self.tsUitil currentDot] == currentLastChar && _formatFlag){
                    _formatFlag = NO;
                    return;//Do not format if the last char is dot
                }
                else
                    _formatFlag = YES;
                
                NSString *currentValue = [self.tsUitil getPureNumberStringBySource:self.text];
                int integerDigital = (int)[currentValue rangeOfString:[self.tsUitil currentDot]].location;
                int dotIndex = (int)[self.text rangeOfString:[self.tsUitil currentDot]].location + 1;
                int stringLength = (int)self.text.length;
                int decimalDigits = stringLength - dotIndex;
                if((dotIndex > 0 && decimalDigits>_displayDigits) || integerDigital > _maxDigits){
                    self.text = _lastValue;
                }
                else{
                    if([[self.text substringWithRange:NSMakeRange(self.text.length-1, 1)] isEqualToString:@"0"] && [self.text containsString:[self.tsUitil currentDot]]){
                        self.lastValue = self.text;
                        currentValue = [self.tsUitil getPureNumberStringBySource:self.text];
                        self.currentDecimalValue = [NSDecimalNumber decimalNumberWithString:currentValue];
                    }
                    else{
                        NSDecimalNumber *calculateNumber = [NSDecimalNumber decimalNumberWithString:currentValue locale:[self.tsUitil getCurrentLocale]];
                        if([currentValue isEqualToString:@""]){
                            self.text = @"";
                            self.currentDecimalValue = [NSDecimalNumber decimalNumberWithString:@"0"];
                            self.lastValue = @"";
                        }
                        else{
                            if (0.0f == [calculateNumber doubleValue] && (self.text.length > self.displayDigits || (self.displayDigits == self.text.length && [self.text isEqualToString:@"0"]))){
                                self.text = @"";
                                self.currentDecimalValue = [NSDecimalNumber decimalNumberWithString:@"0"];
                                self.lastValue = @"";
                            }
                            else{
                                self.text = [self.tsUitil getFormattedStringByDecimalValue:calculateNumber andFractionDigits:_displayDigits];
                                currentValue = [self.tsUitil getPureNumberStringBySource:self.text];
                                self.currentDecimalValue = [NSDecimalNumber decimalNumberWithString:currentValue];
                                self.lastValue = self.text;
                            }
                        }
                    }
                }
            }
        }
    }
    NSLog(@"Current value is : %@",self.currentDecimalValue);
}

@end

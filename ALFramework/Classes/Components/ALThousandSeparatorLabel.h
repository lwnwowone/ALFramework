//
//  ALThousandSeparatorLabel.h
//  ALThreadPool
//
//  Created by 刘文楠 on 6/8/17.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALThousandSeparatorTextField.h"

@interface ALThousandSeparatorLabel : UILabel

@property (nonatomic) int needFixedDecimal;
@property (nonatomic) ALThousandSeparatorUitil *tsUitil;

-(void)setNumber:(NSDecimalNumber *)dNumber;

@end

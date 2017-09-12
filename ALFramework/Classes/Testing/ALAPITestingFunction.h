//
//  ALAPITestingFunction.h
//  DAE
//
//  Created by AlancLiu on 25/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALActionResult.h"

@interface ALAPITestingFunction : NSObject

+(ALActionResult *)getRandomAPIResult;
+(ALActionResultWithData *)getRandomAPIResultWithData;

@end

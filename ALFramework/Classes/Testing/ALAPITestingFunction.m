//
//  ALAPITestingFunction.m
//  DAE
//
//  Created by AlancLiu on 25/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALAPITestingFunction.h"

#define API_DELAY_TIME 2
#define API_SUCCEEDED_PROBABILITY 90

@implementation ALAPITestingFunction

+(ALActionResult *)getRandomAPIResult{
    sleep(API_DELAY_TIME);
    ALActionResult *funcResult = [ALActionResult new];
    int value = arc4random() % 100 + 1;
    if(value>(100 - API_SUCCEEDED_PROBABILITY)){
        funcResult.result = true;
    }
    else{
        funcResult.result = false;
        funcResult.errorCode = @"23333333";
        funcResult.errorMessage = @"Unfortunately you cannot pass this time, please try again.";
    }
    return funcResult;
}

+(ALActionResultWithData *)getRandomAPIResultWithData{
    sleep(API_DELAY_TIME);
    ALActionResultWithData *funcResult = [ALActionResultWithData new];
    int value = arc4random() % 100 + 1;
    if(value>(100 - API_SUCCEEDED_PROBABILITY)){
        funcResult.result = true;
    }
    else{
        funcResult.result = false;
        funcResult.errorCode = @"23333333";
        funcResult.errorMessage = @"Unfortunately you cannot pass this time, please try again.";
    }
    return funcResult;
}

@end

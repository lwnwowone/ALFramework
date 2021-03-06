//
//  BasicToolBox.m
//  ALThreadPool
//
//  Created by Alanc Liu on 22/03/2017.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import "ALBasicToolBox.h"
#import <UIKit/UIKit.h>

@implementation ALBasicToolBox

+(void)runFunctionInMainThread:(void(^)())action WithDelay:(int)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [action invoke];
    });
}

+(void)runFunctionInMainThread:(void(^)())action{
    dispatch_async(dispatch_get_main_queue(), ^{
        [action invoke];
    });
}

+(NSString *)newGUID{
    NSString *UUID = [[NSUUID UUID] UUIDString];
    return UUID;
}

+(NSString *)currentTimeStamp{
    NSDate* data = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval ti = [data timeIntervalSince1970];
    NSString *tmpStr = [NSString stringWithFormat:@"%f", ti];
    NSArray *tmpArray = [tmpStr componentsSeparatedByString:@"."];
    return [tmpArray objectAtIndex:0];
}

+(NSString *)deviceID{
    NSString *result = [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceID"];
    if(!result){
        result = [[ALBasicToolBox newGUID] stringByAppendingString:[ALBasicToolBox currentTimeStamp]];
        [[NSUserDefaults standardUserDefaults] setValue:result forKey:@"DeviceID"];
    }
    return result;
}

+(bool)isDigital:(NSString *)aStr{
    NSString *expression = @"^[0-9]+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:aStr
                                                        options:0
                                                          range:NSMakeRange(0, aStr.length)];
    return numberOfMatches > 0;
}

+(float)screenSize{
    float screenWidth = UIScreen.mainScreen.bounds.size.width;
    float screenHeight = UIScreen.mainScreen.bounds.size.height;

    if(320 == screenWidth && 480 == screenHeight)
        return 3.5;
    else if(320 == screenWidth && 568 == screenHeight)
        return 4;
    else if(375 == screenWidth && 667 == screenHeight)
        return 4.7;
    else if(414 == screenWidth && 736 == screenHeight)
        return 5.5;
    else if(375 == screenWidth && 812 == screenHeight)
        return 5.8;
    
    return 0;
}

@end

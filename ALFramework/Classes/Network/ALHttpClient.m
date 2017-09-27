//
//  ALHttpClient.m
//  ALFramework
//
//  Created by AlancLiu on 25/09/2017.
//  Copyright © 2017 Alanc. All rights reserved.
//

#import "ALHttpClient.h"
#import "ALConfig.h"
#import "ALLogHelper.h"

@implementation ALHttpClient

#pragma to be override

-(NSDictionary *)getDAEHttpHeader{
    //Add parameter to header if needed
    return nil;
}

-(NSString*)getUrlBy:(NSString*)functionStr{
    //Set Host address to this method like this
    //return [NSString stringWithFormat:@"%@/%@",HOST_ADDRESS,functionStr];
    return @"";
}

#pragma gen method

-(id)initWith:(NSString*)FunctionStr{
    self = [super init];
    self.contentType = DEFAULT_HTTP_CONTENT_TYPE;
    self.url = [self getUrlBy:FunctionStr];
    return self;
}

-(ALActionResultWithData*)doRequestUsing:(ALHttpMethod)method with:(NSDictionary*)params{
    return [self doRequestUsing:method with:params andHeader:nil];
}

-(ALActionResultWithData*)doRequestUsing:(ALHttpMethod)method with:(NSDictionary*)params andHeader:(NSDictionary *)header{
    ALActionResultWithData *funcResult = [ALActionResultWithData new];
    
    //生成请求头
    NSMutableDictionary *headerDic = [[self getDAEHttpHeader] mutableCopy];
    if(header){
        for (NSString *key in header) {
            [headerDic setValue:header[key] forKey:key];
        }
    }
    
    ALHttpRequest *alHttpRequest = [[ALHttpRequest alloc] initWithUrl:_url];
    alHttpRequest.contentType = self.contentType;
    funcResult = [alHttpRequest doRequestUsing:method with:params with:headerDic];
    
    NSString *statusCode = funcResult.extraData;
    NSString *logString = [NSString stringWithFormat:@"----------------------http request began----------------------\n"];
    logString = [logString stringByAppendingString:[NSString stringWithFormat:@"API path = %@\n",self.url]];
    if(HTTP_PARAMETER_OUTPUT_MODE){
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"request headers = %@\n",header]];
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"request parameter = %@\n",params]];
    }
    else{
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"request headers = %@\n",header.allKeys]];
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"request parameter = %@\n",params.allKeys]];
    }
    logString = [logString stringByAppendingString:@"----------------------http result----------------------\n"];
    logString = [logString stringByAppendingString:[NSString stringWithFormat:@"API result status is : %@\n",statusCode]];
    logString = [logString stringByAppendingString:[NSString stringWithFormat:@"%@\n",funcResult.data]];
    logString = [logString stringByAppendingString:@"----------------------http requeset eneded----------------------\n"];
    LOG_DEBUG(logString);
    
    return funcResult;
}

#pragma static request making

+(ALActionResult *)runNoTokenAPIWithAPIAddress:(NSString *)apiAddress
                                 andParameters:(NSDictionary *)parameters
                              andRequestMethod:(ALHttpMethod)requestMethod{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:false andContentType:ALHttpContentTypeJson andHeaders:nil andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:nil];
}

+(ALActionResult *)runNoTokenAPIWithAPIAddress:(NSString *)apiAddress
                                 andParameters:(NSDictionary *)parameters
                              andRequestMethod:(ALHttpMethod)requestMethod
                                    andHeaders:(NSDictionary *)headers{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:false andContentType:ALHttpContentTypeJson andHeaders:headers andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:nil];
}

+(ALActionResult *)runNoTokenAPIWithAPIAddress:(NSString *)apiAddress
                                 andParameters:(NSDictionary *)parameters
                              andRequestMethod:(ALHttpMethod)requestMethod
                       andSucceededHandleBlock:(ALActionResult *(^)(ALActionResultWithData<NSString *> *httpResult))handleBlock{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:false andContentType:ALHttpContentTypeJson andHeaders:nil andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:handleBlock];
}

+(ALActionResult *)runNoTokenAPIWithAPIAddress:(NSString *)apiAddress
                                 andParameters:(NSDictionary *)parameters
                              andRequestMethod:(ALHttpMethod)requestMethod
                                    andHeaders:(NSDictionary *)headers
                       andSucceededHandleBlock:(ALActionResult *(^)(ALActionResultWithData<NSString *> *httpResult))handleBlock{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:false andContentType:ALHttpContentTypeJson andHeaders:headers andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:handleBlock];
}

+(ALActionResult *)runNeedTokenAPIWithAPIAddress:(NSString *)apiAddress
                                   andParameters:(NSDictionary *)parameters
                                andRequestMethod:(ALHttpMethod)requestMethod
                         andSucceededHandleBlock:(ALActionResult *(^)(ALActionResultWithData<NSString *> *httpResult))handleBlock{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:true andContentType:ALHttpContentTypeJson andHeaders:nil andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:handleBlock];
}

+(ALActionResult *)runNeedTokenAPIWithAPIAddress:(NSString *)apiAddress
                                   andParameters:(NSDictionary *)parameters
                                andRequestMethod:(ALHttpMethod)requestMethod
                                      andHeaders:(NSDictionary *)headers
                         andSucceededHandleBlock:(ALActionResult *(^)(ALActionResultWithData<NSString *> *httpResult))handleBlock{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:true andContentType:ALHttpContentTypeJson andHeaders:headers andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:handleBlock];
}

+(ALActionResult *)runNeedTokenAPIWithAPIAddress:(NSString *)apiAddress
                                   andParameters:(NSDictionary *)parameters
                                andRequestMethod:(ALHttpMethod)requestMethod{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:true andContentType:ALHttpContentTypeJson andHeaders:nil andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:nil];
}

+(ALActionResult *)runNeedTokenAPIWithAPIAddress:(NSString *)apiAddress
                                   andParameters:(NSDictionary *)parameters
                                andRequestMethod:(ALHttpMethod)requestMethod
                                      andHeaders:(NSDictionary *)headers{
    return [self runAPIWithAPIAddress:apiAddress andNeedToken:true andContentType:ALHttpContentTypeJson andHeaders:headers andParameters:parameters andRequestMethod:requestMethod andSucceededHandleBlock:nil];
}

+(ALActionResult *)runAPIWithAPIAddress:(NSString *)apiAddress
                           andNeedToken:(bool)needToken
                         andContentType:(ALHttpContentType)contentType
                             andHeaders:(NSDictionary *)headers
                          andParameters:(NSDictionary *)parameters
                       andRequestMethod:(ALHttpMethod)requestMethod
                andSucceededHandleBlock:(ALActionResult *(^)(ALActionResultWithData<NSString *> *httpResult))handleBlock{
    ALActionResult *funcResult = nil;
    
    ALHttpClient *client = [[self alloc] initWith:apiAddress];
    client.contentType = contentType;
    client.needToken = needToken;
    
    LOG_INFO([NSString stringWithFormat:@"%@ API method bagan", apiAddress]);
    ALActionResultWithData<NSString *> *httpResult = [client doRequestUsing:requestMethod with:parameters andHeader:headers];
    if(httpResult.result){
        @try {
            if(handleBlock){
                ALActionResult *tmpResult = handleBlock(httpResult);
                if(tmpResult)
                    funcResult = [tmpResult copy];
                else
                    funcResult = [httpResult copy];
            }
            else
                funcResult = [httpResult copy];
        }
        @catch (NSException *exception) {
            LOG_ERROR(exception.reason);
            funcResult = [ALActionResult new];
            [funcResult internalError];
        }
    }
    else{
        funcResult = [ALActionResult new];
        [funcResult copyErrorInfoFrom:httpResult];
    }
    LOG_INFO([NSString stringWithFormat:@"%@ API method finished", apiAddress]);
    return funcResult;
}

@end

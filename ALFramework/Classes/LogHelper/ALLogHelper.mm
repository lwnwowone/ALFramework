//
//  LogHelper.mm
//  ALThreadPool
//
//  Created by Alanc Liu on 23/03/2017.
//  Copyright © 2017 Alanc Liu. All rights reserved.
//

#import "ALLogHelper.h"

#import "ALDateUitil.h"
#import "ALFileHelper.h"

#import "ALLogMeta+WCTTableCoding.h"

#define PRINT_LEVEL 4
#define LOG_TABLE_NAME @"LogTable"

static WCTDatabase *databaseInstace;

@implementation ALLogHelper

+(void)writeLogWithType:(ALLogType)type andMessage:(NSString*)content{
    
    ALLogMeta *logMeta = [ALLogMeta new];
    logMeta.isAutoIncrement = true;
    
    logMeta.type = type;
    logMeta.message = content;

    WCTDatabase *database = [ALLogHelper logDatabase];
    BOOL result = [database insertObject:logMeta into:[self logTableName]];
    
    if(type <= PRINT_LEVEL)
        NSLog(@"LogHelper(%@) : %@",[self getDescriptionFromType:type],content);
}

#pragma private method

+(NSString *)getDescriptionFromType:(ALLogType)type{
    long judgeNumber = (long)type;
    if(1 == judgeNumber){
        return @"Error";
    }
    else if(2 == judgeNumber){
        return @"Basic";
    }
    else if(3 == judgeNumber){
        return @"Debug";
    }
    else if(4 == judgeNumber){
        return @"Info";
    }
    else
        return @"Unknow";
}

+(WCTDatabase *)logDatabase{
    @synchronized (self) {
        if(!databaseInstace)
            [self initDatabase];
        return databaseInstace;
    }
}

+(void)initDatabase{
    NSString *dbPath = [ALFileHelper getFilePathBySubPathInDocumentsPath:[ALLogHelper logDBPath]];
    databaseInstace = [[WCTDatabase alloc] initWithPath:dbPath];
    
    BOOL createResult = [databaseInstace createTableAndIndexesOfName:[self logTableName]
                                                           withClass:ALLogMeta.class];
    if(!createResult)
        NSLog(@"Create WCDB %@ failed.",[self logTableName]);
}

+(NSString *)logDBPath{
    return @"/Database/LogDB.db";
}

+(NSString *)logTableName{
    NSString *suffix = [ALDateUitil getFormattedDateFromTimestamp:[ALDateUitil getCurrentTimestamp] andFormat:@"yyyy_MM_dd"];
    NSString *tableName = [NSString stringWithFormat:@"%@_%@",LOG_TABLE_NAME,suffix];
    return tableName;
}

@end

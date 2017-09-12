//
//  ALLogMeta.mm
//  DAE
//
//  Created by AlancLiu on 27/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALLogMeta.h"
#import "ALLogMeta+WCTTableCoding.h"
#import "ALDateUitil.h"

@implementation ALLogMeta

WCDB_IMPLEMENTATION(ALLogMeta)
WCDB_SYNTHESIZE(ALLogMeta,metaID)
WCDB_SYNTHESIZE(ALLogMeta,type)
WCDB_SYNTHESIZE(ALLogMeta,message)
WCDB_SYNTHESIZE(ALLogMeta,time)
WCDB_SYNTHESIZE(ALLogMeta,timestamp)

WCDB_PRIMARY_AUTO_INCREMENT(ALLogMeta, metaID)

-(id)init{
    self = [super init];
    
    self.time = [ALDateUitil getCurrentDate];
    self.timestamp = [ALDateUitil getCurrentTimestamp];
    
    return self;
}

@end

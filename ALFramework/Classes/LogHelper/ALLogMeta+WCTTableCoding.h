//
//  ALLogMeta+ WCTTableCoding.h
//  DAE
//
//  Created by AlancLiu on 27/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALLogMeta.h"
#import <WCDB/WCDB.h>

@interface ALLogMeta (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(metaID)
WCDB_PROPERTY(type)
WCDB_PROPERTY(message)
WCDB_PROPERTY(time)
WCDB_PROPERTY(timestamp)

@end

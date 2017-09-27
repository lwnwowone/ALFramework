//
//  ALCommonMacros.h
//  DAE
//
//  Created by AlancLiu on 23/06/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#define IS_SIMULATOR TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1

//For block

#define __TO_WEAK(__VAR__) \
__weak __typeof__(__VAR__) __VAR__##__WEAK__ = (__VAR__);

#define __TO_STRONG(__VAR__) \
__strong __typeof__(__VAR__##__WEAK__) (__VAR__) = __VAR__##__WEAK__;

#define __TO_WEAK_SELF __TO_WEAK(self)
#define __TO_STRONG_SELF __TO_STRONG(self)

//Basic info
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBundleID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

//Screen size
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define TAB_BAR_HEIGHT   50
#define TOP_BAR_HEIGHT   812 == SCREEN_HEIGHT ? 88 : 64
#define BOTTOM_BAR_HEIGHT   64

#endif /* CommonMacros_h */

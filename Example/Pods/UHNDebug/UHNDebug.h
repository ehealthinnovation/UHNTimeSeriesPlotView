//
//  UHNDebug.h
//
//  Created by Jay Moore on 2014-01-23.
//  Copyright 2014 University Health Network. All rights reserved.
//

#define LogDebugEvent(...) DLog(__VA_ARGS__)

#if defined(DEBUG) || defined(TESTFLIGHT) && !defined(DLog)
#define DLog(...) do { NSLog(__VA_ARGS__); } while (0)
#else
#define DLog(...) do { } while (0)
#endif

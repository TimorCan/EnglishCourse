#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TSCoreData.h"
#import "TSMouseTrackingView.h"
#import "TSPreferencesController.h"

FOUNDATION_EXPORT double TSAppKitVersionNumber;
FOUNDATION_EXPORT const unsigned char TSAppKitVersionString[];


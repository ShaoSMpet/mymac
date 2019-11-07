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

#import "JHBaseDanmaku.h"
#import "JHFloatDanmaku.h"
#import "JHScrollDanmaku.h"
#import "JHDanmakuCanvas.h"
#import "JHDanmakuClock.h"
#import "JHDanmakuContainer.h"
#import "JHDanmakuEngine.h"
#import "JHDanmakuRender.h"
#import "JHDisplayLink.h"
#import "JHDanmakuEngine+Private.h"
#import "JHDanmakuDefinition.h"
#import "JHDanmakuMethod.h"
#import "JHDanmakuPrivateHeader.h"
#import "JHLabel+Tools.h"

FOUNDATION_EXPORT double JHDanmakuRenderVersionNumber;
FOUNDATION_EXPORT const unsigned char JHDanmakuRenderVersionString[];


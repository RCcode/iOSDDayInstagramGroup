//
//  Global.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//



#if	1
#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif

/**
 * AppDelegate
 */
#define MyAppDelegate	 ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define kTabBarHeight 45.0f//tabbar高度


//scrollview 滑动条
#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914
//英尺英寸米之间转换
#define OneMeterToFt 3.28
#define OneMlToFt 5280

#define MY_USER_ID_KEY @"MY_USER_ID_KEY"
#define MY_USERVO_KEY  @"MY_USERVO_KEY"
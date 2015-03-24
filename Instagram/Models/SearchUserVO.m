//
//  SearchUserVO.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "SearchUserVO.h"

@implementation SearchUserVO
@synthesize strId,strUserName,strProfilePicture,strFullName;


//===========================================================
// dealloc
//===========================================================
- (void)dealloc
{
    self.strUserName = nil;
    self.strId = nil;
    self.strFullName = nil;
    self.strProfilePicture = nil;
}

@end

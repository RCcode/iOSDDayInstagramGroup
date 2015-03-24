//
//  PopularVO.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "PopularVO.h"

@implementation PopularVO
@synthesize strId,strCommentCount,strLikeCount,strLowImageUrl,strStandardImageUrl,strThumbnailImageUrl,strUserId,strUserName,strCreateTime;
@synthesize strText;

//===========================================================
// dealloc
//===========================================================
- (void)dealloc
{
    self.strUserName = nil;
    self.strId = nil;
    self.strUserId = nil;
    self.strThumbnailImageUrl = nil;
    self.strStandardImageUrl = nil;
    self.strLowImageUrl = nil;
    self.strLikeCount  =nil;
    self.strCommentCount = nil;
    self.strCreateTime = nil;
    self.strText = nil;
    self.strtType = nil;
    
}

@end

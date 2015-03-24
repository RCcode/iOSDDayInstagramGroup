//
//  MediaVO.m
//  XQInstgClient
//
//  Created by iObitLXF on 5/28/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "MediaVO.h"

@implementation MediaVO
@synthesize strId,strCommentCount,strLikeCount,strLowImageUrl,strStandardImageUrl,strThumbnailImageUrl,strUserId,strUserName,strCreateTime,strType,strVideoUrl;
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
    self.strType = nil;
    
    self.strVideoUrl = nil;
    
}

@end

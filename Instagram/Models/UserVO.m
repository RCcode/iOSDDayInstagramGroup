//
//  UserVO.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//
//

#import "UserVO.h"

@implementation UserVO
@synthesize strId,strName,strAvataUrl,strWebsite,strSign,strFullName;
@synthesize strFollowersCount,strFollowingCount,strPhotosCount;

//===========================================================
// dealloc
//===========================================================
- (void)dealloc
{
    self.strAvataUrl = nil;
    self.strId = nil;
    self.strName = nil;
    self.strWebsite = nil;
    self.strSign  =nil;
    self.strPhotosCount = nil;
    self.strFollowingCount = nil;
    self.strFollowersCount = nil;
    self.strFullName = nil;
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.strId forKey:@"strId"];
    [encoder encodeObject:self.strName forKey:@"strName"];
    [encoder encodeObject:self.strSign forKey:@"strSign"];
    [encoder encodeObject:self.strAvataUrl forKey:@"strAvataUrl"];
    [encoder encodeObject:self.strFollowersCount forKey:@"strFollowersCount"];
    [encoder encodeObject:self.strFollowingCount forKey:@"strFollowingCount"];
    [encoder encodeObject:self.strPhotosCount forKey:@"strPhotosCount"];
     [encoder encodeObject:self.strWebsite forKey:@"strWebsite"];
    [encoder encodeObject:self.strFullName forKey:@"strFullNmae"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.strId = [decoder decodeObjectForKey:@"strId"];
        self.strName = [decoder decodeObjectForKey:@"strName"];
        self.strSign = [decoder decodeObjectForKey:@"strSign"];
        self.strAvataUrl = [decoder decodeObjectForKey:@"strAvataUrl"];
        self.strFollowersCount = [decoder decodeObjectForKey:@"strFollowersCount"];
        self.strFollowingCount = [decoder decodeObjectForKey:@"strFollowingCount"];
        self.strPhotosCount = [decoder decodeObjectForKey:@"strPhotosCount"];
        self.strWebsite = [decoder decodeObjectForKey:@"strWebsite"];
        self.strFullName = [decoder decodeObjectForKey:@"strFullNmae"];
        
    }
    return self;
}

@end

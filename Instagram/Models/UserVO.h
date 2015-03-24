//
//  UserVO.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserVO : NSObject {
    NSString *strId;
    NSString *strName;
    NSString *strAvataUrl;
    NSString *strWebsite;
    NSString *strSign;
    NSString *strFollowersCount;
    NSString *strFollowingCount;
    NSString *strPhotosCount;
    NSString *strFullName;
}
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strName;
@property (nonatomic, copy) NSString *strAvataUrl;
@property (nonatomic, copy) NSString *strWebsite;
@property (nonatomic, copy) NSString *strSign;
@property (nonatomic, copy) NSString *strFollowersCount;
@property (nonatomic, copy) NSString *strFollowingCount;
@property (nonatomic, copy) NSString *strPhotosCount;
@property (nonatomic, copy) NSString *strFullName;

@end

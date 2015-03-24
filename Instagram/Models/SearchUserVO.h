//
//  SearchUserVO.h
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchUserVO : NSObject {
    NSString *strId;
    NSString *strUserName;
    NSString *strProfilePicture;
    NSString *strFullName;
}
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strUserName;
@property (nonatomic, copy) NSString *strProfilePicture;
@property (nonatomic, copy) NSString *strFullName;

@end

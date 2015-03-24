//
//  PopularVO.h
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopularVO : NSObject {
    NSString *strId;
    NSString *strLowImageUrl;
    NSString *strStandardImageUrl;
    NSString *strThumbnailImageUrl;
    NSString *strLikeCount;
    NSString *strCommentCount;
    
    NSString *strUserId;
    NSString *strUserName;
    NSString *strCreateTime;
    NSString *strText;
    NSString *strType;
    
}
@property (nonatomic, copy) NSString *strtType;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strLowImageUrl;
@property (nonatomic, copy) NSString *strStandardImageUrl;
@property (nonatomic, copy) NSString *strThumbnailImageUrl;
@property (nonatomic, copy) NSString *strLikeCount;
@property (nonatomic, copy) NSString *strCommentCount;
@property (nonatomic, copy) NSString *strUserId;
@property (nonatomic, copy) NSString *strUserName;
@property (nonatomic, copy) NSString *strCreateTime;
@property (nonatomic, copy) NSString *strText;


@end

//
//  _NSObject_InstagramKey.h
//  InstagramClient2.0
//
//  Created by iObitLXF on 12/3/12.
//  Copyright (c) 2012 Crino. All rights reserved.
//

/*
    权限：
    1、基本：读取用户的所有数据（关注/被关注人，照片等）（默认权限）
    2、评论：创建和删除用户的评论
    3、关系：关注或取消关注用户
    4、喜欢：赞或者取消赞用户的项

 */

//http://instagram.com/developer/endpoints/

#define INSTAGRAM_APP_ID @"d31c225c691d41b393394966b4b3ad2b"
#define INSTAGRAMSESSIONURL @"http://"


/*  USERS 【GET】 */


//后面加参数?access_token= xxx
#define INSTAGRAM_GET_MYUSER_INFO @"/users/self"//获取【授权】用户的信息（self 换做 user-id 则获取某人的）
#define INSTAGRAM_GET_OTHERUSER_INFO @"/users/%@"//获取某用户的信息

#define INSTAGRAM_GET_MYUSER_FEED @"/self/feed"//获取【授权】用户的feed

#define INSTAGRAM_GET_MYUSER_MEDIA_RECENT @"/users/self/media/recent"//获取【授权】用户最近发表（self 换做 user-id 则获取某人的）
#define INSTAGRAM_GET_OTHERUSER_MEDIA_RECENT @"/users/%@/media/recent"//获取某用户最近发表

#define INSTAGRAM_GET_MYUSER_MEDIA_LIKED @"/self/media/liked"//获取【授权】用户赞的media

//后面加参数?q=jack&access_token= xxx,q为用户名字
#define INSTAGRAM_GET_USER_SEARCH @"/users/search"//搜索


/*  Relationship  */

#define INSTAGRAM_GET_MYUSER_FOLLOWS @"/users/self/follows"//获取【授权】用户的关注列表 （self 换做 user-id 则获取某人的）
#define INSTAGRAM_GET_OTHERUSER_FOLLOWS @"/users/%@/follows"//获取某用户的关注列表

#define INSTAGRAM_GET_MYUSER_FOLLOWED_BY @"/users/self/followed-by"//获取【授权】用户的被关注列表（self 换做 user-id 则获取某人的）
#define INSTAGRAM_GET_OTHERUSER_FOLLOWED_BY @"/users/%@/followed-by"//获取某用户的被关注列表

#define INSTAGRAM_GET_MYUSER_REGUESTED_BY @"/users/self/requested-by"//获取【授权】用户的被关注列表


#define INSTAGRAM_GET_RELATIONSHIP @"/users/%@/relationship" //获取【授权】用户与id用户的关系

#define INSTAGRAM_POST_RELATIONSHIP @"/users/%@/relationship" //重新定义【授权】用户与id用户的关系

#define INSTAGRAM_GET_MEDIA_POPULAR @"/media/popular" // 获取最流行的媒体列表
#define INSTAGRAM_GET_MEDIA_LIKED @"/users/self/media/liked" // 获取用户喜欢的媒体
#define INSTAGRAM_GET_SEARCHUSERS @"/users/search" // 搜索用户
#define INSTAGRAM_GET_MEDIA_FEED @"/users/self/feed" // 查阅用户的资料
#define INSTAGRAM_GET_SEARCHMEDIAS @"/tags/%@/media/recent" // 通过标签搜索媒体

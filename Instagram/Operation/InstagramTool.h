//
//  InstagramTool.h
//  Match+
//
//  Created by iObitLXF on 12/11/12.
//
//

#import <Foundation/Foundation.h>
#import "Instagram.h"

//请求数据类型
typedef enum{
    InstaRequestType_Profile=1,
    InstaRequestType_RecentMedia,
    InstaRequestType_Relationship_Search ,
    InstaRequestType_Relationship_Follows ,
    InstaRequestType_Relationship_FollowedBy,
    
} InstaRequestType;


@protocol InstagramToolDelegate;

@interface InstagramTool : NSObject<IGSessionDelegate,IGRequestDelegate>
{
@private
    Instagram           *instagram;
    InstaRequestType    instaRequestType;

}
@property (strong, nonatomic) Instagram *instagram;

@property (assign, nonatomic)id<InstagramToolDelegate> delegate;

+(InstagramTool*)shareInstance;

-(void)doLogin;
-(void)doLogout;
-(void)getProfile:(NSString *)strUserId;
-(void)getRecentMedia:(NSString *)strUserId;
-(void)getFollows:(NSString *)strUserId;
-(void)getFollowedBy:(NSString *)strUserId;
-(void)getRelationshipToAnotherUserById:(NSString *)strUserId;
-(void)changeRelationshipToAnotherUserById:(NSString *)strUserId bToFollow:(BOOL)toFollow;
-(void)getPopularMedia;
-(void)getMyLikedMedia;
-(void)getSearchUsers:(NSString *)string;
-(void)getMyFeed;
-(void)getSearchMedias:(NSString *)string;

@end

@protocol InstagramToolDelegate <NSObject>
@optional
- (void)doLoginSuccessed;
- (void)doLoginFailed:(BOOL)bIsCancel;
- (void)doLogoutFinished;
- (void)getProfileSuccessed:(id)result;
- (void)getProfileFailed:(NSError *)error;
- (void)getRecentMediaSuccessed:(id)result;
- (void)getRecentMediaFailed:(NSError *)error;
- (void)getFollowedBySuccessed:(id)result;
- (void)getFollowedByFailed:(NSError *)error;
- (void)getFollowsSuccessed:(id)result;
- (void)getFollowsFailed:(NSError *)error;
- (void)getRelationshipToAnotherUserByIdSuccessed:(id)result;
- (void)getRelationshipToAnotherUserByIdFailed:(NSError *)error;
- (void)changeRelationshipToAnotherUserByIdSuccessed:(id)result;
- (void)changeRelationshipToAnotherUserByIdFailed:(NSError *)error;

-(void)getPopularMediaFailed:(NSError *)error;
-(void)getPopularMediaSuccessed:(id)result;
-(void)getMyLikedMediaFailed:(NSError *)error;
-(void)getMyLikedMediaSuccessed:(id)result;
-(void)getSearchUsersFailed:(NSError *)error;
-(void)getSearchUsersSuccessed:(id)result;
-(void)getMyFeedSuccessed:(id)result;
-(void)getMyFeedFailed:(NSError *)error;
-(void)getSearchMediasSuccessed:(id)result;
-(void)getSearchMediasFailed:(NSError *)error;

@end







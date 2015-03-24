//
//  InstagramTool.m
//  Match+
//
//  Created by iObitLXF on 12/11/12.
//
//

#import "InstagramTool.h"
#import "InstagramKey.h"
#import "Utils.h"
static InstagramTool *instagramTool = nil;

@implementation InstagramTool
@synthesize instagram;
@synthesize delegate;
- (void)dealloc
{
    self.delegate = nil;
    self.instagram = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}
+(InstagramTool*)shareInstance{
    @synchronized(self) {
        if (!instagramTool) {
            instagramTool = [[InstagramTool alloc] init];
           [[NSNotificationCenter defaultCenter] addObserver:instagramTool selector:@selector(getInstgTokenURL:) name:INSTAGRAMSESSIONURL object:nil];
            
        }
    }
    return instagramTool;
}

- (id)init
{
    self = [super init];
    if (!self.instagram) {
        Instagram *ig = [[Instagram alloc] initWithClientId:INSTAGRAM_APP_ID delegate:nil];
        self.instagram = ig;
        self.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        self.instagram.sessionDelegate = self;
        
    }
    return self;
}

-(void)getInstgTokenURL:(id)sender{
    
    NSLog(@"getInstgTokenURL");
    NSURL *url = (NSURL*)[sender object];
    [self.instagram handleOpenURL:url];
}

#pragma mark- Login&Logout
-(void)doLogin
{
    // here i can set accessToken received on previous login
    self.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    self.instagram.sessionDelegate = self;
    
    if ([self.instagram isSessionValid]) {
        [self igDidLogin];
    } else {
        //lxf 授权范围（重要），如你不设置relationships，则不能进行follow和unfollow
//        NSString *scope = @"likes";
        NSArray *scopes = [NSArray arrayWithObjects:@"relationships+comments+likes", nil];//@"comments",@"likes",
        [self.instagram authorize:scopes];
    }
   


}
-(void)doLogout
{
    [self.instagram logout];
}

#pragma mark- METHODS

-(void)getDataDictionary:(NSMutableDictionary *)paramsDic isGet:(BOOL)bGet
{
    if(!self.instagram.accessToken)
    {
        self.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        self.instagram.sessionDelegate = self;
    }
    NSString *strHttpMethod = @"GET";
    if (!bGet) {
        strHttpMethod = @"POST";
    }
    [self.instagram requestWithParams:paramsDic
                           httpMethod:strHttpMethod
                             delegate:self];

}

//getProfile
-(void)getProfile:(NSString *)strUserId
{
    instaRequestType = InstaRequestType_Profile;
   
    NSMutableDictionary* params = nil;
    if (!strUserId || [strUserId isEqualToString:[Utils getMyId]]) {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:INSTAGRAM_GET_MYUSER_INFO, @"method", nil];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_OTHERUSER_INFO,strUserId];
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    }
    [self getDataDictionary:params isGet:YES];
    

}

-(void)getRecentMedia:(NSString *)strUserId
{
    //strUserId 为 nil 时，默认下载 myProfile
    instaRequestType = InstaRequestType_RecentMedia;
    
    NSMutableDictionary* params = nil;
    if (!strUserId || [strUserId isEqualToString:[Utils getMyId]]) {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:INSTAGRAM_GET_MYUSER_MEDIA_RECENT, @"method", nil];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_OTHERUSER_MEDIA_RECENT,strUserId];
         params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    }
    [self getDataDictionary:params isGet:YES];


}

-(void)getFollows:(NSString *)strUserId
{
    instaRequestType = InstaRequestType_Relationship_Follows;
   
    NSMutableDictionary* params = nil;
    if (!strUserId || [strUserId isEqualToString:[Utils getMyId]]) {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:INSTAGRAM_GET_MYUSER_FOLLOWS, @"method", nil];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_OTHERUSER_FOLLOWS,strUserId];
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    }
    [self getDataDictionary:params isGet:YES];
    
    
    
    
}
-(void)getFollowedBy:(NSString *)strUserId;
{
    instaRequestType = InstaRequestType_Relationship_FollowedBy;
   
    NSMutableDictionary* params = nil;
    if (!strUserId || [strUserId isEqualToString:[Utils getMyId]]) {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:INSTAGRAM_GET_MYUSER_FOLLOWED_BY, @"method", nil];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_OTHERUSER_FOLLOWED_BY,strUserId];
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    }
    [self getDataDictionary:params isGet:YES];
    
}

-(void)getRelationshipToAnotherUserById:(NSString *)strUserId
{
    
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_RELATIONSHIP,strUserId];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    [self getDataDictionary:params isGet:YES];
}

-(void)changeRelationshipToAnotherUserById:(NSString *)strUserId bToFollow:(BOOL)toFollow
{
    NSString *strRelationship = (toFollow)?@"follow":@"unfollow";
    
    NSString *strMethod = [NSString stringWithFormat:INSTAGRAM_POST_RELATIONSHIP,strUserId];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:strMethod, @"method",strRelationship,@"Relationship", nil];
    [self getDataDictionary:params isGet:NO];
}


-(void)getPopularMedia
{
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_MEDIA_POPULAR];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    [self getDataDictionary:params isGet:YES];
}

-(void)getMyLikedMedia
{
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_MEDIA_LIKED];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    [self getDataDictionary:params isGet:YES];
}

-(void)getSearchUsers:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_SEARCHUSERS];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method",string,@"q", nil];
    [self getDataDictionary:params isGet:YES];
}

-(void)getMyFeed
{
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_MEDIA_FEED];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    [self getDataDictionary:params isGet:YES];

}

-(void)getSearchMedias:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:INSTAGRAM_GET_SEARCHMEDIAS, string];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:str, @"method", nil];
    [self getDataDictionary:params isGet:YES];
}

#pragma mark- IGSessionDelegate

-(void)igDidLogin {
    NSLog(@"Instagram did login");
    // here i can store accessToken
    [[NSUserDefaults standardUserDefaults] setObject:self.instagram.accessToken forKey:@"accessToken"];// 保存获取的access_token
	[[NSUserDefaults standardUserDefaults] synchronize];

    if ([self.delegate respondsToSelector:@selector(doLoginSuccessed)])
    {
         [self.delegate doLoginSuccessed];
    }
     
}

-(void)igDidNotLogin:(BOOL)cancelled {
    NSLog(@"Instagram did not login");
    NSString* message = nil;
    if (cancelled) {
        message = @"Access cancelled!";
    } else {
        message = @"Access denied!";
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed", nil)
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    [alertView show];
    
     
    if ([self.delegate respondsToSelector:@selector(doLoginFailed:)])
    {
        [self.delegate doLoginFailed:cancelled];
    }
}

-(void)igDidLogout {
    NSLog(@"Instagram did logout");
    // remove the accessToken
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(doLogoutFinished)])
    {
         [self.delegate doLogoutFinished];
    }
   
}

-(void)igSessionInvalidated {
    NSLog(@"Instagram session was invalidated");
}


#pragma mark - IGRequestDelegate

- (void)request:(IGRequest *)request didFailWithError:(NSError *)error {
   
    NSLog(@"Err details: %@", [error description]);
   
    NSArray *aArray = [request.url componentsSeparatedByString:@"/"];
    
    if ([aArray count]>2) {
        if ([[aArray lastObject] isEqual:@"self"] ||
            ([[aArray objectAtIndex:[aArray count]-2] isEqual:@"users"] && [[aArray lastObject]intValue]>0)) {
            
            if ([self.delegate respondsToSelector:@selector(getProfileFailed:)])
            {
                [self.delegate getProfileFailed:error];
            }
        }
        else if ([[aArray lastObject] isEqual:@"follows"])
        {
            NSLog(@"PROFILE 》》》》》Instagram did fail: %@", error);
            if ([self.delegate respondsToSelector:@selector(getMyFollowsFailed:)])
            {
                [self.delegate getFollowsFailed:error];
            }
        }
        else if ([[aArray lastObject] isEqual:@"followed-by"])
        {
            NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
            if ([self.delegate respondsToSelector:@selector(getMyFollowedByFailed:)])
            {
                [self.delegate getFollowedByFailed:error];
            }
        }
        else if ([[aArray lastObject] isEqual:@"relationship"])
        {
            if ([request.httpMethod isEqual:@"GET"]) {
                if ([self.delegate respondsToSelector:@selector(getRelationshipToAnotherUserById:)])
                {
                    [self.delegate getRelationshipToAnotherUserByIdFailed:error];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(changeRelationshipToAnotherUserById:)])
                {
                    [self.delegate changeRelationshipToAnotherUserByIdFailed:error];
                }
            }
        }
        else if ([[aArray lastObject] isEqual:@"likes"])
        {
            if ([request.httpMethod isEqual:@"GET"]) {
                
            }
            else if ([request.httpMethod isEqual:@"POST"])
            {
                
            }
            else if ([request.httpMethod isEqual:@"DEL"])
            {
                
            }
            
        }
        
        else if ([[aArray lastObject] isEqual:@"self"] ||
                 ([[aArray objectAtIndex:[aArray count]-2] isEqual:@"media"] && [[aArray lastObject]intValue]>0)) {
            
            
        }
        
        else
        {
            NSMutableArray *lastTwoAry = [NSMutableArray array];
            [lastTwoAry addObject:[aArray objectAtIndex:[aArray count]-2]];
            [lastTwoAry addObject:[aArray lastObject]];
            
            NSString *lastTwoString = [lastTwoAry componentsJoinedByString:@"/"];
            
            if ([lastTwoString isEqual:@"media/recent"]) {
                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
                if ([[aArray objectAtIndex:[aArray count]-4] isEqualToString:@"tags"]) {
                    if ([self.delegate respondsToSelector:@selector(getSearchMediasFailed:)])
                    {
                        [self.delegate getSearchMediasFailed:error];
                    }
                    
                }else if ([self.delegate respondsToSelector:@selector(getMyRecentMediaFailed:)])
                {
                    [self.delegate getRecentMediaFailed:error];
                }
            }
            else if([lastTwoString isEqual:@"self/feed"])
            {
                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
                if ([self.delegate respondsToSelector:@selector(getMyFeedFailed:)])
                {
                    [self.delegate getMyFeedFailed:error];
                }

            }
            else if([lastTwoString isEqual:@"self/requested-by"])
            {
                
            }
            
            // 获取用户喜欢的媒体
            else if([lastTwoString isEqual:@"media/liked"])
            {
                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
                if ([self.delegate respondsToSelector:@selector(getMyLikedMediaFailed:)])
                {
                    [self.delegate getMyLikedMediaFailed:error];
                }
            }
            else if([lastTwoString isEqual:@"users/search"])
            {
                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
                if ([self.delegate respondsToSelector:@selector(getSearchUsersFailed:)])
                {
                    [self.delegate getSearchUsersFailed:error];
                }
            }
            else if([lastTwoString isEqual:@"tags/search"])
            {
//                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
//                if ([self.delegate respondsToSelector:@selector(getSearchMediasFailed:)])
//                {
//                    [self.delegate getSearchMediasFailed:error];
//                }

            }
            else if([lastTwoString isEqual:@"media/popular"])
            {
                NSLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
                if ([self.delegate respondsToSelector:@selector(getPopularMediaFailed:)])
                {
                    [self.delegate getPopularMediaFailed:error];
                }

            }
        }
        
        
    }


    
//    if (instaRequestType == InstaRequestType_Profile) {
//         DLog(@"PROFILE 》》》》》Instagram did fail: %@", error);
//        if ([self.delegate respondsToSelector:@selector(getProfileFailed:)])
//        {
//             [self.delegate getProfileFailed:error];
//        }
//       
//    }
//    else if(instaRequestType == InstaRequestType_RecentMedia)
//    {
//        DLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
//        if ([self.delegate respondsToSelector:@selector(getMyRecentMediaFailed:)])
//        {
//            [self.delegate getRecentMediaFailed:error];
//        }
//    
//    
//    }
//    if (instaRequestType == InstaRequestType_Relationship_Follows) {
//        DLog(@"PROFILE 》》》》》Instagram did fail: %@", error);
//        if ([self.delegate respondsToSelector:@selector(getMyFollowsFailed:)])
//        {
//            [self.delegate getFollowsFailed:error];
//        }
//        
//    }
//    else if(instaRequestType == InstaRequestType_Relationship_FollowedBy)
//    {
//        DLog(@"RecentMedia 》》》》》Instagram did fail: %@", error);
//        if ([self.delegate respondsToSelector:@selector(getMyFollowedByFailed:)])
//        {
//            [self.delegate getFollowedByFailed:error];
//        }
//        
//        
//    }

}

- (void)request:(IGRequest *)request didLoad:(id)result {
    
    NSArray *aArray = [request.url componentsSeparatedByString:@"/"];
    if ([aArray count]>2) {
        if ([[aArray lastObject] isEqual:@"self"] ||
            ([[aArray objectAtIndex:[aArray count]-2] isEqual:@"users"] && [[aArray lastObject]intValue]>0)) {
           
            if ([self.delegate respondsToSelector:@selector(getProfileSuccessed:)])
            {
                [self.delegate getProfileSuccessed:result];
            }
        }
        else if ([[aArray lastObject] isEqual:@"follows"])
        {
            if ([self.delegate respondsToSelector:@selector(getFollowsSuccessed:)])
            {
                [self.delegate getFollowsSuccessed:result];
            }
        }
        else if ([[aArray lastObject] isEqual:@"followed-by"])
        {
            if ([self.delegate respondsToSelector:@selector(getFollowedBySuccessed:)])
            {
                [self.delegate getFollowedBySuccessed:result];
            }
        }
        else if ([[aArray lastObject] isEqual:@"relationship"])
        {
            if ([request.httpMethod isEqual:@"GET"]) {
                if ([self.delegate respondsToSelector:@selector(getRelationshipToAnotherUserByIdSuccessed:)])
                {
                    [self.delegate getRelationshipToAnotherUserByIdSuccessed:result];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(changeRelationshipToAnotherUserByIdSuccessed:)])
                {
                    [self.delegate changeRelationshipToAnotherUserByIdSuccessed:result];
                }
            }
        }
        else if ([[aArray lastObject] isEqual:@"likes"])
        {
            if ([request.httpMethod isEqual:@"GET"]) {
                
            }
            else if ([request.httpMethod isEqual:@"POST"])
            {
                
            }
            else if ([request.httpMethod isEqual:@"DEL"])
            {
                
            }
         
        }
        
        else if ([[aArray lastObject] isEqual:@"self"] ||
            ([[aArray objectAtIndex:[aArray count]-2] isEqual:@"media"] && [[aArray lastObject]intValue]>0)) {
            
           
        }
        
        else
        {
            NSMutableArray *lastTwoAry = [NSMutableArray array];
            [lastTwoAry addObject:[aArray objectAtIndex:[aArray count]-2]];
            [lastTwoAry addObject:[aArray lastObject]];
            
             NSString *lastTwoString = [lastTwoAry componentsJoinedByString:@"/"];
            
            if ([lastTwoString isEqual:@"media/recent"]) {
                if ([[aArray objectAtIndex:[aArray count]-4] isEqualToString:@"tags"]) {
                    if ([self.delegate respondsToSelector:@selector(getSearchMediasSuccessed:)])
                    {
                        [self.delegate getSearchMediasSuccessed:result];
                    }

                }else if ([self.delegate respondsToSelector:@selector(getRecentMediaSuccessed:)])
                {
                    [self.delegate getRecentMediaSuccessed:result];
                }
            }
            else if([lastTwoString isEqual:@"self/feed"])
            {
                if ([self.delegate respondsToSelector:@selector(getMyFeedSuccessed:)])
                {
                    [self.delegate getMyFeedSuccessed:result];
                }
            }
            else if([lastTwoString isEqual:@"self/requested-by"])
            {
                
            }
            else if([lastTwoString isEqual:@"media/liked"])
            {
                if ([self.delegate respondsToSelector:@selector(getMyLikedMediaSuccessed:)])
                {
                    [self.delegate getMyLikedMediaSuccessed:result];
                }
            }
            else if([lastTwoString isEqual:@"users/search"])
            {
                if ([self.delegate respondsToSelector:@selector(getSearchUsersSuccessed:)])
                {
                    [self.delegate getSearchUsersSuccessed:result];
                }
            }
            else if([lastTwoString isEqual:@"tags/search"])
            {
//                if ([self.delegate respondsToSelector:@selector(getSearchMediasSuccessed:)])
//                {
//                    [self.delegate getSearchMediasSuccessed:result];
//                }
            }
            else if([lastTwoString isEqual:@"media/popular"])
            {
                if ([self.delegate respondsToSelector:@selector(getPopularMediaSuccessed:)])
                {
                    [self.delegate getPopularMediaSuccessed:result];
                }
            }
        }
        
        
    }
    
    
    
    
    
//    if (instaRequestType == InstaRequestType_Profile) {
//           DLog(@"PROFILE 》》》》》Instagram did load: %@", result);
//
//           if ([self.delegate respondsToSelector:@selector(getProfileSuccessed:)])
//           {
//                [self.delegate getProfileSuccessed:result];
//           }
//       
//    }
//    else if(instaRequestType == InstaRequestType_RecentMedia)
//    {
//         DLog(@"RecentMedia 》》》》》Instagram did load: %@", result);
//        if ([self.delegate respondsToSelector:@selector(getRecentMediaSuccessed:)])
//        {
//            [self.delegate getRecentMediaSuccessed:result];
//        }
//        
//    }
//    else if(instaRequestType == InstaRequestType_Relationship_Follows)
//    {
//        DLog(@"Follows 》》》》》Instagram did load: %@", result);
//        if ([self.delegate respondsToSelector:@selector(getFollowsSuccessed:)])
//        {
//            [self.delegate getFollowsSuccessed:result];
//        }
//        
//    }
//    else if(instaRequestType == InstaRequestType_Relationship_FollowedBy)
//    {
//        DLog(@"RecentMedia 》》》》》Instagram did load: %@", result);
//        if ([self.delegate respondsToSelector:@selector(getFollowedBySuccessed:)])
//        {
//            [self.delegate getFollowedBySuccessed:result];
//        }
//        
//    }
   
}



@end

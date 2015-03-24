//
//  MyAvataCell.h
//  MatchPlus3
//
//  Created by iObitLXF on 3/5/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVO.h"

typedef void (^ClickDoneFllowerBlock)();
typedef void (^ClickDoneLikeBlock)();
typedef void (^ClickDonePhotoAllBlock)();
typedef void (^ClickDoneToFollowOrNot)();

@interface ProfileAvataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelSign;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvata;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;

@property (weak, nonatomic) IBOutlet UIView *viewTool;

@property (weak, nonatomic) IBOutlet UILabel *labelFollowersTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLikeTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPhotoTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowersNum;
@property (weak, nonatomic) IBOutlet UILabel *labelLikeNum;
@property (weak, nonatomic) IBOutlet UILabel *labelPhotoNum;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UIButton *buttonFollowers;
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoto;

@property (weak, nonatomic) IBOutlet UIButton *buttonToFollowOrNot;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewSep1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSep2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSep3;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//@property (nonatomic,assign)id<MyAvataCellDelegate>    delegate;

@property (nonatomic,strong)    ClickDoneFllowerBlock       blockFllower;
@property (nonatomic,strong)    ClickDoneLikeBlock          blockLike;
@property (nonatomic,strong)    ClickDonePhotoAllBlock      blockPhotoAll;
@property (nonatomic,strong)    ClickDoneToFollowOrNot     blockToFollowOrNot;

@property (nonatomic,assign) BOOL       bIsMyProfile;

+(ProfileAvataCell*)getInstanceWithNib;

-(void)setBlocks:(ClickDoneFllowerBlock)followerBlock
             LikeBlock:(ClickDoneLikeBlock)likeBlock
         PhotoAllBlock:(ClickDonePhotoAllBlock)photoBlock
       ToFollowOrNot:(ClickDoneToFollowOrNot)toFollowOrNotBlock
       ;

-(void)setUI:(UserVO *)aUser;
-(void)setButtonToFollowOrNotUI:(BOOL)isEnable  bFollowed:(NSNumber *)numIsFollowed;
@end

//
//  MyAvataCell.m
//  MatchPlus3
//
//  Created by iObitLXF on 3/5/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import "ProfileAvataCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@implementation ProfileAvataCell
@synthesize viewTool;
@synthesize labelFollowersNum,labelFollowersTitle,labelLikeNum,labelLikeTitle,labelPhotoNum,labelPhotoTitle,labelSign;
@synthesize imageViewAvata;
@synthesize buttonFollowers,buttonLike,buttonPhoto,buttonToFollowOrNot;
@synthesize blockToFollowOrNot,blockFllower,blockLike,blockPhotoAll;
@synthesize bIsMyProfile;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(ProfileAvataCell*)getInstanceWithNib{
    
    ProfileAvataCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ProfileAvataCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[ProfileAvataCell class]]){
            
            cell = (ProfileAvataCell *)obj;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
    }
    return cell;
}

//得到数字的显示
-(NSString *)getNumShow:(NSString *)aStrNum
{
    NSInteger num = [aStrNum intValue];
    NSString *strNum = aStrNum;
    if (num/1000 >0 ) {
        if (num/1000/1000>0) {
            strNum = [NSString stringWithFormat:@"%ldm",num/1000/1000];

        }
        else
        {
            strNum = [NSString stringWithFormat:@"%ldk",num/1000];
        }
    }
    return strNum;

}
-(void)setUI:(UserVO *)aUser
{
    [ self.imageViewAvata.layer setMasksToBounds:YES];
    [ self.imageViewAvata.layer setCornerRadius:2.];
    [self.imageViewAvata setImageWithURL:[NSURL URLWithString:aUser.strAvataUrl]];

    [ self.imageViewBg.layer setMasksToBounds:YES];
    [ self.imageViewBg.layer setCornerRadius:2.];
    
    
    self.viewTool.hidden = (aUser.strFollowersCount)?NO:YES;
    
    NSString *strFollower = [self getNumShow:aUser.strFollowersCount];
    NSString *strFollowing = [self getNumShow:aUser.strFollowingCount];
    NSString *strPhoto = [self getNumShow:aUser.strPhotosCount];
    
           
    self.labelFollowersNum.text = strFollower;
    self.labelLikeNum.text = strFollowing;
    self.labelPhotoNum.text = strPhoto;
    
    
}

-(void)setButtonToFollowOrNotUI:(BOOL)isEnable  bFollowed:(NSNumber *)numIsFollowed
{
    
    UIImage *btnImg = [UIImage imageNamed:@"button_gray_normal.png"];
    UIImage *btnImgPress = [UIImage imageNamed:@"button_gray_press.png"];
    NSString *btnTitle = @"Loading";
    UIColor *btnTitleColor = [UIColor grayColor];
    
    //他人的profile时
    if (numIsFollowed) {
        btnTitleColor = [UIColor whiteColor];
        BOOL isFollowed = [numIsFollowed boolValue];
        if (isFollowed) {
            btnImg = [UIImage imageNamed:@"button_purple_normal.png"];
            btnImgPress = [UIImage imageNamed:@"button_purple_press.png"];
            btnTitle = @"Followed";
            
        }
        else
        {
            btnImg = [UIImage imageNamed:@"button_blue_normal.png"];
            btnImgPress = [UIImage imageNamed:@"button_blue_press.png"];
            btnTitle = @"Following";
        }
        
    
    }
  
    if (isEnable) {
        [self.activityIndicator stopAnimating];
    }
    else
    {
        [self.activityIndicator startAnimating];
    }
    
    //自己的profile时
    if (bIsMyProfile) {
        btnTitleColor = [UIColor whiteColor];
        btnImg = [UIImage imageNamed:@"button_green_normal.png"];
        btnImgPress = [UIImage imageNamed:@"button_green_press.png"];
        btnTitle = @"Edit";
        [self.activityIndicator stopAnimating];

    }
    
    
    CGSize sizeImg = btnImg.size;
    CGSize sizeImgPress = btnImgPress.size;
    
    [self.buttonToFollowOrNot setBackgroundImage:[btnImg stretchableImageWithLeftCapWidth:sizeImg.width/2. topCapHeight:sizeImg.height/2.] forState:UIControlStateNormal];
    [self.buttonToFollowOrNot setBackgroundImage:[btnImgPress stretchableImageWithLeftCapWidth:sizeImgPress.width/2. topCapHeight:sizeImgPress.height/2.] forState:UIControlStateHighlighted];
    [self.buttonToFollowOrNot setTitle:btnTitle forState:UIControlStateNormal];
    [self.buttonToFollowOrNot setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [self.buttonToFollowOrNot setEnabled:isEnable];


}
-(void)setBlocks:(ClickDoneFllowerBlock)followerBlock
             LikeBlock:(ClickDoneLikeBlock)likeBlock
         PhotoAllBlock:(ClickDonePhotoAllBlock)photoBlock
         ToFollowOrNot:(ClickDoneToFollowOrNot)toFollowOrNotBlock

{
    self.blockPhotoAll = photoBlock;
    self.blockLike = likeBlock;
    self.blockFllower = followerBlock;
    self.blockToFollowOrNot = toFollowOrNotBlock;
       
  
       
    

}

- (IBAction)clickFollowerButton:(UIButton *)sender {
    self.blockFllower();
    
}

- (IBAction)clickLikeButton:(UIButton *)sender {
     self.blockLike();
}

- (IBAction)clickPhotoListButton:(UIButton *)sender {

     self.blockPhotoAll();
}
- (IBAction)clickToFollowOrNotButton:(UIButton *)sender {

    if (!bIsMyProfile) {
        //不是自己的profile时才执行
        [self.buttonToFollowOrNot setEnabled:NO];
        [self.activityIndicator startAnimating];
    }
     self.blockToFollowOrNot();
    
}


@end

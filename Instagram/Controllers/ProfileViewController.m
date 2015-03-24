//
//  ProfileViewController.m
//  InstagramClient2.0
//
//  Created by iObitLXF on 12/3/12.
//  Copyright (c) 2012 Crino. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileAvataCell.h"
#import "MediasView.h"
#import "MediaCell.h"
#import "Utils.h"
#import "RCQuiltView.h"

@interface ProfileViewController ()

@property (nonatomic, strong) ProfileAvataCell *cell;

@end

@implementation ProfileViewController
@synthesize nowUser;
@synthesize aryMedia;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    
}

- (void)viewDidLoad
{
    self.title = @"Profile";
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableViewProfile.scrollEnabled = NO;
    self.tableViewProfile.delegate = self;
    self.tableViewProfile.dataSource = self;
    
    numBFollowed = nil;
    bBtnEnable = NO;
   
    bMyProfile = NO;
    if ([self.nowUser.strId isEqualToString:[Utils getMyId]]) {
        bMyProfile = YES;
        bBtnEnable = YES;
    }
   
    
    [self setUI];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    if (!self.nowUser.strFollowingCount) {
        [self getDataOfProfile];
    }
    [self getDataOfRelationship];
    [self getDataOfMedia];
    [self showProgressIndicator:@"Loading.."];
    [self.tableViewProfile reloadData];
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getDataOfProfile{
    
    isMedia = NO;
    [InstagramTool shareInstance].delegate = self;
    [[InstagramTool shareInstance] getProfile:self.nowUser.strId];
    
}
- (void)getDataOfMedia{
    
     isMedia = YES;
    [InstagramTool shareInstance].delegate = self;
    [[InstagramTool shareInstance] getRecentMedia:self.nowUser.strId];
    
}
- (void)getDataOfRelationship{
    
   
    [InstagramTool shareInstance].delegate = self;
    [[InstagramTool shareInstance] getRelationshipToAnotherUserById:self.nowUser.strId];
    
}
- (void)changeDataOfRelationship{
    
    bBtnEnable = NO;
    [InstagramTool shareInstance].delegate = self;
    [[InstagramTool shareInstance] changeRelationshipToAnotherUserById:self.nowUser.strId bToFollow:![numBFollowed boolValue]];
    
}

-(void)setUI
{


}
- (void)viewDidUnload {
    [self setTableViewProfile:nil];
    [super viewDidUnload];
}

- (void)showProgressIndicator:(NSString *)text {
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.view.userInteractionEnabled = FALSE;
	if(!self.progressHUD) {
		self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.progressHUD];
	}
    //    progressHUD.delegate = self;
    self.progressHUD.labelText = text;
    [self.progressHUD show:YES];
}

- (void)hideProgressIndicator {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	self.view.userInteractionEnabled = TRUE;
	if(self.progressHUD) {
		[self.progressHUD hide:YES];
		self.progressHUD = nil;
        
	}
}

#pragma mark - IGRequestDelegate
-(void)getProfileSuccessed:(id)result
{
    NSMutableDictionary *dataDic = [(NSMutableDictionary *)result objectForKey:@"data"];
   
    if (!self.nowUser) {
        self.nowUser =[[UserVO alloc]init];
    }
    self.nowUser.strId = [[dataDic objectForKey:@"id"] description];
    self.nowUser.strName = [dataDic objectForKey:@"username"];
    self.nowUser.strAvataUrl = [dataDic objectForKey:@"profile_picture"];
    self.nowUser.strWebsite = [dataDic objectForKey:@"website"];
    self.nowUser.strSign = [dataDic objectForKey:@"bio"];
    self.nowUser.strFollowersCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"followed_by"] description];
    self.nowUser.strFollowingCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"follows"] description];
    self.nowUser.strPhotosCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"media"] description];
    
    
    
//    [self setUI];
    [self.tableViewProfile reloadData];
    
//    [self getDataOfMedia];
}
-(void)getProfileFailed:(NSError *)error
{
    NSLog(@"PROFILE 》》》》》Instagram did fail: %@", error);
     [Utils showTipViewWhenFailed:error];
}

-(void)getRecentMediaSuccessed:(id)result
{
    [self hideProgressIndicator];
    
    if (!result) {
        return;
    }
    
    if (!self.aryMedia) {
        self.aryMedia = [[NSMutableArray alloc]init];
    }
    [self.aryMedia removeAllObjects];
    
    NSMutableArray *datas = (NSMutableArray *)[(NSMutableDictionary *)result objectForKey:@"data"];
    
    //判断返回结果和当前人是不是对应
    NSMutableDictionary *aDic = (NSMutableDictionary *)[datas objectAtIndex:0];
    NSMutableDictionary *userDic = (NSMutableDictionary *)[aDic objectForKey:@"user"];
    NSString *strID = [[userDic objectForKey:@"id"] description];
    if (![strID isEqualToString:self.nowUser.strId]) {
        return;
    }
    //
    
    for (int i = 0; i<[datas count]; i++) {
         NSMutableDictionary *aDic = (NSMutableDictionary *)[datas objectAtIndex:i];
        if (!aDic) {
            break;
        }
         NSMutableDictionary *imageDic = (NSMutableDictionary *)[aDic objectForKey:@"images"];
        
//         NSMutableDictionary *commentsDic = (NSMutableDictionary *)[aDic objectForKey:@"comments"];
        
        MediaVO *aMedia = [[MediaVO alloc]init];
        aMedia.strId = [aDic objectForKey:@"id"];
        aMedia.strCreateTime = [[aDic objectForKey:@"created_time"] description];
        aMedia.strLikeCount = [[[aDic objectForKey:@"likes"] objectForKey:@"count"] description];
        aMedia.strCommentCount = [[[aDic objectForKey:@"comments"] objectForKey:@"count"] description];
        
        if (imageDic) {
            aMedia.strLowImageUrl = [[imageDic objectForKey:@"low_resolution"] objectForKey:@"url"];
            aMedia.strStandardImageUrl = [[imageDic objectForKey:@"standard_resolution"] objectForKey:@"url"];
            aMedia.strThumbnailImageUrl = [[imageDic objectForKey:@"thumbnail"] objectForKey:@"url"];

        }

        
        [self.aryMedia addObject:aMedia];
        
    }
    
    [self.tableViewProfile reloadData];

}
-(void)getRecentMediaFailed:(NSError *)error
{
     [self hideProgressIndicator];
    
     NSLog(@"Media 》》》》》Instagram did fail: %@", error);
    //buttonToFollowOrNot 这情况下怎么显示呢
     [Utils showTipViewWhenFailed:error];
}

- (void)getRelationshipToAnotherUserByIdSuccessed:(id)result
{
    bBtnEnable = YES;
    
    NSMutableDictionary *dataDic = [(NSMutableDictionary *)result objectForKey:@"data"];
    NSString *strMyselfFollow = [dataDic objectForKey:@"outgoing_status"];
    if (strMyselfFollow && [strMyselfFollow isEqual:@"follows"]) {
        numBFollowed = [NSNumber numberWithBool:YES];
    }
    else{
        numBFollowed = [NSNumber numberWithBool: NO];
    }
    [self.tableViewProfile reloadData];
    
}
- (void)getRelationshipToAnotherUserByIdFailed:(NSError *)error
{
    NSLog(@"Relationship_get 》》》》》Instagram did fail: %@", error);
     [Utils showTipViewWhenFailed:error];
}
- (void)changeRelationshipToAnotherUserByIdSuccessed:(id)result
{
    bBtnEnable = YES;
    
    NSMutableDictionary *dataDic = [(NSMutableDictionary *)result objectForKey:@"data"];
    NSString *strMyselfFollow = [dataDic objectForKey:@"outgoing_status"];
    if (strMyselfFollow && [strMyselfFollow isEqual:@"follows"]) {
        numBFollowed = [NSNumber numberWithBool:YES];
    }
    else{
        numBFollowed = [NSNumber numberWithBool: NO];
    }
    [self.tableViewProfile reloadData];

}

- (void)changeRelationshipToAnotherUserByIdFailed:(NSError *)error
{
    bBtnEnable = YES;
    [self.tableViewProfile reloadData];

    NSLog(@"Relationship_post 》》》》》Instagram did fail: %@", error);
     [Utils showTipViewWhenFailed:error];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.aryMedia count]>0) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130.;
    }
    else if(indexPath.section == 1)
    {
//        NSInteger num1 = [self.aryMedia count]/3;
//        NSInteger num2 = [self.aryMedia count]%3;
//        CGFloat height = 0.;
//        if (num2==0) {
//            height = num1 * 105.;
//        }
//        else
//        {
//            height = (num1 +1) *105.;
//        }
//        height += 5.;
//        return height;
        return [UIScreen mainScreen].bounds.size.height- 130;
    }
    return 0;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ProfileAvataCell";
        ProfileAvataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [ProfileAvataCell getInstanceWithNib];
        }
        cell.bIsMyProfile = bMyProfile;
        [cell setUI:self.nowUser];
        [cell setButtonToFollowOrNotUI:bBtnEnable bFollowed:numBFollowed];
        [cell setBlocks:^{
            //follower
        } LikeBlock:^{
            //following
        } PhotoAllBlock:^{
            //photo
        } ToFollowOrNot:^{
            if (bMyProfile) {
                //edit
            }
            else
            {
            [self changeDataOfRelationship];
            }
            
        }];
        return cell;

    }
    else if(indexPath.section == 1)
    {
        static NSString *CellIdentifier = @"MeidaCell";
        MediaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MediaCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        [cell.mediasView setDataMutableAry:self.aryMedia];
        [cell.mediasView setController:self];
        return cell;

    }
    return nil;
   }

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end

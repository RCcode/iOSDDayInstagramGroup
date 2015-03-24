//
//  ProfileViewController.h
//  InstagramClient2.0
//
//  Created by iObitLXF on 12/3/12.
//  Copyright (c) 2012 Crino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVO.h"
#import "MediaVO.h"
#import "IGRequest.h"
#import "InstagramTool.h"
#import "MBProgressHUD.h"

@interface ProfileViewController : UIViewController<IGRequestDelegate,InstagramToolDelegate,UITableViewDataSource,UITableViewDelegate>
{
   
    BOOL                    isMedia;
    NSNumber                *numBFollowed;
    BOOL                    bBtnEnable;
    BOOL                    bMyProfile;

}
@property (weak, nonatomic) IBOutlet UITableView *tableViewProfile;
@property (strong, nonatomic)  MBProgressHUD        *progressHUD;

@property (nonatomic, strong) UserVO *nowUser;
@property (nonatomic, strong) NSMutableArray *aryMedia;

@end

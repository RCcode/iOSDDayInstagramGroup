//
//  ViewController.m
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "LoginViewController.h"
#import "FollowsViewController.h"
#import "MenuViewController.h"
#import "UserVO.h"
#import "Utils.h"
#import "Global.h"

@interface LoginViewController ()
{
    BOOL isLogin;
}
@end

@implementation LoginViewController
@synthesize progressHUD;

-(void)setUI
{
    NSString *str = (isLogin)?@"Login":@"Logout";
    self.title = str;
    [self.buttonLoginOrOut setTitle:str forState:UIControlStateNormal];
    if (!isLogin) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Follows"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self action:@selector(clickFollowsButton:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    isLogin = YES;
	[self setUI];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickButton:(id)sender
{
     [InstagramTool shareInstance].delegate = self;
    
    if (isLogin) {
        [[InstagramTool shareInstance] doLogin];
        
    }
    else
    {
         [self showProgressIndicator:@"Logouting.."];
        [[InstagramTool shareInstance] doLogout];
        
    }

}
- (void)showProgressIndicator:(NSString *)text {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
	if(progressHUD) {
		[progressHUD hide:YES];
		self.progressHUD = nil;
        
	}
}

-(IBAction)clickFollowsButton:(id)sender
{
    MenuViewController   *vc = [[MenuViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - instagramTool delegate
- (void)doLoginSuccessed
{
     NSLog(@"doLoginSuccessed");
    isLogin = NO;
    
//    [self.buttonLoginOrOut setTitle:@"Logout" forState:UIControlStateNormal];
    
    [self showProgressIndicator:@"Logining.."];
    //登陆成功获取个人信息
    [[InstagramTool shareInstance]getProfile:nil];
    
    
}
- (void)doLoginFailed:(BOOL)bIsCancel
{
    NSLog(@"doLoginFailed");
    
}

-(void)doLogoutFinished
{
    [self hideProgressIndicator];
    isLogin = YES;
    [self setUI];
    
}

- (void)getProfileSuccessed:(id)result
{
    [self hideProgressIndicator];
    
    NSLog(@"getProfileSuccessed");
    
    NSMutableDictionary *dataDic = [(NSMutableDictionary *)result objectForKey:@"data"];
    
    UserVO *myUserVO = myUserVO =[[UserVO alloc]init];
    
    myUserVO.strId = [[dataDic objectForKey:@"id"] description];
    myUserVO.strName = [dataDic objectForKey:@"username"];
    myUserVO.strAvataUrl = [dataDic objectForKey:@"profile_picture"];
    myUserVO.strWebsite = [dataDic objectForKey:@"website"];
    myUserVO.strSign = [dataDic objectForKey:@"bio"];
    myUserVO.strFollowersCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"followed_by"] description];
    myUserVO.strFollowingCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"follows"] description];
    myUserVO.strPhotosCount = [[[dataDic objectForKey:@"counts"] objectForKey:@"media"] description];
    
    [Utils archiveMyUserVO:myUserVO];
    
    [[NSUserDefaults standardUserDefaults] setObject: myUserVO.strId forKey:MY_USER_ID_KEY];
    
    [self setUI];
    
    [self clickFollowsButton:nil];
    
}
- (void)getProfileFailed:(NSError *)error
{
    [self hideProgressIndicator];
    NSLog(@"getProfileFailed");
    [self clickButton:nil];//to loginout

     [Utils showTipViewWhenFailed:error];
}

- (void)viewDidUnload {
    [self setButtonLoginOrOut:nil];
    [super viewDidUnload];
}

//#pragma mark -
//#pragma mark MBProgressHUDDelegate methods
//
//- (void)hudWasHidden:(MBProgressHUD *)hud {
//	// Remove HUD from screen when the HUD was hidded
//	[self.progressHUD removeFromSuperview];
//	self.progressHUD = nil;
//}
@end

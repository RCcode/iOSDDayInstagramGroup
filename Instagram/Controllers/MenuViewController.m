//
//  MenuViewController.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "MenuViewController.h"
#import "FollowsViewController.h"
#import "ProfileViewController.h"
#import "PopularMediaViewController.h"
#import "SearchUsersViewController.h"
#import "Utils.h"
#import "MyLikeViewController.h"
#import "SearchMediaViewController.h"

@interface MenuViewController ()

@property (nonatomic, strong) UIButton *followersBnt;
@property (nonatomic, strong) UIButton *myProfileBnt;
@property (nonatomic, strong) UIButton *popularBnt;
@property (nonatomic, strong) UIButton *searchUsersBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *feedBtn;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.followersBnt = [[UIButton alloc]initWithFrame:CGRectMake(50, 50 + 64, 100, 30)];
    [self.followersBnt setTitle:@"Fllowers" forState:UIControlStateNormal];
    [self.followersBnt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.followersBnt addTarget:self action:@selector(clickToFllowers) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.followersBnt];
    
    self.myProfileBnt= [[UIButton alloc]initWithFrame:CGRectMake(50, 100 + 64, 100, 30)];
    [self.myProfileBnt setTitle:@"MyProfile" forState:UIControlStateNormal];
    [self.myProfileBnt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.myProfileBnt addTarget:self action:@selector(clickToMyProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myProfileBnt];
    
    self.popularBnt= [[UIButton alloc]initWithFrame:CGRectMake(50, 150 + 64, 100, 30)];
    [self.popularBnt setTitle:@"PopularMedia" forState:UIControlStateNormal];
    [self.popularBnt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.popularBnt addTarget:self action:@selector(clickToPopularMedia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.popularBnt];
    
    self.searchUsersBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200 + 64, 100, 30)];
    [self.searchUsersBtn setTitle:@"SearchUsers" forState:UIControlStateNormal];
    [self.searchUsersBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.searchUsersBtn addTarget:self action:@selector(clickToSearchUsers) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchUsersBtn];
    
    self.likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 250 + 64, 100, 30)];
    [self.likeBtn setTitle:@"Like" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(clickToLike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.likeBtn];

    self.feedBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 300 + 64, 100, 30)];
    [self.feedBtn setTitle:@"Feed" forState:UIControlStateNormal];
    [self.feedBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.feedBtn addTarget:self action:@selector(clickToFeed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.feedBtn];
}

- (void)clickToFllowers
{
    FollowsViewController *vc = [[FollowsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickToMyProfile
{
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    vc.nowUser = [Utils readUnarchiveMyUserVO];
    [self.navigationController pushViewController: vc animated:YES];
}

-(void)clickToPopularMedia
{
    PopularMediaViewController *vc = [[PopularMediaViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickToSearchUsers
{
    SearchUsersViewController *vc = [[SearchUsersViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickToLike
{
    MyLikeViewController *vc = [[MyLikeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickToFeed
{
    SearchMediaViewController *vc = [[SearchMediaViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

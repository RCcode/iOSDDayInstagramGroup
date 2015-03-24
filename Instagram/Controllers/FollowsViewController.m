//
//  FollowsViewController.m
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "FollowsViewController.h"
#import "UserCell.h"
#import "ProfileViewController.h"
#import "Utils.h"
#import "CreateGroupViewController.h"

#define  fNavBarHeight  64

@interface FollowsViewController ()

@end

@implementation FollowsViewController
@synthesize usersMutableArray;
@synthesize tabelViewFollows;
@synthesize progressHUD;

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
    self.usersMutableArray = nil;

}
-(void)setUI
{
    self.title = @"Follows";
    self.navigationController.navigationBar.translucent = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"创建分组"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self action:@selector(clickMyProfile:)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.tabelViewFollows = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tabelViewFollows.delegate = self;
    self.tabelViewFollows.dataSource = self;
    [self.view addSubview:self.tabelViewFollows];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated
{
//    //设置tabelView.contentInset，不然table会显示在navbar后面一部分
//    self.tabelViewFollows.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
//
    if ([self.usersMutableArray count]==0) {
        [InstagramTool shareInstance].delegate = self;
        [[InstagramTool shareInstance] getFollows:nil];
        [self showProgressIndicator:@"Loading"];
    }
    [super viewWillAppear: animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickMyProfile:(id)sender
{
//    ProfileViewController *vc = [[ProfileViewController alloc]init];
//    vc.nowUser = [Utils readUnarchiveMyUserVO];
//    [self.navigationController pushViewController: vc animated:YES];
    
    
    CreateGroupViewController *createGroupVC = [[CreateGroupViewController alloc] init];
    createGroupVC.usersMutableArray = self.usersMutableArray;
    [self.navigationController pushViewController:createGroupVC animated:YES];
    
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
	if(self.progressHUD) {
		[self.progressHUD hide:YES];
		self.progressHUD = nil;
	}
}


#pragma mark - instagramTool delegate
-(void)getFollowsSuccessed:(id)result
{
    [self hideProgressIndicator];
    
    if (!self.usersMutableArray) {
        self.usersMutableArray = [[NSMutableArray alloc]init];
    }
    [self.usersMutableArray removeAllObjects];
    
    NSMutableArray *datas = (NSMutableArray *)[result objectForKey:@"data"];;
    for (int i=0; i<[datas count]; i++) {
        NSMutableDictionary *dic = [datas objectAtIndex:i];
        UserVO *user = [[UserVO alloc]init];
        user.strId = [dic objectForKey:@"id"];
        user.strName = [dic objectForKey:@"username"];
        user.strAvataUrl = [dic objectForKey:@"profile_picture"];
        user.strWebsite = [dic objectForKey:@"website"];
        user.strSign = [dic objectForKey:@"bio"];
        
        [self.usersMutableArray addObject:user];
    }

    [self.tabelViewFollows reloadData];
}

-(void)getMyFollowsFailed:(NSError *)error
{
    [self hideProgressIndicator];
    [Utils showTipViewWhenFailed:error];
    
    NSLog(@"getMyFollowsFailed");

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.usersMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserCell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UserVO *aUser = [self.usersMutableArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[UserCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [cell setUI:aUser];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserVO *aUser = [self.usersMutableArray objectAtIndex:indexPath.row];
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    vc.nowUser = aUser;
    [self.navigationController pushViewController: vc animated:YES];
}

#pragma mark -

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    NSInteger num = scrollView.contentOffset.y + fNavBarHeight;
//    
//    if (num<0) {
//        num=0;
//    }
//    if (num>fNavBarHeight) {
//        num =fNavBarHeight;
//    }
//    self.navigationController.navigationBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.f,-num);
//    
//}
@end

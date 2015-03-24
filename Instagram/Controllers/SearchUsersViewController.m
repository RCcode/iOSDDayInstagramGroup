//
//  SearchUsersViewController.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "SearchUsersViewController.h"
#import "UserCell.h"
#import "SearchUserCell.h"
#import "UserVO.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "InstagramTool.h"
#import "ProfileViewController.h"
#import "Utils.h"

@interface SearchUsersViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,InstagramToolDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, strong) UITextField *textfield;
@property (strong, nonatomic)  MBProgressHUD *progressHUD;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIButton *buttonBackground;


@property (strong, nonatomic) NSString *searchStr;

@end

@implementation SearchUsersViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userArray = [[NSMutableArray alloc]init];
        self.searchStr = nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 5, 300, 35)];
    self.searchBar.delegate = self;
    _searchBar.placeholder =@"搜索";
    for (UIView *view in _searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            _textfield = [view.subviews objectAtIndex:1];
            _textfield.layer.cornerRadius =14;
            _textfield.layer.masksToBounds =YES;
        }
    }
    [self.view addSubview:self.searchBar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark SearchBar Delegate Methods

#pragma mark 点击搜索栏中的textFiled触发
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _textfield.placeholder =@"输入用户名";
    //弹出键盘的一瞬间 给背景加了一层灰色蒙版，用于点击回首键盘。
    _buttonBackground = [[UIButton alloc]initWithFrame:CGRectMake(0,40, 320, 568 -40)];
    _buttonBackground.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    [_buttonBackground addTarget:self action:@selector(buttonSearch)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBackground];
}
-(void)buttonSearch
{
    [self.textfield resignFirstResponder];
    self.buttonBackground.hidden = YES;
}

#pragma mark 点击search跳到搜索结果页

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.userArray removeAllObjects];
    self.searchStr = [searchBar text];
    [searchBar resignFirstResponder];
    if ([self.userArray count]==0) {
        [self getDataOfSearchUsers];
    }
    self.buttonBackground.hidden = YES;
    [_tableView reloadData];
}

- (void)getDataOfSearchUsers{
    
    [InstagramTool shareInstance].delegate = self;
    [[InstagramTool shareInstance] getSearchUsers:self.searchStr];
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
-(void)getSearchUsersSuccessed:(id)result
{
    [self hideProgressIndicator];
    if (!self.userArray) {
        self.userArray = [[NSMutableArray alloc]init];
    }
    [self.userArray removeAllObjects];
    
    NSMutableArray *datas = (NSMutableArray *)[result objectForKey:@"data"];;
    for (int i = 0; i<[datas count]; i++) {
        NSMutableDictionary *aDic = (NSMutableDictionary *)[datas objectAtIndex:i];
        if (!aDic) {
            break;
        }
        UserVO *aUser = [[UserVO alloc]init];
        
        aUser.strId = [aDic objectForKey:@"id"];
        aUser.strName = [[aDic objectForKey:@"username"] description];
        aUser.strFullName = [[aDic objectForKey:@"full_name"] description];
        aUser.strAvataUrl = [[aDic objectForKey:@"profile_picture"] description];
        
        [self.userArray addObject:aUser];
    }
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81.;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserCell";
    SearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UserVO *aUser = [self.userArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[SearchUserCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    [cell.imageViewBg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",aUser.strAvataUrl]]];
    cell.labelName.text = aUser.strName;
    cell.labelFullName.text = aUser.strFullName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserVO *aUser = [self.userArray objectAtIndex:indexPath.row];
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    vc.nowUser = aUser;
    [self.navigationController pushViewController: vc animated:YES];
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

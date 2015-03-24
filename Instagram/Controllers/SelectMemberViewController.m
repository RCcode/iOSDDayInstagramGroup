//
//  SelectMemberViewController.m
//  Instagram
//
//  Created by gaoluyangrc on 15-3-20.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "SelectMemberViewController.h"
#import "UserVO.h"
#import "UsersViewController.h"
#import "DataBaseHandle.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

@interface SelectMemberViewController ()
{
    UIBarButtonItem *addBarButton ;
    UIBarButtonItem *editBarButton;
    UIBarButtonItem *deleteBarButton;
}

@property (nonatomic,strong)NSMutableArray *userArray;

@end

@implementation SelectMemberViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userArray = [[DataBaseHandle shareInstance] selectUsersWithGroupName:self.groupName];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.title = self.groupName;
    
    addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    deleteBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(delete:)];

    if (![self.title isEqualToString:@"未分组"]) {
        self.navigationItem.rightBarButtonItems = @[addBarButton,editBarButton] ;
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
    }
}

- (void)add:(UIBarButtonItem *)barButton
{
    UsersViewController *userVC = [[UsersViewController alloc] init];
    userVC.usersMutableArray = self.usersMutableArray;
    userVC.groupName = self.groupName;
    [self.navigationController pushViewController:userVC animated:YES];
    
}

- (void)edit:(UIBarButtonItem *)barButton
{
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItems = @[addBarButton,deleteBarButton];
}

- (void)delete:(UIBarButtonItem *)bar
{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *deleteArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in array) {
        UserVO *user = self.userArray[indexPath.row];
        [deleteArray addObject:user];
        [[DataBaseHandle shareInstance] updateGroupName:@"未分组" WithUserID:user.strId];
    }
    
    [self.userArray removeObjectsInArray:deleteArray];
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    
    self.navigationItem.rightBarButtonItems = @[addBarButton,editBarButton];
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.userArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"select"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"select"];
    }
    
    UserVO *user = self.userArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.strAvataUrl] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]];
    cell.textLabel.text = user.strName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.isEditing) {
        return;
    }
    
    UserVO *aUser = [self.userArray objectAtIndex:indexPath.row];
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    vc.nowUser = aUser;
    [self.navigationController pushViewController: vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

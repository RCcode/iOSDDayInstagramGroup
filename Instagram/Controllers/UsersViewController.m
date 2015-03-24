//
//  UsersViewController.m
//  Instagram
//
//  Created by gaoluyangrc on 15-3-21.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "UsersViewController.h"
#import "UserVO.h"
#import "DataBaseHandle.h"
#import "UIImageView+AFNetworking.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = barButton;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    NSArray *arr = [[DataBaseHandle shareInstance] selectUsersWithGroupName:self.groupName];
    NSMutableArray *deleteArray = [NSMutableArray arrayWithCapacity:1];
    
    for (UserVO *user in arr) {
        for (UserVO *user1 in self.usersMutableArray) {
            if ([user1.strId isEqualToString:user.strId]) {
                [deleteArray addObject:user1];
            }
        }
    }
    
    [self.usersMutableArray removeObjectsInArray:deleteArray];
    [self setEditing:YES animated:YES];
}

- (void)done:(UIBarButtonItem *)barButton
{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in array) {
        UserVO *user = self.usersMutableArray[indexPath.row];
        [[DataBaseHandle shareInstance] updateGroupName:self.groupName WithUserID:user.strId];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersMutableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"user"];
    }
    
    UserVO *user = self.usersMutableArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.strAvataUrl] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]];
    cell.textLabel.text = user.strName;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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

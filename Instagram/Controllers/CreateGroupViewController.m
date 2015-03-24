//
//  CreateGroupViewController.m
//  Instagram
//
//  Created by gaoluyangrc on 15-3-20.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "SelectMemberViewController.h"
#import "CreateGroupView.h"
#import "DataBaseHandle.h"

@interface CreateGroupViewController ()<createGroupViewDelegate>
{
    CreateGroupView *groupView;
    UIBarButtonItem *addBarButton ;
    UIBarButtonItem *editBarButton;
    UIBarButtonItem *deleteBarButton;
}

@property (nonatomic,strong)NSMutableArray *groupName;

@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"我的分组";
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    self.groupName = [[DataBaseHandle shareInstance] selectAllGroup];
    [self.groupName insertObject:@"未分组" atIndex:0];
    
    addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    deleteBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(delete:)];
    self.navigationItem.rightBarButtonItems = @[addBarButton,editBarButton];
    
    for (UserVO *user in self.usersMutableArray) {
        [[DataBaseHandle shareInstance] insertUser:user];
    }
}

- (void)didClickConfirm
{
    NSString *str = groupView.textView.text;
    if (str == nil || [str isEqualToString:@""]) {
        return;
    }
    
    [self.groupName addObject:str];
    [[DataBaseHandle shareInstance] insertGroup:str];
    
    [groupView removeFromSuperview];
    [self.tableView reloadData];
}

- (void)add:(UIBarButtonItem *)barButotn
{
    groupView = [[CreateGroupView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    groupView.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    groupView.delegate = self;
    [self.view addSubview:groupView];
    [groupView.textView becomeFirstResponder];
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
        NSString *groupName = self.groupName[indexPath.row];
        [deleteArray addObject:groupName];
        [[DataBaseHandle shareInstance] deleteGroup:groupName];
    }
    
    [self.groupName removeObjectsInArray:deleteArray];
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    
    self.navigationItem.rightBarButtonItems = @[addBarButton,editBarButton];
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.groupName[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.isEditing) {
        return;
    }
    SelectMemberViewController *selectVC = [[SelectMemberViewController alloc] init];
    selectVC.usersMutableArray = self.usersMutableArray;
    selectVC.groupName = self.groupName[indexPath.row];
    [self.navigationController pushViewController:selectVC animated:YES];
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

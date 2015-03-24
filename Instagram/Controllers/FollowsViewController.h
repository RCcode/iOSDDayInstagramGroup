//
//  FollowsViewController.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "InstagramTool.h"

@interface FollowsViewController : UIViewController<InstagramToolDelegate,UITableViewDelegate,UITableViewDataSource>
{
     MBProgressHUD                   *progressHUD;
}
@property (strong, nonatomic) UITableView *tabelViewFollows;
@property(nonatomic,strong) NSMutableArray          *usersMutableArray;
@property (strong, nonatomic)  MBProgressHUD        *progressHUD;
@end

//
//  ViewController.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "InstagramTool.h"

@interface LoginViewController : UIViewController<InstagramToolDelegate>//,MBProgressHUDDelegate
{
     MBProgressHUD                   *progressHUD;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonLoginOrOut;
@property (strong, nonatomic)  MBProgressHUD        *progressHUD;

@end

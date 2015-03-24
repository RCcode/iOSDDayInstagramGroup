//
//  TipInfoView.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/31/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipInfoView : UIView
{
    IBOutlet UILabel *infoLabel;
    IBOutlet UIImageView *infoImageView;
    BOOL bIsAppear;
}
+ (TipInfoView*)getInstanceWithNib;
- (void)appear:(NSString*)strText;

@end

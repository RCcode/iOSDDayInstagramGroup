//
//  EditSelectionCell.h
//  MatchPlus3
//
//  Created by iObitLXF on 3/15/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediasView.h"
#import "RCQuiltView.h"

@interface MediaCell : UITableViewCell

@property (strong, nonatomic) RCQuiltView *mediasView;

//+(MediaCell*)getInstanceWithNib;

@end

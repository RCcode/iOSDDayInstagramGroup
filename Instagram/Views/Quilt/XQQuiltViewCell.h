//
//  LXFQuiltViewCell.h
//  MatchPlus3
//
//  Created by iObitLXF on 4/7/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMQuiltViewCell.h"

@class MediaVO;
@interface XQQuiltViewCell : UICollectionViewCell


@property (nonatomic, retain) IBOutlet  UIImageView     *photoView;
@property (nonatomic, retain)  IBOutlet UIView           *infoView;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;
@property (weak, nonatomic) IBOutlet UILabel     *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTip;

@property (nonatomic, retain)   NSString        *photoUrlStr;


@property (nonatomic, retain)   NSString        *distanceStr;
@property (nonatomic, retain)   NSString        *viewId;

+(XQQuiltViewCell*)getInstanceWithNib;
-(void)setUI:(MediaVO *)aMedia;

@end

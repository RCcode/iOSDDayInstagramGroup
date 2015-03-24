//
//  NearbyDatingCell.h
//  MatchPlus3
//
//  Created by iObitLXF on 3/20/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVO.h"
@interface UserCell : UITableViewCell

@property(nonatomic,strong)UserVO  *userNow;

@property (strong, nonatomic) UILabel *labelName;

@property (strong, nonatomic) UIImageView *imageViewPhoto;

-(void)setUI:(UserVO *)aUserVo;

@end


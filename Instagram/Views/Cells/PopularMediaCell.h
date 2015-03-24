//
//  PopularMediaCell.h
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaVO.h"

@interface PopularMediaCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

-(void)setMeidaVo:(MediaVO *)users;

@end

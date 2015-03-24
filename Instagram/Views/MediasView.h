//
//  PersonInfoSectionView.h
//  MatchPlus3
//
//  Created by iObitLXF on 3/5/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMQuiltView.h"
#import "MediaVO.h"

#define kLXFQuiltViewDefaultCellHeight 100.0f

@protocol MediasViewDelegate;

@interface MediasView : UIView<TMQuiltViewDataSource, TMQuiltViewDelegate>

@property (strong, nonatomic)  TMQuiltView *quiltView;
@property (nonatomic, strong) NSMutableArray    *dataMutableAry;

@property (nonatomic, assign) id <MediasViewDelegate> delegate;

@end

@protocol MediasViewDelegate <NSObject>
@optional
- (void)didSelectCellWithMediaVo:(MediaVO *)aVOg;

@end

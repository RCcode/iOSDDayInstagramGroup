//
//  RCQuiltView.h
//  Instagram
//
//  Created by zhao liang on 15/3/18.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"

@interface RCQuiltView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray *mediaArray;
@property (nonatomic, strong) ProfileViewController *pc;

-(void)setDataMutableAry:(NSMutableArray *)dataMutableAry;
-(void)setController:(ProfileViewController *)pc;
@end

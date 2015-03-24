//
//  RCQuiltView.m
//  Instagram
//
//  Created by zhao liang on 15/3/18.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "RCQuiltView.h"
//#import "XQQuiltViewCell.h"
#import "SaveMediaViewController.h"
#import "MediaVO.h"
#import "ProfileViewController.h"
#import "PopularMediaCell.h"

static NSString * const reuseIdentifier = @"Cell";

@implementation RCQuiltView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize=CGSizeMake(100,100);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.dataSource= self;
        self.collectionView.delegate= self;
        [self.collectionView setBackgroundColor:[UIColor grayColor]];
        //    [self.collectionView setCollectionViewLayout:flowLayout];
        [self.collectionView registerClass:[PopularMediaCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [self addSubview:self.collectionView];

    }
    return self;
}

-(void)setDataMutableAry:(NSMutableArray *)dataMutableAry
{
    if (!_mediaArray) {
        _mediaArray = [[NSMutableArray alloc]init];
    }
    [_mediaArray removeAllObjects];
    [_mediaArray addObjectsFromArray:dataMutableAry];
    
    [self.collectionView reloadData];
}
-(void)setController:(ProfileViewController *)pc
{
    self.pc = pc;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_mediaArray.count == 0) {
        return 0;
    }else {
        return _mediaArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopularMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    MediaVO *media = _mediaArray[indexPath.row];
    [cell setMeidaVo:media];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ClickCell_quiltView");

    SaveMediaViewController *vc = [[SaveMediaViewController alloc]init];
    MediaVO *media = _mediaArray[indexPath.row];
    vc.imageUrl = media.strStandardImageUrl;
    vc.type = media.strType;
    vc.videoUrl = media.strVideoUrl;
//    [pc presentViewController:vc animated:YES completion:nil];
    [self.pc.navigationController pushViewController:vc animated:YES];
}



@end

//
//  SearchMediaViewController.m
//  Instagram
//
//  Created by zhao liang on 15/3/19.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "SearchMediaViewController.h"
#import "MBProgressHUD.h"
#import "InstagramTool.h"
#import "PopularMediaCell.h"
#import "SaveMediaViewController.h"
#import "Utils.h"

@interface SearchMediaViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,InstagramToolDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *mediaArray;
@property (strong, nonatomic)  MBProgressHUD *progressHUD;

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation SearchMediaViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.mediaArray = [[NSMutableArray alloc]init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = YES;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(100,100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
    //    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[PopularMediaCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.collectionView];

}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.mediaArray count]==0) {
        [InstagramTool shareInstance].delegate = self;
        [[InstagramTool shareInstance] getSearchMedias:@"snow"];
        [self showProgressIndicator:@"Loading"];
    }
    [super viewWillAppear:animated];
}

- (void)showProgressIndicator:(NSString *)text {
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.view.userInteractionEnabled = FALSE;
    if(!self.progressHUD) {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.progressHUD];
    }
    //    progressHUD.delegate = self;
    self.progressHUD.labelText = text;
    [self.progressHUD show:YES];
}



- (void)hideProgressIndicator {
    self.view.userInteractionEnabled = TRUE;
    if(self.progressHUD) {
        [self.progressHUD hide:YES];
        self.progressHUD = nil;
        
    }
}

#pragma mark - instagramTool delegate
-(void)getSearchMediasSuccessed:(id)result
{
    [self hideProgressIndicator];
    
    if (!self.mediaArray) {
        self.mediaArray = [[NSMutableArray alloc]init];
    }
    [self.mediaArray removeAllObjects];
    
    NSMutableArray *datas = (NSMutableArray *)[result objectForKey:@"data"];;
    for (int i = 0; i<[datas count]; i++) {
        NSMutableDictionary *aDic = (NSMutableDictionary *)[datas objectAtIndex:i];
        if (!aDic) {
            break;
        }
        NSMutableDictionary *imageDic = (NSMutableDictionary *)[aDic objectForKey:@"images"];
        NSMutableDictionary *videoDic = (NSMutableDictionary *)[aDic objectForKey:@"videos"];
        
        MediaVO *aMedia = [[MediaVO alloc]init];
        aMedia.strId = [aDic objectForKey:@"id"];
        aMedia.strCreateTime = [[aDic objectForKey:@"created_time"] description];
        aMedia.strLikeCount = [[[aDic objectForKey:@"likes"] objectForKey:@"count"] description];
        aMedia.strCommentCount = [[[aDic objectForKey:@"comments"] objectForKey:@"count"] description];
        aMedia.strType = [[aDic objectForKey:@"type"] description];
        if (imageDic) {
            aMedia.strLowImageUrl = [[imageDic objectForKey:@"low_resolution"] objectForKey:@"url"];
            aMedia.strStandardImageUrl = [[imageDic objectForKey:@"standard_resolution"] objectForKey:@"url"];
            aMedia.strThumbnailImageUrl = [[imageDic objectForKey:@"thumbnail"] objectForKey:@"url"];
        }
        if (videoDic) {
            aMedia.strVideoUrl = [[videoDic objectForKey:@"low_resolution"] objectForKey:@"url"];
        }
        
        [self.mediaArray addObject:aMedia];
        
    }
    
    [self.collectionView reloadData];
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
    SaveMediaViewController *vc = [[SaveMediaViewController alloc]init];
    MediaVO *media = _mediaArray[indexPath.row];
    vc.imageUrl = media.strStandardImageUrl;
    vc.type = media.strType;
    vc.videoUrl = media.strVideoUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)getSearchMediasFailed:(NSError *)error
{
    [self hideProgressIndicator];
    [Utils showTipViewWhenFailed:error];
    
    NSLog(@"getMyFollowsFailed");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SaveMediaViewController.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/16.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "SaveMediaViewController.h"
#import "UIImageView+AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kToInstagramPath [kDocumentPath stringByAppendingPathComponent:@"NoCrop_Share_Image.igo"]
#define kToMorePath [kDocumentPath stringByAppendingPathComponent:@"NoCrop_Share_Image.jpg"]
#define kShareHotTags @"#Photo Effects"

@interface SaveMediaViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)UIButton *shareBtn;
@property (nonatomic, strong)MPMoviePlayerViewController *moviePlayerView;
@property (nonatomic, strong)UIAlertView *alert;
@property (nonatomic, strong)UIAlertView *alert1;
@property (strong ,nonatomic) UIDocumentInteractionController *documetnInteractionController;

@end

@implementation SaveMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 320)];
    [self.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]]];
    [self.view addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    
    if ([self.type isEqualToString:@"video"]) {
        UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        [playBtn setBackgroundColor:[UIColor clearColor]];
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [playBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(clickToplay) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:playBtn];
    }
    

    
    
    self.saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 394, 200, 40)];
    [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([self.type isEqualToString:@"video"]) {
        [self.saveBtn addTarget:self action:@selector(clickToSaveVideo) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [self.saveBtn addTarget:self action:@selector(clickToSaveImage) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.saveBtn];
    
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 444, 200, 40)];
    [self.shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([self.type isEqualToString:@"video"]) {
        [self.shareBtn addTarget:self action:@selector(clickToSaveVideo) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [self.shareBtn addTarget:self action:@selector(clickToShareImage) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.shareBtn];
    
}

-(void)clickToShareImage
{
//    [PRJ_Global event:@"share_instagram" label:@"Share"];
//    [PRJ_Global shareStance].showBackMsg = NO;
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if (![[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"你没有安装Instagram"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    //保存本地 如果已存在，则删除
    if([[NSFileManager defaultManager] fileExistsAtPath:kToInstagramPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:kToInstagramPath error:nil];
    }
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]]]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    [imageData writeToFile:kToInstagramPath atomically:YES];
    
    //分享
    NSURL *fileURL = [NSURL fileURLWithPath:kToInstagramPath];
    self.documetnInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documetnInteractionController.UTI = @"com.instagram.exclusivegram";
    self.documetnInteractionController.annotation = @{@"InstagramCaption":kShareHotTags};
    [self.documetnInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];

}


-(void)clickToSaveImage
{
    self.alert = [[UIAlertView alloc] initWithTitle:@"确定保存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
        [self.alert show];
}

-(void)clickToSaveVideo
{
    self.alert1 = [[UIAlertView alloc] initWithTitle:@"确定保存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
    [self.alert1 show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alert) {
        if (buttonIndex == 1) {
             UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]]]], self, nil, nil);
        }
    } else if (alertView == self.alert1){
        if (buttonIndex == 1) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:self.videoUrl]
                                        completionBlock:^(NSURL *assetURL, NSError *error) {
                                            if (error) {
                                                NSLog(@"Save video fail:%@",error);
                                            } else {
                                                NSLog(@"Save video succeed.");
                                            }
                                        }];
        }
    }
}

-(void)clickToplay
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.videoUrl]];
    _moviePlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:_moviePlayerView];
    [_moviePlayerView.moviePlayer play];
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

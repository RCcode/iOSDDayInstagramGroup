//
//  LXFQuiltViewCell.m
//  MatchPlus3
//
//  Created by iObitLXF on 4/7/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import "XQQuiltViewCell.h"
#import "MediaVO.h"
#import "UIImageView+AFNetworking.h"

@implementation XQQuiltViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

+(XQQuiltViewCell*)getInstanceWithNib
{
    XQQuiltViewCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"XQQuiltViewCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[XQQuiltViewCell class]]){
            
            cell = (XQQuiltViewCell *)obj;
            cell.backgroundColor = [UIColor whiteColor];
           
            break;
        }
    }
    return cell;
}

-(void)setUI:(MediaVO *)aMedia
{
    self.viewId = aMedia.strId;
    self.photoUrlStr = aMedia.strStandardImageUrl;
    
    self.photoView.image = nil;
    NSURL *url = [NSURL URLWithString:self.photoUrlStr];
    [self.photoView  setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photo-placeholder.png"]];
    //在此初始化infoView，则infoView加在最上面
    self.labelName.text  = aMedia.strLikeCount;

}
@end

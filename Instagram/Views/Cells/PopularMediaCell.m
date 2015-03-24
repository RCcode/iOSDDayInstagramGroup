//
//  PopularMediaCell.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "PopularMediaCell.h"
#import "UIImageView+AFNetworking.h"

@implementation PopularMediaCell

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 106, 106)];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)setMeidaVo:(MediaVO *)users
{
    [self.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",users.strThumbnailImageUrl]]placeholderImage:[UIImage imageNamed:@"photo-placeholder.png"]];
}
@end

//
//  NearbyDatingCell.m
//  MatchPlus3
//
//  Created by iObitLXF on 3/20/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//
#import "UserCell.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageViewPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 75, 75)];
        [self addSubview:self.imageViewPhoto];
        
        self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200, 30)];
        [self addSubview:self.labelName];
        
     }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setUI:(UserVO *)aUserVo
{
    self.labelName.text = aUserVo.strName;
    
    NSURL *urlAvata = [NSURL URLWithString:aUserVo.strAvataUrl];
    [self.imageViewPhoto setImageWithURL:urlAvata placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]];
    
}

@end

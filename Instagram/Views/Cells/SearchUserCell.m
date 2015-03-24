//
//  SearchUserCell.m
//  XQInstgClient
//
//  Created by zhao liang on 15/3/13.
//  Copyright (c) 2015年 iObitLXF. All rights reserved.
//

#import "SearchUserCell.h"

@implementation SearchUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:self.imageViewBg];
        
        self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 100, 20)];
        [self addSubview:self.labelName];
        
        self.labelFullName = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 100, 20)];
        [self addSubview:self.labelFullName];
    }
    return self;
}


@end

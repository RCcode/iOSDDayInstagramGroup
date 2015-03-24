//
//  EditSelectionCell.m
//  MatchPlus3
//
//  Created by iObitLXF on 3/15/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import "MediaCell.h"

@implementation MediaCell
@synthesize mediasView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mediasView = [[RCQuiltView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 130 - 64)];
        [self addSubview:self.mediasView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//+(MediaCell*)getInstanceWithNib{
//    
//    MediaCell *cell = nil;
//    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"MediaCell" owner:nil options:nil];
//    for(id obj in objs) {
//        if([obj isKindOfClass:[MediaCell class]]){
//            [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 130 - 64)];
//            cell = (MediaCell *)obj;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            cell.mediasView = [[RCQuiltView alloc]initWithFrame:cell.frame];
//            cell.mediasView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//            [cell.contentView addSubview:cell.mediasView];
// 
//            break;
//        }
//    }
//
//    return cell;
//}
@end

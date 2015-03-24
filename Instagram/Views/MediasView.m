//
//  PersonInfoSectionView.m
//  MatchPlus3
//
//  Created by iObitLXF on 3/5/13.
//  Copyright (c) 2013 andylee1988. All rights reserved.
//

#import "MediasView.h"
#import "XQQuiltViewCell.h"
#import "MediaVO.h"

#define ColumnNum 3
#define QuiltCellHeight 100
#define CellMargin  5

@implementation MediasView

@synthesize quiltView = _quiltView;
@synthesize dataMutableAry = _dataMutableAry;
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.quiltView = [[TMQuiltView alloc] initWithFrame:self.frame];
        self.quiltView.delegate = self;
        self.quiltView.dataSource = self;
        self.quiltView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.quiltView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.quiltView];
    }
    return self;
}

- (void)dealloc {
    self.quiltView = nil;
}

-(void)setDataMutableAry:(NSMutableArray *)dataMutableAry
{
    if (!_dataMutableAry) {
        _dataMutableAry = [[NSMutableArray alloc]init];
    }
    [_dataMutableAry removeAllObjects];
    [_dataMutableAry addObjectsFromArray:dataMutableAry];
    
    [self.quiltView reloadData];
}


#pragma mark - TMQuiltViewDataSource

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)quiltView {
    return [self.dataMutableAry count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    XQQuiltViewCell *cell = (XQQuiltViewCell *)[self.quiltView dequeueReusableCellWithReuseIdentifier:@"XQQuiltViewCell"];
    if (!cell) {
        cell = [XQQuiltViewCell getInstanceWithNib];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    MediaVO *aMedia = [self.dataMutableAry objectAtIndex:indexPath.row];
    [cell setUI:aMedia];
    //    cell.imageViewTip.backgroundColor = ([aUser getBIsOnline] == YES)?[UIColor greenColor]:[UIColor lightGrayColor];
    //    [cell.imageViewTip.layer setMasksToBounds:YES];
    //    [cell.imageViewTip.layer setCornerRadius:cell.imageViewTip.bounds.size.width/2];
    //    cell.imageViewTip.layer.borderColor = [[UIColor whiteColor] CGColor];
    //    cell.imageViewTip.layer.borderWidth = 1.0;
    
    cell.tag = indexPath.row;
    
    return cell;
    
    
    
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    
    return ColumnNum;
    
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    return QuiltCellHeight;
}
//cell 间隙
- (CGFloat)quiltViewMargin:(TMQuiltView *)quilView marginType:(TMQuiltViewMarginType)marginType{
    return CellMargin;
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ClickCell_quiltView");
    
    if([self.dataMutableAry count]>indexPath.row)
    {
        if (delegate && [delegate respondsToSelector:@selector(didSelectCellWithMediaVo:)]) {
             MediaVO *aVO = [self.dataMutableAry objectAtIndex:indexPath.row];
            [delegate didSelectCellWithMediaVo:aVO];
        }
    }
    
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //判断是否加载更多
//    [self loadMoreOrNot:scrollView.contentOffset.y];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//	[refreshView scrollViewDidScroll];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
//	[refreshView scrollViewDidEndDraging];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animationOfAccessoryView) object:nil];
}


@end

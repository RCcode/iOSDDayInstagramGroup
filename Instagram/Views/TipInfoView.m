//
//  TipInfoView.m
//  XQInstgClient
//
//  Created by iObitLXF on 5/31/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "TipInfoView.h"
#import "Utils.h"
#import "Global.h"

static TipInfoView *tipInfoView = nil;

@implementation TipInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (TipInfoView*)getInstanceWithNib {
    @synchronized(self) {
        if (!tipInfoView) {
            NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"TipInfoView" owner:nil options:nil];
            for(id obj in objs) {
                if([obj isKindOfClass:[TipInfoView class]]){
                    tipInfoView = [(TipInfoView *)obj retain];
                    break;
                }
            }
            return tipInfoView;
        } else {
            return tipInfoView;
        }
    }
}

- (void)appear:(NSString*)strText {
    @synchronized(self) {
        self.frame = CGRectMake(42, 100, 236, 75);
        infoLabel.text = strText;
        infoLabel.textColor =[UIColor darkGrayColor];
        infoLabel.font = [UIFont boldSystemFontOfSize:14];
        infoLabel.frame = CGRectMake(15, 24, 206, [Utils heightOfText:infoLabel.text theWidth:206 theFont:infoLabel.font]);
        infoImageView.frame = CGRectMake(0, 0, 236, 56 + [Utils heightOfText:infoLabel.text theWidth:206 theFont:infoLabel.font]);
        UIImage *image = [UIImage imageNamed:@"errow-bg.png"];
        [infoImageView setImage:[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2]];
        if (!bIsAppear) {
//            [MyAppDelegate.window addSubview:self];
            bIsAppear = YES;
        }
    }
    self.alpha = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    self.alpha = 1;
    [UIView commitAnimations];
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(disAppear) object:nil];
    [self performSelector:@selector(disAppear) withObject:nil afterDelay:3];
}

- (void)disAppear {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hidden)];
	
	self.alpha = 0;
	
	[UIView commitAnimations];
}

- (void)hidden {
    if (self.alpha > 0) {
        return;
    }
    @synchronized(self) {
        [self removeFromSuperview];
        bIsAppear = NO;
    }
}

@end

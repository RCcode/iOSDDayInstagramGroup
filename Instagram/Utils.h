//
//  Utils.h
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UserVO.h"
#import <UIKit/UIKit.h>

@interface UIProgressIndicator : UIActivityIndicatorView {
}

+ (struct CGSize)size;
- (int)progressIndicatorStyle;
- (void)setProgressIndicatorStyle:(int)fp8;
- (void)setStyle:(int)fp8;
- (void)setAnimating:(BOOL)fp8;
- (void)startAnimation;
- (void)stopAnimation;
@end

@interface UIProgressHUD : UIView {
    UIProgressIndicator *_progressIndicator;
    UILabel *_progressMessage;
    UIImageView *_doneView;
    UIWindow *_parentWindow;
    struct {
        unsigned int isShowing:1;
        unsigned int isShowingText:1;
        unsigned int fixedFrame:1;
        unsigned int reserved:30;
    } _progressHUDFlags;
}

- (id)_progressIndicator;
- (id)initWithFrame:(struct CGRect)fp8;
- (void)setText:(id)fp8;
- (void)setShowsText:(BOOL)fp8;
- (void)setFontSize:(int)fp8;
- (void)drawRect:(struct CGRect)fp8;
- (void)layoutSubviews;
- (void)showInView:(id)fp8;
- (void)hide;
- (void)done;
- (void)dealloc;
@end

@interface Utils : NSObject
{}
+ (NSString*)getMyId;
+ (UserVO*)readUnarchiveMyUserVO ;
+ (void)archiveMyUserVO:(UserVO*)aUserVO;
+ (CGFloat)heightOfText:(NSString *)text theWidth:(float)width theFont:(UIFont*)aFont;
+(void)showTipViewWhenFailed:(NSError *)error;
@end

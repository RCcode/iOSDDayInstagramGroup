//
//  Utils.m
//  XQInstgClient
//
//  Created by iObitLXF on 5/27/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "Utils.h"
#import "UserVO.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
#import "TipInfoView.h"
#import "Global.h"

@implementation Utils
+ (NSString*)getMyId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:MY_USER_ID_KEY];
}

+ (UserVO*)readUnarchiveMyUserVO {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:MY_USERVO_KEY];
    NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    UserVO *uVO = [myKeyedUnarchiver decodeObject];
    [myKeyedUnarchiver finishDecoding];
    [myKeyedUnarchiver release];
    return uVO;
}


+ (void)archiveMyUserVO:(UserVO*)aUserVO {
    if (aUserVO) {
        NSMutableData *mData = [[NSMutableData alloc] init];
        NSKeyedArchiver *myKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
        [myKeyedArchiver encodeObject:aUserVO];
        [myKeyedArchiver finishEncoding];
        
        [[NSUserDefaults standardUserDefaults] setObject:mData forKey:MY_USERVO_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [myKeyedArchiver release];
        [mData release];
    }
}

+ (CGFloat)heightOfText:(NSString *)text theWidth:(float)width theFont:(UIFont*)aFont {
	CGFloat result;
	CGSize textSize = { width, 20000.0f };
	CGSize size = [text sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	result = size.height;
	return result;
}
+(void)showTipViewWhenFailed:(NSError *)error
{
    NSString *strError = [error localizedDescription];
    if (!strError || [strError isEqualToString:@""]) {
        strError = @"Unknown error";
    }
    [[TipInfoView getInstanceWithNib] appear:strError];

}

@end

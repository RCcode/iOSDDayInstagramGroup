//
//  CreateGroupView.h
//  Instagram
//
//  Created by gaoluyangrc on 15-3-20.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol createGroupViewDelegate <NSObject>

@optional
- (void)didClickConfirm;

@end

@interface CreateGroupView : UIView

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,weak) id<createGroupViewDelegate> delegate;

@end

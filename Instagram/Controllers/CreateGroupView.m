//
//  CreateGroupView.m
//  Instagram
//
//  Created by gaoluyangrc on 15-3-20.
//  Copyright (c) 2015年 zhao liang. All rights reserved.
//

#import "CreateGroupView.h"

@implementation CreateGroupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 10, 150, 40)];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_textView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(50, 65, 100, 30);
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    return self;
}

- (void)confirmButtonClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(didClickConfirm)]) {
        [_delegate didClickConfirm];
    }
}

@end

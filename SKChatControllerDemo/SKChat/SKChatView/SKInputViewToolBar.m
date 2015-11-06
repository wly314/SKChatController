//
//  SKInputViewToolBar.m
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/26.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "SKInputViewToolBar.h"

@implementation SKInputViewToolBar

@synthesize delegate = _delegate;

@synthesize skFaceButton  = _skFaceButton;
@synthesize skInputTextView = _skInputTextView;
@synthesize skAddButton = _skAddButton;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        skContentView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:skContentView];
        
        _skFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skFaceButton addTarget:self action:@selector(skFaceButton:showOrHideFaceKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_skFaceButton];
        
        _skInputTextView = [[UITextView alloc] init];
        _skInputTextView.layer.cornerRadius = 2.5f;
        _skInputTextView.font = [UIFont systemFontOfSize:16.0f];
        _skInputTextView.showsHorizontalScrollIndicator = NO;
        _skInputTextView.showsVerticalScrollIndicator = NO;
        _skInputTextView.delegate = self;
        _skInputTextView.returnKeyType = UIReturnKeySend;
        
        [self addSubview:_skInputTextView];
        
        _skAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skAddButton addTarget:self action:@selector(skAddButton:showOrHideMoreKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_skAddButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    skContentView.backgroundColor = self.backgroundColor;
    skContentView.frame = self.bounds;
    
    _skFaceButton.frame = CGRectMake(5, 7.5, 30, 30);
    [_skFaceButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor.png"] forState:UIControlStateNormal];
    [_skFaceButton setImage:[UIImage imageNamed:@"chat_bottom_smile_press.png"] forState:UIControlStateHighlighted];
    
    _skInputTextView.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 40 - 5 - 30 - 5, 35);
    
    _skAddButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-5-30, 7.5, 30, 30);
    [_skAddButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor.png"] forState:UIControlStateNormal];
    [_skAddButton setImage:[UIImage imageNamed:@"chat_bottom_up_press.png"] forState:UIControlStateHighlighted];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        //textView点击return键 失去焦点
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    return YES;
}

#pragma mark - SKInputViewToolBarDelegate
//faceBoard点击方法 判断是否显示表情键盘
- (void)skFaceButton:(UIButton *)skFaceButton showOrHideFaceKeyBoard:(BOOL)isShow {
    
    if ([_delegate respondsToSelector:@selector(skFaceButton:showOrHideFaceKeyBoard:)]) {
        
        
    }
}

//加号（➕）按钮点击方法 判断是否显示更多内容键盘
- (void)skAddButton:(UIButton *)skAddButton showOrHideMoreKeyBoard:(BOOL)isShow {
    
    if ([_delegate respondsToSelector:@selector(skAddButton:showOrHideMoreKeyBoard:)]) {
        
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

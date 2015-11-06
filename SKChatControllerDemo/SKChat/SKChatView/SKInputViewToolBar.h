//
//  SKInputViewToolBar.h
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/26.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKInputViewToolBarDelegate;

@interface SKInputViewToolBar : UIView <UITextViewDelegate> {
    
    UIView *skContentView;//内容容器View
    
    BOOL    isFaceKeyBoardShow;//表情键盘是否显示
    BOOL    isAddMoreBoardShow;//加号按钮点击更多是否显示
}

@property (nonatomic, weak)id <SKInputViewToolBarDelegate> delegate;

@property (nonatomic, strong)UIButton   *skFaceButton;//表情按钮
@property (nonatomic, strong)UITextView *skInputTextView;//输入文本框
@property (nonatomic, strong)UIButton   *skAddButton;//加号按钮

@end


@protocol SKInputViewToolBarDelegate <NSObject>

@optional
//faceBoard点击方法 判断是否显示表情键盘
- (void)skFaceButton:(UIButton *)skFaceButton showOrHideFaceKeyBoard:(BOOL)isShow;
//加号（➕）按钮点击方法 判断是否显示更多内容键盘
- (void)skAddButton:(UIButton *)skAddButton showOrHideMoreKeyBoard:(BOOL)isShow;

@end
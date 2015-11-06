//
//  SKXmppMessageCell.h
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/30.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKLabel : UILabel

@end

//文本的字体大小
#define CONTENT_LABEL_FONT_SIZE 17.0

/*
 *SKCellType  Cell 样式
 */
//联系人和群组Cell样式
typedef NS_OPTIONS(NSInteger, SKMessageType) {
    
    SKMessageTypeNone,   //普通样式 default
    SKMessageTypeSend,   //message样式发送者
    SKMessageTypeReviced //message样式接收者
} NS_ENUM_AVAILABLE(10_0, 7_0);

@interface SKChatMessageCell : UITableViewCell {
    
    @private
    UIView  *skContentBackgroundView;//内容区域的背景
}

@property (nonatomic, assign)SKMessageType skMessageType;

@property (nonatomic, strong)UIImageView *skAvatarImageView;//头像
@property (nonatomic, strong)UIImageView *skPaopaoImageView;//聊天消息气泡泡
@property (nonatomic, strong)SKLabel     *skContentLabel;//聊天内容

//获取起泡大小 －此方法仅适用于该聊天计算高度
+ (CGRect)contentRectOfString:(NSAttributedString *)aString;

@end

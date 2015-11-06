//
//  SKXmppMessageCell.m
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/30.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "SKChatMessageCell.h"

@implementation SKLabel

- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth {
    
    CGSize size = [self sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    size.width = fmin(size.width, maxWidth); //在numberOfLine为1模式下返回的可能会比maxWidth大，所以这里我们限制下
    return size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    size = [super sizeThatFits:size];
    if (size.height>0) {
        
        size.height++;
    }
    return size;
}

@end

@implementation SKChatMessageCell

@synthesize skMessageType = _skMessageType;
@synthesize skAvatarImageView = _skAvatarImageView;
@synthesize skPaopaoImageView = _skPaopaoImageView;

@synthesize skContentLabel = _skContentLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        skContentBackgroundView = [[UIView alloc] init];
        skContentBackgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:skContentBackgroundView];
        
        _skAvatarImageView = [[UIImageView alloc] init];
        [_skAvatarImageView setImage:[UIImage imageNamed:@"sk_shishengjiaoliu_xzb.png"]];
        _skAvatarImageView.layer.cornerRadius = 20.0f;
        [skContentBackgroundView addSubview:_skAvatarImageView];
        
        //聊天气泡要放置聊天内容的下面
        _skPaopaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, self.bounds.size.width - (40+10)*2, 40)];
        [skContentBackgroundView addSubview:_skPaopaoImageView];
        
        //聊天内容
        _skContentLabel = [[SKLabel alloc] init];
        _skContentLabel.backgroundColor = [UIColor clearColor];
        _skContentLabel.numberOfLines = 0;
        [_skContentLabel setFont:[UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE]];
        _skContentLabel.contentMode = UIViewContentModeCenter;
        [skContentBackgroundView addSubview:_skContentLabel];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    skContentBackgroundView.frame = self.bounds;
    
    if (_skMessageType == SKMessageTypeReviced) {
        
        //1.头像
        _skAvatarImageView.frame = CGRectMake(10, 0, 40, 40);
        
        //2.聊天气泡泡
        /*
         * 设置泡泡不变形拉伸处理
         */
        //首先获得图片 聊天气泡图片
        UIImage *paopaoImage = [UIImage imageNamed:@"shishengjiaoliu6.png"];
        //拉伸的边界根据图片来处理－上左下右 这里用中心点向外扩展10
        CGFloat capInsetsW = paopaoImage.size.width;//水平
        CGFloat capInsetsH = paopaoImage.size.height;//竖直
        UIEdgeInsets insets = UIEdgeInsetsMake(capInsetsH - 15, capInsetsW/2 - 10, capInsetsH - 5, capInsetsW/2 + 10);
        // 指定为拉伸模式，伸缩后重新赋值
        paopaoImage = [paopaoImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        //使用cell的高度 还要判断是否有时间，有的话要加上时间
        CGRect contentRect = self.bounds;
        
        //消息内容比起泡背景宽高各小20 起泡小箭头宽度为10
        CGFloat originX = 10;//左右各10
        CGFloat arrowW = 10;//小箭头宽度为10
        
        //气泡小箭头宽度为15 泡泡的宽度 ＝ cell的宽度- (头像的距离*2)
        //起泡的高度 ＝ 计算文本高度 ＋ 文本与气泡边界的距离
        _skPaopaoImageView.frame = CGRectMake(50, 0, self.bounds.size.width - (40+10)*2, contentRect.size.height);
        _skPaopaoImageView.image = paopaoImage;
        
        _skContentLabel.frame = CGRectMake(_skPaopaoImageView.frame.origin.x+originX+arrowW, _skPaopaoImageView.frame.origin.y+originX, _skPaopaoImageView.bounds.size.width-originX*2-arrowW, _skPaopaoImageView.bounds.size.height-originX*2);
        
    }else if (_skMessageType == SKMessageTypeSend) {
        
        //1.头像
        _skAvatarImageView.frame = CGRectMake(self.bounds.size.width - (40+10), 0, 40, 40);
        
        //2.聊天气泡泡
        /*
         * 设置泡泡不变形拉伸处理
         */
        //首先获得图片 聊天气泡图片
        UIImage *paopaoImage = [UIImage imageNamed:@"shishengjiaoliu5.png"];
        //拉伸的边界根据图片来处理－上左下右 这里用中心点向外扩展10
        CGFloat capInsetsW = paopaoImage.size.width;//水平
        CGFloat capInsetsH = paopaoImage.size.height;//竖直
        UIEdgeInsets insets = UIEdgeInsetsMake(capInsetsH - 15, capInsetsW/2 - 10, capInsetsH-5, capInsetsW/2 + 10);
        // 指定为拉伸模式，伸缩后重新赋值
        paopaoImage = [paopaoImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        //使用cell的高度 不用再次计算高度
        CGRect contentRect = self.bounds;
        
        //消息内容比起泡背景宽高各小20(就是上下左右各10) 起泡小箭头宽度为10
        CGFloat originX = 10;//上下左右各10
        CGFloat arrowW = 10;//小箭头宽度为10
        
        //气泡小箭头宽度为15 泡泡的宽度 ＝ cell的宽度- (头像的距离*2)
        //起泡的高度 ＝ 计算文本高度 ＋ 文本与气泡边界的距离
        _skPaopaoImageView.frame = CGRectMake(50, 0, self.bounds.size.width - (40+10)*2, contentRect.size.height);
        _skPaopaoImageView.image = paopaoImage;
        
        //内容的宽度 ＝ 泡泡的宽度 － 小箭头宽度 － 文本与气泡边界距离＊2（左右）
        _skContentLabel.frame = CGRectMake(_skPaopaoImageView.frame.origin.x+originX, _skPaopaoImageView.frame.origin.y+originX, _skPaopaoImageView.bounds.size.width-originX*2-arrowW, _skPaopaoImageView.bounds.size.height-originX*2);
    }
}

/**
 *获取静态的SKLabel对象，属性与Cell中SKLabel的属性保持一致，此静态对象仅用于判断文本大小
 */
static SKLabel *skLabel() {
    
    static SKLabel *_skLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _skLabel = [[SKLabel alloc] init];
        _skLabel.font = [UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE];
        _skLabel.numberOfLines = 0;
    });
    return _skLabel;
}

+ (CGRect)contentRectOfString:(NSAttributedString *)aString {
    
    /**
     *此方法仅适用于该聊天计算高度
     */
    //消息内容比起泡背景宽高各小20(就是上下左右各10) 起泡小箭头宽度为10
    CGFloat originX = 10;//上下左右各10
    CGFloat arrowW = 10;//小箭头宽度为10
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //头像距离（*2 两端都要减去）
    CGFloat avatarWRange = (40+10)*2;
    
    //起泡的宽度 ＝ cell的宽度 - 头像距离
    CGSize size = CGSizeMake((cellW - avatarWRange)-originX*2-arrowW, CGFLOAT_MAX);
    
    //nib里左右边距是10
    SKLabel *label = skLabel();
    label.attributedText = aString;
    
    //获得最佳适应大小
    size = [label preferredSizeWithMaxWidth:size.width];
    
    //+10*2 是文本与聊天气泡边界的高度－>最终获取高度也就是气泡的高度
    return CGRectMake(0, 0, size.width, size.height+10*2);
}


@end

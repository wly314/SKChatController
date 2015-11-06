//
//  SKXmppMessageViewController.m
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/23.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "SKChatMessageViewController.h"

#import "SKInputViewToolBar.h"
#import "SKChatMessageCell.h"

@interface MMTextAttachment : NSTextAttachment

@end

@implementation MMTextAttachment

//图片大小与文字保持一致
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0) {
    
    return CGRectMake( 0 , 0 , lineFrag.size.height , lineFrag.size.height );
}

@end

#define BOTTOMBAR_HEIGHT 44 //聊天栏Bar的高度
#define KEYBOAR_SHOW_TIME 0.25//自定义键盘出现时间

@interface SKChatMessageViewController ()<UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, SKInputViewToolBarDelegate> {
    
    UITableView         *skTableView;
    UITextView          *skTextView;//输入文本框 《＝ skToolBar.skInputToolBar
    SKInputViewToolBar  *skToolBar;//键盘ToolBar
    
    /*
     *是不是首次进入（只要执行ViewDidLoad方法就判断为首次进入)
     *用于执行动画－setContentOffset animated 每次进入，列表滚动到底部方法设置在cellForRow里面 animated设置为NO
     */
    BOOL                isFirstAppear;//默认为YES
}

@property(nonatomic, strong)NSMutableDictionary *cellHeightsDictionary;

@end

@implementation SKChatMessageViewController

@synthesize cellHeightsDictionary = _cellHeightsDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    skTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-BOTTOMBAR_HEIGHT) style:UITableViewStylePlain];
    skTableView.delegate = self;
    skTableView.dataSource = self;
    [self.view addSubview:skTableView];
    skTableView.separatorColor = [UIColor clearColor];
    
    //自定义navigationItem title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, BOTTOMBAR_HEIGHT)];
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.navigationItem.title;
    self.navigationItem.titleView = titleLabel;
    
    [self initToolBarItem2];
    
    _cellHeightsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    isFirstAppear = YES;//初始化为YES
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //注册通知－keyboardWillShow －keyboardWillHide
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //界面已经显示的情况下将isFirstAppear置为NO 之后进行其他操作，不再执行滚动cell的动画
    isFirstAppear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    //注册通知－keyboardWillShow －keyboardWillHide
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)initToolBarItem2 {
    
    SKInputViewToolBar *skInputToolBar = [[SKInputViewToolBar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-45, [UIScreen mainScreen].bounds.size.width, 45)];
    skInputToolBar.backgroundColor = [UIColor grayColor];
    skInputToolBar.delegate = self;
    [self.view addSubview:skInputToolBar];
    
    skToolBar = skInputToolBar;
    
//    skInputToolBar.skFaceButton.frame = CGRectMake(5, 7.5, 30, 30);
//    [skInputToolBar.skFaceButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor.png"] forState:UIControlStateNormal];
//    
//    skInputToolBar.skInputTextView.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 40 - 5 - 30 - 5, 35);
    skTextView = skInputToolBar.skInputTextView;
//
//    skInputToolBar.skAddButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-5-30, 7.5, 30, 30);
//    [skInputToolBar.skAddButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.cellHeightsDictionary[indexPath]) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"起泡起泡起泡起泡"  attributes:nil];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE] range:NSMakeRange(0,string.length-1)];
        
        MMTextAttachment *textAttachment = [[MMTextAttachment alloc] initWithData:nil ofType:nil];
        UIImage * smileImage = [UIImage imageNamed:@"Expression_1.png"];  //my emoticon image named a.jpg
        textAttachment.image = smileImage;
        
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [string insertAttributedString:textAttachmentString atIndex:6];
        
        CGRect contentRect = [SKChatMessageCell contentRectOfString:string];
        
        self.cellHeightsDictionary[indexPath] = @(contentRect.size.height);
    }
    
    
    return [self.cellHeightsDictionary[indexPath] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"Cell";
    
    SKChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[SKChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (isFirstAppear) {
            
            //首次进入之后每加载一个Cell，列表（Cell）就滚动到底部
            [skTableView setContentOffset:CGPointMake(0, skTableView.contentSize.height - skTableView.bounds.size.height) animated:NO];
        }
    }
    
    cell.skMessageType = SKMessageTypeSend;
    if (indexPath.row%2== 0) {
        
        cell.skMessageType = SKMessageTypeReviced;
    }
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"起泡起泡起泡起泡" attributes:nil];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE] range:NSMakeRange(0,string.length-1)];
    
    MMTextAttachment * textAttachment = [[MMTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage * smileImage = [UIImage imageNamed:@"Expression_1.png"];  //my emoticon image named a.jpg
    textAttachment.image = smileImage;
    
    NSAttributedString * textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [string insertAttributedString:textAttachmentString atIndex:6];
    
    cell.skContentLabel.attributedText = string;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [skTextView resignFirstResponder];
}

#pragma mark - SKInputViewToolBarDelegate
//faceBoard点击方法 判断是否显示表情键盘
/*
 *点击加号按钮，显示More键盘，skToolBard上移，再次点击加号按钮，skToolBar下移到底部，隐藏More键盘。
 *点击加号按钮，显示More键盘，skToolBard上移，此时点击表情按钮，skToolBard不要下移到底部，根据距离表情键盘高度上下移动，隐藏More键盘，显示表情键盘。
 */
- (void)skFaceButton:(UIButton *)skFaceButton showOrHideFaceKeyBoard:(BOOL)isShow {
    
    if (isShow) {
        
        [UIView animateWithDuration:KEYBOAR_SHOW_TIME animations:^{
            
            //skToolBard上移
            skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (127.0 + skToolBar.bounds.size.height/2));
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        
        [UIView animateWithDuration:KEYBOAR_SHOW_TIME animations:^{
            
            //skToolBard下移到底部
            skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (skToolBar.bounds.size.height/2));
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

//加号（＋）按钮点击方法 判断是否显示更多内容键盘
- (void)skAddButton:(UIButton *)skAddButton showOrHideMoreKeyBoard:(BOOL)isShow {
    
    if (isShow) {
        
        [UIView animateWithDuration:KEYBOAR_SHOW_TIME animations:^{
            
            //skToolBard上移
            skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (127.0 + skToolBar.bounds.size.height/2));
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        
        [UIView animateWithDuration:KEYBOAR_SHOW_TIME animations:^{
            
            //skToolBard下移到底部
            skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (skToolBar.bounds.size.height/2));
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - UIKeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //获取键盘大小
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    //获取动画路径
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    //获取动画持续时间
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    //获取键盘大小
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (keyboardFrame.size.height + skToolBar.bounds.size.height/2));
        skTableView.frame = CGRectMake(0, 0-keyboardFrame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-BOTTOMBAR_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        //动画结束列表滚动到底部
//        [skTableView setContentOffset:CGPointMake(0, skTableView.contentSize.height - skTableView.bounds.size.height) animated:YES];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    //获取动画持续时间
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    //执行动画
    [UIView animateWithDuration:animationDuration animations:^{
        
        //聊天
        skToolBar.center = CGPointMake(skToolBar.bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - (skToolBar.bounds.size.height/2));
        skTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-BOTTOMBAR_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        //动画结束列表滚动到底部
//        [skTableView setContentOffset:CGPointMake(0, skTableView.contentSize.height - skTableView.bounds.size.height) animated:YES];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

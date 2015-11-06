//
//  ViewController.m
//  SKChatControllerDemo
//
//  Created by LeouW on 15/11/6.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "ViewController.h"

#import "SKChatMessageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 80, 100, 30);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     *navigation设置－此处设置将会在下一级页面生效
     */
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)btnClick {
    
    SKChatMessageViewController *xmppVC = [[SKChatMessageViewController alloc] init];
    xmppVC.navigationItem.title = @"群组列表";
    [self.navigationController pushViewController:xmppVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

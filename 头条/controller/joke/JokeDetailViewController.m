//
//  JokeDetailViewController.m
//  今日头条
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "JokeDetailViewController.h"

@implementation JokeDetailViewController
{
    NSString *strURl;
}
@synthesize urlString = _urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark - 加载头部视图（导航栏）
-(void)layoutHeaderView
{

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [button setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissModal) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    NSLog(@"%@",self.view);
    [self.view addSubview:headerView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, 12, 100, 20)];
    label.text = @"评论详情";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [headerView addSubview:label];
    
/***************************加载详情*********************************/
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44*2)];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    //    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
    
    
/***************************底部评论*********************************/
    UIImageView *commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 460 -44 +7, 30, 30)];
    commentImageView.image = [UIImage imageNamed:@"comment_write_icon"];
    [self.view addSubview:commentImageView];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(45, 460-44+7, 320-55, 30)];
    textField.borderStyle = UITextBorderStyleBezel;
    textField.placeholder = @"在此输入您要发布的评论";
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    [self.view addSubview:textField];
    
    
}
#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 320, 460);
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutHeaderView];
    
}
-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

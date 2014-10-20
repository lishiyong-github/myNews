//
//  LotteryTicketVC.m
//  今日头条
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//


#define kUrlString @"http://m.aicai.com/page/temp/partner/jrtt/down/down.html?vt=5&agentId=2333789http://m.aicai.com/page/temp/partner/jrtt/down/css/style.css?vt=5http://m.aicai.com/page/temp/partner/jrtt/down/images/logo.png?vt=5http://m.aicai.com/page/temp/partner/jrtt/down/images/icons.png?vt=5"
#import "LotteryTicketVC.h"

@implementation LotteryTicketVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self layoutWebView];
    
    
}

-(void)layoutWebView
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-74)];
    NSURL *url = [NSURL URLWithString:kUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];

    [self.view addSubview:webview];
}


@end

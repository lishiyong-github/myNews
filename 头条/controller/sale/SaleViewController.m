//
//  SaleViewController.m
//  今日头条
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//


#define kUrlString @"http://www.jinritemai.com"
#import "SaleViewController.h"

@implementation SaleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


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

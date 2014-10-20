//
//  SplendidViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SplendidViewController.h"
#define kUrlStr @"http://isub.snssdk.com/2/wap/app/?iid=2329810807&device_id=2521430203&ac=3g&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"
@implementation SplendidViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutHeaderView];
    [self layoutWebView];
    
    
}
-(void)layoutHeaderView
{
    self.view.frame = CGRectMake(0, 0, 320, 460);
    UIView *tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tabbar setBackgroundColor:[UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1]];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [button setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissModal) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button];
    
    NSLog(@"%@",self.view);
    [self.view addSubview:tabbar];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, 12, 100, 20)];
    label.text = @"精彩应用";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(280, 12, 30, 20)];
    imageView.image = [UIImage imageNamed:@"more_pgc_comment_normal"];
    [tabbar addSubview:imageView];
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)layoutWebView
{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44)];
    NSURL *url = [NSURL URLWithString:kUrlStr];
    webView.userInteractionEnabled = YES;
    webView.scrollView.userInteractionEnabled = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
}
@end

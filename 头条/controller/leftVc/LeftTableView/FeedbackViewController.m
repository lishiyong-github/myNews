//
//  FeedbackViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "FeedbackViewController.h"
#import "LoginViewController.h"
@implementation FeedbackViewController
{
    NSInteger markTag;
    UIImageView *ideaImageView;
    UIWebView *webView;
}
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
    
    
    
}
-(void)layoutHeaderView
{
    self.view.backgroundColor = [UIColor whiteColor];
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
    label.text = @"意见反馈";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
    
    
    UIButton *idea = [[UIButton alloc]initWithFrame:CGRectMake(0, 44, 159.5, 29)];
    idea.titleLabel.font = [UIFont systemFontOfSize:14];
    markTag = 11;
    idea.tag= 11;
    idea.selected = YES;
    [idea setTitle:@"我的意见" forState:UIControlStateNormal];
    [idea setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //     [article setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [idea setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [idea addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:idea];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(159.5, 49, 1, 30)];
    lable1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lable1];
    
    
    /*******************************************************/
    UIButton *question = [[UIButton alloc]initWithFrame:CGRectMake(160.5, 44, 106, 29)];
    question.tag = 12;
    question.titleLabel.font = [UIFont systemFontOfSize:14];
    [question setTitle:@"常见问题" forState:UIControlStateNormal];
    [question setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //    [photo setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [question setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [question addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:question];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 73, 320, 1)];
    lable2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lable2];
    
    
    /***************************底部评论*********************************/
    UIImageView *commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 460 -44 +7, 30, 30)];
    commentImageView.image = [UIImage imageNamed:@"comment_write_icon"];
    [self.view addSubview:commentImageView];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(45, 460-44+7, 320-55, 30)];
    textField.borderStyle = UITextBorderStyleBezel;
    textField.placeholder = @"期待您的意见反馈";
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    [self.view addSubview:textField];

    //我的意见
    ideaImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myidea.jpg"]];
    ideaImageView.frame = CGRectMake(0, 80, 320, 180);
    [self.view addSubview:ideaImageView];
    
    //常见问题
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 74, 320, 460-74-30)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ic.snssdk.com/faq/v2/?night_mode=0&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"]];
    webView.scrollView.bounces = NO;
    [webView loadRequest:request];
}

- (void)changeSelected:(UIButton *)sender
{
    UIButton *markButton = (UIButton *)[self.view viewWithTag:markTag];
    markButton.selected = NO;
    sender.selected = YES;
    if (sender.tag == 11) {
        [webView removeFromSuperview];
        [self.view addSubview:ideaImageView];
    }else {
        [ideaImageView removeFromSuperview];
        [self.view addSubview:webView];
    }
    markTag = sender.tag;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    LoginViewController *login = [[LoginViewController alloc]init];
    [self presentModalViewController:login animated:YES];
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}
@end

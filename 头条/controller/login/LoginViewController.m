//
//  LoginViewController.m
//  今日头条
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "QuartzCore/QuartzCore.h"
@implementation LoginViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutNavigationItem];
    [self login];
    
    
    
}
-(void)layoutNavigationItem
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(85, 12, 150, 20)];
    label.text = @"登录今日头条";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
}
-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)login
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 50, 200, 180)];
    imageView.image = [UIImage imageNamed:@"bg_weixin_qq.jpg"];
    [self.view addSubview:imageView];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(85, 230, 150, 30)];
    [button1 setTitle:@"手机号登录" forState:UIControlStateNormal];
        button1.backgroundColor = [UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1];
    button1.layer.cornerRadius = 5;
    button1.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:button1];
    
    UIButton *button21 = [[UIButton alloc]initWithFrame:CGRectMake(85, 270, 150,30)];
    button21 .backgroundColor = [UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1];
    button21.layer.cornerRadius = 5;
    [self.view addSubview:button21];
    
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(87, 272, 146, 26)];
    [button2 setTitle:@"注册新账号" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor whiteColor];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button2.titleLabel.textColor = [UIColor redColor];
    button2.layer.cornerRadius = 5;
    [self.view addSubview:button2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 335, 80, 1)];
    label1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 320, 120, 30)];
    label2.textColor = [UIColor blackColor];
    label2.text = @"其他方式登录";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(220, 335, 80, 1)];
    label3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label3];
    
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(35, 370, 40, 40)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"account_icon_qzone"] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(105, 370, 40, 40)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"account_icon_weibo"] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc]initWithFrame:CGRectMake(180, 370, 40, 40)];
    [button5 setBackgroundImage:[UIImage imageNamed:@"account_icon_tencent"] forState:UIControlStateNormal];
    [self.view addSubview:button5];
    
    UIButton *button6 = [[UIButton alloc]initWithFrame:CGRectMake(255, 370, 40, 40)];
    [button6 setBackgroundImage:[UIImage imageNamed:@"account_icon_renren"] forState:UIControlStateNormal];
    [self.view addSubview:button6];
}


@end


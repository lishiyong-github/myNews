//
//  DetailViewController.m
//  今日头条
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "LoginViewController.h"
#import "CoreManager.h"
#import "QuartzCore/QuartzCore.h"
@implementation DetailViewController

@synthesize strURl = _strURl;
@synthesize receivcMoedel = _receivcMoedel;
@synthesize saveSelected = _saveSelected;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CoreManager *coreManager = [[CoreManager alloc]init];
    _saveSelected = [coreManager findArtivleModel:_receivcMoedel];
    [self layoutNavigationItem];
    [self layoutTabbarController];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44*2)];
    NSURL *url = [NSURL URLWithString:_strURl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
    

    
    
    
}

- (void)loadURLRequest:(NSNotification *)notification
{
    _strURl = [notification object];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44*2)];
    NSURL *url = [NSURL URLWithString:_strURl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
}

#pragma mark - 加载头部视图（导航栏）
- (void)layoutNavigationItem
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //返回按钮
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 16, 20)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back_detail_normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftButton];
    
    UITextField *webTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 12, 260, 20)];
    webTextField.textAlignment = UITextAlignmentLeft;
    webTextField.returnKeyType = UIReturnKeySearch;
    webTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    webTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    webTextField.text = _strURl;
    [navView addSubview:webTextField];
    
    
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 加载尾部视图（TabBar控制器）
- (void)layoutTabbarController
{
    UIView *tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 460-44, 320, 44)];
    tabbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabbar];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(30, 12, 20, 20)];
    button1.selected = _saveSelected;
    [button1 setBackgroundImage:[UIImage imageNamed:@"ic_action_favor_normal"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"ic_action_favor_on_normal"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];[tabbar addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(90, 12, 20, 20)];
    [button2 setImage:[UIImage imageNamed:@"ic_action_write_normal"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(152, 14, 16, 16)];
    [button3 setImage:[UIImage imageNamed:@"listpage_more_review_pressed_night"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(210, 12, 20, 20)];
    [button4 setImage:[UIImage imageNamed:@"ic_action_repost_normal"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc]initWithFrame:CGRectMake(270, 12, 20, 20)];
    [button5 setImage:[UIImage imageNamed:@"ic_action_report_normal"] forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button5];
    
    button1.tag = 11;
    button2.tag = 12;
    button3.tag = 13;
    button4.tag = 14;
    button5.tag = 15;
    
}

- (void)backHome
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)butClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 11:
        {
            
            UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(120, 190, 80, 80)];
            view1.backgroundColor = [UIColor blackColor];
            view1.tag = 16;
            view1.layer.cornerRadius = 40;
            [self.view addSubview:view1];
            
            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
            [view1 addSubview:imageView1];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 60, 20)];
            label.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14];
            [view1 addSubview:label];
            sender.selected = !sender.selected;
            if (sender.selected == YES) {
                
                imageView1.image = [UIImage imageNamed:@"ic_toast_fav"];
                label.text = @"收藏成功";
                //保存到数据库
                CoreManager *coremanager = [[CoreManager alloc]init];
                [coremanager addArticleModel:_receivcMoedel];
                               
            } else{
                
                imageView1.image = [UIImage imageNamed:@"ic_toast_unfav"];
                label.text = @"取消收藏";
                NSLog(@"_receivcMoedel.title is %@",_receivcMoedel.title);
                //在数据库中删除
                CoreManager *coremanager = [[CoreManager alloc]init];
                [coremanager removeArticleModel:_receivcMoedel];
            }
            [self performSelector:@selector(closePromptMessage) withObject:self afterDelay:1];
            
        }
            break;
        case 12:
        {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self presentModalViewController:login animated:YES];
                        
        }
            
            
            break;       
        case 13:
            
            break;       
        case 14:
        {
            //触摸弹出视图以外的地方触发的方法**************************
            UIControl *myController = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
            myController.backgroundColor = [UIColor blackColor];
            myController.alpha = 0.5;
            myController.tag = 678;
            [myController addTarget:self action:@selector(closeShareMessage) forControlEvents:UIControlEventTouchUpInside];
            NSLog(@"self.view ---%@",self.view.superview);
            [self.view addSubview:myController];
            
            UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 320, 260)];
            view4.backgroundColor = [UIColor whiteColor];
            view4.tag = 400;
            [self.view addSubview:view4];
            //微信好友1
            UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            [button1 setImage:[UIImage imageNamed:@"weixin_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button1];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 40, 10)];
            label1.font = [UIFont systemFontOfSize:10];
            label1.text = @"微信好友";
            label1.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label1];
        
            //微信朋友圈2
            UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(75, 10, 40, 40)];
            [button2 setImage:[UIImage imageNamed:@"weixinpengyou_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button2];
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(65, 60, 60, 10)];
            label2.font = [UIFont systemFontOfSize:10];
            label2.text = @"微信朋友圈";
            label2.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label2];
            
            //QQ好友3
            UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(140, 10, 40, 40)];
            [button3 setImage:[UIImage imageNamed:@"qq_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button3];
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(140, 60, 40, 10)];
            label3.font = [UIFont systemFontOfSize:10];
            label3.text = @"QQ好友";
            label3.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label3];
            
            //新浪微博4
            UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(205, 10, 40, 40)];
            [button4 setImage:[UIImage imageNamed:@"weibo_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button4];
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(205, 60, 40, 10)];
            label4.font = [UIFont systemFontOfSize:10];
            label4.text = @"新浪微博";
            label4.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label4];
            
            //QQ空间5
            UIButton *button5 = [[UIButton alloc]initWithFrame:CGRectMake(270, 10, 40, 40)];
            [button5 setImage:[UIImage imageNamed:@"qzone_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button5];
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(270, 60, 40, 10)];
            label5.font = [UIFont systemFontOfSize:10];
            label5.text = @"QQ空间";
            label5.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label5];
            
            //腾讯微博6
            UIButton *button6 = [[UIButton alloc]initWithFrame:CGRectMake(10, 80, 40, 40)];
            [button6 setImage:[UIImage imageNamed:@"tencent_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button6];
            UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 40, 10)];
            label6.font = [UIFont systemFontOfSize:10];
            label6.text = @"腾讯微博";
            label6.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label6];
            
            //人人网7
            UIButton *button7 = [[UIButton alloc]initWithFrame:CGRectMake(75, 80, 40, 40)];
            [button7 setImage:[UIImage imageNamed:@"renren_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button7];
            UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(75, 130, 40, 10)];
            label7.font = [UIFont systemFontOfSize:10];
            label7.text = @"人人网";
            label7.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label7];
            
            //短信8
            UIButton *button8 = [[UIButton alloc]initWithFrame:CGRectMake(140, 80, 40, 40)];
            [button8 setImage:[UIImage imageNamed:@"message_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button8];
            UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(140, 130, 40, 10)];
            label8.font = [UIFont systemFontOfSize:10];
            label8.text = @"短信";
            label8.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label8];
            
            //邮件9
            UIButton *button9 = [[UIButton alloc]initWithFrame:CGRectMake(205, 80, 40, 40)];
            [button9 setImage:[UIImage imageNamed:@"mail_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button9];
            UILabel *label9 = [[UILabel alloc]initWithFrame:CGRectMake(205, 130, 40, 10)];
            label9.font = [UIFont systemFontOfSize:10];
            label9.text = @"邮件";
            label9.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label9];
            
            //转发链接10
            UIButton *button10 = [[UIButton alloc]initWithFrame:CGRectMake(270, 80, 40, 40)];
            [button10 setImage:[UIImage imageNamed:@"url_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button10];
            UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(270, 130, 40, 10)];
            label10.font = [UIFont systemFontOfSize:10];
            label10.text = @"转发链接";
            label10.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label10];
            
            //转发内容11
            UIButton *button11 = [[UIButton alloc]initWithFrame:CGRectMake(10, 150, 40, 40)];
            [button11 setImage:[UIImage imageNamed:@"text_popover"] forState:UIControlStateNormal];
            [view4 addSubview:button11];
            UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 40, 10)];
            label11.font = [UIFont systemFontOfSize:10];
            label11.text = @"转发内容";
            label11.textAlignment = UITextAlignmentCenter;
            [view4 addSubview:label11];
            //取消分享12
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 220, 300, 30)];
            label.backgroundColor = [UIColor grayColor];
            label.layer.cornerRadius = 6;
            [view4 addSubview:label];
            
            UIButton *button12 = [[UIButton alloc]initWithFrame:CGRectMake(11, 221, 298, 28)];
            button12.tag = 112;
            button12.layer.cornerRadius = 6;
            [button12 setTitle:@"取消分享" forState:UIControlStateNormal];
            [button12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button12.backgroundColor = [UIColor whiteColor];
            [button12 addTarget:self action:@selector(closeShareMessage) forControlEvents:UIControlEventTouchUpInside];
            [view4 addSubview:button12];
            
            
        }
            
            
            break;       
        case 15:
        {
            UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"垃圾" otherButtonTitles:@"不感兴趣",@"举报文章问题", nil];
            [action showInView:self.view];
                }
            
            break;
        default:
            break;
    }
}

#pragma mark- 提示信息
-(void)closePromptMessage
{

    UIView *view = [self.view viewWithTag:16];
    [view removeFromSuperview];

}

- (void)closeShareMessage{
    UIControl *myController = (UIControl *)[self.view viewWithTag:678];
    UIView *view = [self.view viewWithTag:400];
    [view removeFromSuperview];
    [myController removeFromSuperview];
}
-(void)shareClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 112:
        {
            UIView *view = [self.view viewWithTag:400];
            [view removeFromSuperview];
//            [view setHidden:YES];
        }
            break;
            
        default:
            break;
    }
}

 
@end

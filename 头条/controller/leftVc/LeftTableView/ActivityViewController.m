//
//  ActivityViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"
#import "DetailViewController.h"
#define strURl @"http://isub.snssdk.com/2/wap/activity/?iid=2329810807&device_id=2521430203&ac=3g&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"
@implementation ActivityViewController
{
    NSInteger scrollPointY;
}
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
    
    self.view.userInteractionEnabled = YES;
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
    label.text = @"活动";
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
    NSURL *url = [NSURL URLWithString:strURl];
    webView.userInteractionEnabled = YES;
    webView.scrollView.userInteractionEnabled = YES;
    webView.scrollView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapGesture:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;

    [webView.scrollView addGestureRecognizer:singleTap];
}

#pragma mark - 利用手势看点击到了哪一个位置然后判断跳转


- (void)singleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point = (CGPoint )[tapGesture locationInView:self.view];

    //读取plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ActivityDetailContent" ofType:@"plist"];
    NSDictionary *dic= [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *root = [dic objectForKey:@"Root"];
                          
    NSArray *detailContent = [root objectForKey:@"ActivityDetail"];
    
    NSInteger yLocation = (NSInteger)(point.y + scrollPointY - 44);
    NSInteger index = yLocation/155;
    
    if (!(((yLocation-index*155>0)&&(yLocation-index*155<10))||index>13)) {
        DetailViewController *detaila = [[DetailViewController alloc]init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadURLRequest" object:[detailContent objectAtIndex:index]];
        [self presentModalViewController:detaila animated:YES];
    }
    

}



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

#pragma mark--UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    scrollPointY = (NSInteger)scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

//    scrollPointY = (NSInteger)scrollView.contentOffset.y;
//    NSLog(@"scrollPointY ---- %i",scrollPointY);
}
@end

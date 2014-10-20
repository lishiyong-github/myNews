//
//  SettingViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController


{
    NSArray *textArray;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutHeaderView];
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44)style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.bounces = NO;
    [self.view addSubview:myTableView];
    
    textArray = [NSArray arrayWithObjects:@"列表显示摘要",@"字体大小",@"列也标评论",@"2G/3G网络流量",@"清理缓存",@"推送通知",@"互动插件",@"自动优化阅读",@"收藏时转发",@"顶踩时转发",@"检查新版本",@"精彩应用推荐",@"使用帮助", nil];
    
    
    
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
    label.text = @"设置";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
    

    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 12, 50, 20)];
    [rightButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.textAlignment = UITextAlignmentRight;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [tabbar addSubview:rightButton];
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 60;
    }
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section== 0){
        return 5;
    } else if (section == 1){
        return 6;
    }else  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [textArray objectAtIndex:(NSInteger)(indexPath.row + indexPath.section*5.5)];
    
    return cell;
}
@end

//
//  LeftViewController.m
//  今日头条
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "SearchViewController.h"
@implementation LeftViewController

{
    NSArray *listArray;
    NSMutableArray *imageArray;
    NSArray *menuArray;
}
@synthesize leftDelegate;
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
    self.view.backgroundColor = [UIColor colorWithRed:0.2235 green:0.2235 blue:0.2235 alpha:1];
    [self layoutLogin];
    [self layoutTableView];
    
    UISwitch *switchOn = [[UISwitch alloc]initWithFrame:CGRectMake(10, 460-40, 100, 50)];
    [self.view addSubview:switchOn];
    
    UILabel *nightLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 460-35, 100, 20)];
    nightLabel.text = @"夜间模式";
    nightLabel.backgroundColor = [UIColor clearColor];
    nightLabel.textColor = [UIColor whiteColor];
    nightLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:nightLabel];
}

- (void)layoutLogin
{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 20, 60, 60);
    [button1 setImage:[UIImage imageNamed:@"account_icon_mobile.png"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(80, 20, 60, 60)];
    [button2 setImage:[UIImage imageNamed:@"account_icon_qzone.png"] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(140, 20, 60, 60)];
    [button3 setImage:[UIImage imageNamed:@"account_icon_weibo.png"] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 280, 20)];
    label.text = @"登录后，将推荐给你更多感兴趣得文章";
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}
- (void)layoutTableView
{
   //tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 250, 320)style:UITableViewStylePlain];
    UITableView *tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, 250, 320) style:UITableViewStylePlain];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    tableView1.bounces = NO;
    tableView1.backgroundColor = [UIColor colorWithRed:0.2235 green:0.2235 blue:0.2235 alpha:1];
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView1];
    
    
    listArray = [NSArray arrayWithObjects:@"搜索",@"收藏",@"通知",@"离线",@"活动",@"设置",@"反馈",@"精彩应用", nil];
    menuArray = [NSArray arrayWithObjects:@"SearchViewController",@"SaveViewController",@"InformViewController",@"DownloadViewController",@"ActivityViewController",@"SettingViewController",@"FeedbackViewController",@"SplendidViewController", nil];
    imageArray = [NSMutableArray array];
    for (int i = 1; i<9; i++) {
        NSString *str = [NSString stringWithFormat:@"image%i.png",i];
        [imageArray addObject:str];
    }
    for (int i = 0; i<9; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 120+i*35, 250, 2)];
        lable.backgroundColor = [UIColor blackColor];
        [self.view addSubview:lable];
    }
 }
 
 
 #pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - UITableViewDataSource
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}//返回表有多少行



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       
    }
    
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"name ------ %@",[menuArray objectAtIndex:indexPath.row]);
    NSString *name = [menuArray objectAtIndex:indexPath.row];
    [self.leftDelegate leftTableView:self detailView:name];

}


@end

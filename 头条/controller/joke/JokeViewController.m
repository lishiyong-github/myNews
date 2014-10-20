//
//  JokeViewController.m
//  今日头条
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//


#import "JokeViewController.h"
#import "JokeRequest.h"
#import "JokeCell.h"
#import "EssayCoreManager.h"
#import "JokeDetailViewController.h"
#import "SelectedModel.h"

#import "RootViewController.h"
#define kUrlString @"http://ic.snssdk.com/2/all/recent/?category=essay_joke&min_behot_time=1411453120&count=20&item_type=3&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"
@implementation JokeViewController
{
    NSMutableArray *textArray;
    NSMutableArray *selectedArray;
    NSInteger number;
    BOOL selected;
}
@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(detailContent:) name:@"JokeTextArray" object:nil];

    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    textArray = [NSMutableArray array];
    selectedArray = [NSMutableArray array];

    JokeRequest *request = [[JokeRequest alloc]init];
    [request startRequest:[NSURL URLWithString:kUrlString]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor orangeColor];

}
-(void)detailContent:(NSNotification *)notification
{
    NSArray *tempArray = [notification object];
    for (int i=tempArray.count-1; i>=0; i--) {
        [textArray insertObject:[tempArray objectAtIndex:i] atIndex:0];
    }
    if (textArray.count == 0) {
        number++;
        if (number <=3){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲,目前没有更新的段子!\n点击”确定“重新刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show]; 
        }else if(number == 4){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲,目前真的没有更新的啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
        }

    } else {
        JokeModel *jmodel=[textArray objectAtIndex:0];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showInfo:) userInfo:jmodel.display_info repeats:NO];
    }
//    for (JokeModel *model in textArray) {
//        SelectedModel *smodel = [[SelectedModel alloc]init];
//        EssayCoreManager *essayManager = [[EssayCoreManager alloc]init];
//        smodel.selected = [essayManager findEssayModel:model];
//        [selectedArray addObject:smodel];
//    }

    [self.tableView reloadData];
    
    
}
- (void)showInfo:(NSTimer *)timer
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 6, 280, 20)];
    label.backgroundColor = [UIColor colorWithRed:0.3765 green:0.7373 blue:0.9725 alpha:0.8];
    label.tag = 1000;
    label.text = [NSString stringWithFormat:@"今日头条推荐引擎有%i条更新",[timer.userInfo intValue]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    [self performSelector:@selector(delay) withObject:self afterDelay:2.1];
//    [self reloadTable];
    
}
- (void)delay
{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:1000];
    [label removeFromSuperview];
    //        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTable) userInfo:nil repeats:NO];
    
}






#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断点击了那一行，从而触发不同的方法
    switch (buttonIndex) {
        case 0:
            NSLog(@"buttonIndex  0");
            break;
        case 1:
        {
            NSLog(@"buttonIndex  1");
            JokeRequest *request = [[JokeRequest alloc]init];
            [request startRequest:[NSURL URLWithString:kUrlString]];
        }
            
            break;
        default:
            break;
    }
}


#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokeModel *model = [textArray objectAtIndex:indexPath.row];
    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(290, 1000)];
    return size.height + 10+15+10+10+10+5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JokeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    JokeModel *model = [textArray objectAtIndex:indexPath.row];
    EssayCoreManager *essayManager = [[EssayCoreManager alloc]init];
    
    cell.save_button.selected = [essayManager findEssayModel:model];
    
    
    
    cell.text_label.text = model.content;
    cell.text_label.numberOfLines = 0;
    cell.text_label.font = [UIFont systemFontOfSize:16];
    
    NSString *diggTitle = [NSString stringWithFormat:@"%i",[model.digg_count intValue]];
    [cell.digg_button setTitle:diggTitle forState:UIControlStateNormal];

    [cell.digg_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.digg_button.titleLabel.font = [UIFont systemFontOfSize:12];
    

    [cell.comment_button setTitle:[NSString stringWithFormat:@"评论：%@",model.comment_count] forState:UIControlStateNormal];
    [cell.comment_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.comment_button.titleLabel.font = [UIFont systemFontOfSize:12];

    
    cell.digg_button.tag = indexPath.row+10;
    cell.bury_button.tag = indexPath.row+50;
    cell.save_button.tag = indexPath.row+100;
    cell.comment_button.tag = indexPath.row+150;
    cell.share_button.tag = indexPath.row +200;
    
    
    [cell.bury_button setTitle:[NSString stringWithFormat:@"%i",[model.bury_count intValue]] forState:UIControlStateNormal];
    [cell.bury_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.bury_button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [cell.digg_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bury_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    [cell.save_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    [cell.comment_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
   [cell.share_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
 
    return cell;
}
NSInteger temptag=0;
- (void)selectedEssayImageFavor:(UIButton *)sender;
{
//    NSLog(@"sender.tag -----%i",sender.tag);
    if (sender.tag-50 <= (NSInteger)textArray.count) {
        if(sender.tag-10 <= textArray.count) {//digg_button
            JokeModel *model = [textArray objectAtIndex:sender.tag-10];
            sender.selected = YES;
            [sender setTitle:[NSString stringWithFormat:@"%i",[model.digg_count intValue]+1] forState:UIControlStateNormal];
            [self.tableView reloadData];
        }
        else { //bury_button
            JokeModel *model = [textArray objectAtIndex:sender.tag-50];
            sender.selected = YES;
            [sender setTitle:[NSString stringWithFormat:@"%i",[model.bury_count intValue]-1] forState:UIControlStateNormal];
        }
        temptag =sender.tag;
    }else {
        if(sender.tag-100 <= textArray.count){//sava_button
            
            sender.selected = !sender.selected;
            [self.delegate saveEssay:[textArray objectAtIndex:sender.tag-100] selected:sender.selected];

        } else if (sender.tag -150 <= textArray.count){//comment_button
            JokeModel *model = [[JokeModel alloc]init];
            model = [textArray objectAtIndex:sender.tag -150];
            
            [self.delegate openJokeDetailModelView:model.share_url];
        } else{ //share_button
            //触摸弹出视图以外的地方触发的方法**************************
            [self.delegate popUpShareMessage];

        }

    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokeModel *model = [[JokeModel alloc]init];
    model = [textArray objectAtIndex:indexPath.row];

    [self.delegate openJokeDetailModelView:model.share_url];

    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"contentOffset.y,%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -60) {
        number =0;
        
        NSString *str = [NSString stringWithFormat:@"%i",(NSInteger)(scrollView.contentOffset.x/320+101)];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tag" object:str];
        UIButton *button = [[UIButton alloc]init];
        button = (UIButton *)[self.view viewWithTag:[str integerValue]];
        JokeRequest *request = [[JokeRequest alloc]init];
        [request startRequest:[NSURL URLWithString:kUrlString]];
    }

}
@end

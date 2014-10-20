//
//  BeautyGirlViewController.m
//  今日头条
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//
#define kURLstr @"http://ic.snssdk.com/2/all/recent/?category=image_ppmm&min_behot_time=1411953127&count=20&item_type=1&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"
#define kRowHeight 460-74

#import "BeautyGirlViewController.h"
#import "BeautyCell.h"
#import "JokeModel.h"
#import "UIImageView+WebCach.h"
@implementation BeautyGirlViewController
{
    NSMutableArray *textArray;
    NSMutableData *datas;
}
@synthesize tableView = _tableView;

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
    textArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor orangeColor];
    
   
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-74) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
    [self startUrlRequest:kURLstr];
    [self performSelector:@selector(reloadDatas) withObject:self afterDelay:2];
}

- (void)reloadDatas
{
    [_tableView reloadData];
}
#pragma mark -  网络请求
-(void)startUrlRequest:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        datas = [NSMutableData new];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datas appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    NSNumber *totol_number = [jsonDic objectForKey:@"totol_number"];
    if ([totol_number intValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"目前没有更新！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    NSArray *data1 = [jsonDic objectForKey:@"data"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *tempDic in data1) {
        NSDictionary *large_image = [tempDic objectForKey:@"thumb_image"];
        NSArray *url_list = [large_image objectForKey:@"url_list"];
        NSDictionary *imgUrl = [url_list objectAtIndex:0];
        JokeModel *jmodel = [[JokeModel alloc]init];
        jmodel.share_url = [tempDic objectForKey:@"share_url"];
        jmodel.digg_count = [tempDic objectForKey:@"digg_count"];
        jmodel.bury_count = [tempDic objectForKey:@"bury_count"];
        jmodel.comment_count = [tempDic objectForKey:@"comment_count"];
        jmodel.imageUrl = [imgUrl objectForKey:@"url"];

        [tempArray addObject:jmodel];
        
    }
    for (int i=tempArray.count-1; i>=0; i--) {
        [textArray insertObject:[tempArray objectAtIndex:i] atIndex:0];
    }
    [_tableView reloadData];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BeautyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BeautyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    JokeModel *model = [textArray objectAtIndex:indexPath.row];
    NSLog(@"model.imageUrl is __ %@",model.imageUrl);
     NSLog(@"model.imageUrl is __ %@",model.digg_count);
     NSLog(@"model.imageUrl is __ %@",model.bury_count);
     NSLog(@"model.imageUrl is __ %@",model.comment_count);
//
////    [cell.imageView setImageWithURL:[NSURL URLWithString:model.imageUrl]];
//    
    NSString *diggTitle = [NSString stringWithFormat:@"%i",[model.digg_count intValue]];
    [cell.digg_button setTitle:diggTitle forState:UIControlStateNormal];
    
    [cell.digg_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.digg_button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [cell.comment_button setTitle:[NSString stringWithFormat:@"评论：%@",model.comment_count] forState:UIControlStateNormal];
    [cell.comment_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.comment_button.titleLabel.font = [UIFont systemFontOfSize:12];
    //    [cell.digg_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.digg_button.selected = YES;
//    cell.digg_button.tag = indexPath.row+10;
//    cell.bury_button.tag = indexPath.row+50;
//    cell.save_button.tag = indexPath.row+100;
//    cell.comment_button.tag = indexPath.row+150;
//    cell.share_button.tag = indexPath.row +200;
    
    
    [cell.bury_button setTitle:[NSString stringWithFormat:@"%i",[model.bury_count intValue]] forState:UIControlStateNormal];
    [cell.bury_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.bury_button.titleLabel.font = [UIFont systemFontOfSize:12];
    
   
    return cell;
}

@end

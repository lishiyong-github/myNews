//
//  PositiveEnergyVC.m
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "PositiveEnergyVC.h"
#import "NewsModel.h"
#import "MyImageCell.h"
#import "UIImageView+WebCach.h"


#define kURLString @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_edu&count=20&min_behot_time=1412225864&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"

@implementation PositiveEnergyVC
{
    NSMutableData *datas;
}
@synthesize textArray = _textArray;
@synthesize positiveEnergyDelegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textArray = [NSMutableArray array];
    [self startUrlRequest:kURLString];
    
}

#pragma mark - 网络请求
- (void)startUrlRequest:(NSString *)urlStr
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
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    NSArray *data = [JSONDictionary objectForKey:@"data"];
    NSDictionary *tips = [JSONDictionary objectForKey:@"tips"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NewsModel *model = [[NewsModel alloc]init];
        model.title = [dic objectForKey:@"title"];
        model.share_url = [dic objectForKey:@"share_url"];
        model.source = [dic objectForKey:@"source"];
        model.url = [dic objectForKey:@"url"];
        model.has_image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"has_image"]];
        model.display_info = [tips objectForKey:@"display_info"];
        
        if ([model.has_image isEqualToString:@"1"]) {
            NSDictionary *dic1 = [dic objectForKey:@"middle_image"];
            //            ImageConnection *imageConnection = [[ImageConnection alloc]init];
            //            NSURL *url = [NSURL URLWithString:[dic1 objectForKey:@"url"]];
            //            [imageConnection setURL:url];
            //            model.imageView.image = imageConnection.image;
            model.imageUrl = [dic1 objectForKey:@"url"];
            
        } else {
            model.imageView = nil;
        }
        [tempArray addObject:model];
    }       
    for (NewsModel *model in tempArray) {
        [_textArray insertObject:model atIndex:0];
    }  
    [self.tableView reloadData];
    NewsModel *model = [_textArray objectAtIndex:0];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showInfo:) userInfo:model.display_info repeats:NO];
}
- (void)showInfo:(NSTimer *)timer
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 6, 280, 20)];
    label.backgroundColor = [UIColor colorWithRed:0.3765 green:0.7373 blue:0.9725 alpha:0.8];
    label.tag = 1000;
    label.text = timer.userInfo;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    [self performSelector:@selector(delay) withObject:self afterDelay:2];
    [self reloadTable];
    
}
- (void)delay
{
    UILabel *label = (UILabel *)[self.view viewWithTag:1000];
    [label removeFromSuperview];
}
-(void)reloadTable 
{
    [self.tableView reloadData];
}
#pragma mark - table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [[NewsModel alloc]init];
    model = [_textArray objectAtIndex:indexPath.row];
    
    if ([model.has_image isEqualToString:@"1"]) {
        CGSize size = [model.title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(210, 200)];
        return (size.height+60)<110?110:size.height+60;
    }else {
        CGSize size = [model.title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(300, 200)];
        return size.height+40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    return currentDate;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    MyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    NewsModel *model = [[NewsModel alloc]init];
    model = [_textArray objectAtIndex:indexPath.row];
    
    
    //主标题
    cell.textLabel.text = model.title; 
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    //副标题
    cell.detailTextLabel.text = model.source;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    //评论
    cell.label.text = @"评论99  9分钟前";
    cell.label.font = [UIFont systemFontOfSize:12];
    cell.label.textAlignment = UITextAlignmentRight;
    if ([model.has_image isEqualToString:@"1"]) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        //        cell.imageView.image = model.imageView.image;
        //        cell.imageView.image = [imageArray objectAtIndex:j++];   
    }
    else {
        [cell.imageView setHidden:YES];
        [cell.imageView removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsModel *model = [_textArray objectAtIndex:indexPath.row];
    
    [self.positiveEnergyDelegate openDetailModelView:model.share_url];
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"contentOffset.y,%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -40) {
        
        [self startUrlRequest:kURLString];
    }
    
}


@end

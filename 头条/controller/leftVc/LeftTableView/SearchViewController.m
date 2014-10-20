//
//  SearchViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//url
//   http://ic.snssdk.com/2/article/v11/search/?keyword=%E4%B9%A0%E8%BF%91%E5%B9%B3+%E5%AD%94%E5%AD%90%E5%AD%A6%E9%99%A2&offset=0&count=20&from=hotword&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d

#define kUrlString  @"http://ic.snssdk.com/2/article/v11/search/?keyword=%@&offset=0&count=20&from=hotword&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"
#import "SearchViewController.h"
#import "NewsModel.h"
#import "MyImageCell.h"
#import "DetailViewController.h"
#import "UIImageView+WebCach.h"
@implementation SearchViewController


@synthesize textArray = _textArray,data = _data,tableView = _tableView;
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
    _textArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutHeaderView];
    [self layoutSearchNews];
    [self layoutTableView];
   
}
#pragma mark - 布局导航栏
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
    label.text = @"搜索";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - 布局搜索栏
-(void)layoutSearchNews
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, 320, 40)];
    label1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.layer.cornerRadius = 3;
    [label1 addSubview:label2];
    
    UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    searchImage.image = [UIImage imageNamed:@"ic_search_normal_night"];
//    searchImage.backgroundColor = [UIColor whiteColor];
    [label2 addSubview:searchImage];
    
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(30, 54, 280, 20)];
    searchField.delegate = self;
    searchField.placeholder = @"请输入关键字......";
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.clearsOnBeginEditing = YES;
    searchField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:searchField];
    
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField.text.length !=0) {
        NSString *str = [NSString stringWithFormat:kUrlString,textField.text];
        str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:str];
        NSLog(@"url is ____  %@",url);
        [self setUrl:url];
         [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:2];
    }
    
    
}//开始发送请求
#pragma mark- 请求网络并加载数据

- (void)setUrl:(NSURL *)url
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        _data = [NSMutableData new];
        _textArray = [NSMutableArray array];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    NSArray *data = [JSONDictionary objectForKey:@"data"];
    NSDictionary *tips = [JSONDictionary objectForKey:@"tips"];
    
    //    NSLog(@"请求完成%@",array);
    for (NSDictionary *dic in data) {
        NewsModel *model = [[NewsModel alloc]init];
        model.title = [dic objectForKey:@"title"];
        model.share_url = [dic objectForKey:@"share_url"];
        model.source = [dic objectForKey:@"source"];
        model.url = [dic objectForKey:@"url"];
        model.has_image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"has_image"]];
        model.display_info = [tips objectForKey:@"display_info"];
        //        NSLog(@"model.title  %@",model.title);
        
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
        [_textArray addObject:model];        
        [_tableView reloadData];
    }           
}
- (void)reloadTableView
{
    [_tableView reloadData];
}
#pragma mark- 加载表示图
- (void)layoutTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  74, 320,460-74) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
#pragma mark － UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark UITableViewDataSource

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
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    //副标题
    cell.detailTextLabel.text = model.source;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    //评论
    cell.label.text = @"评论99  9分钟前";
    cell.label.font = [UIFont systemFontOfSize:12];
    cell.label.textAlignment = UITextAlignmentRight;
    NSLog(@"model.has_image  is  %@",model.has_image);
    if ([model.has_image isEqualToString:@"1"]) {
        
        [cell.imageView setHidden:NO];
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        
    }
    else if ([model.has_image isEqualToString:@"0"]){
        [cell.imageView setHidden:YES];
        [cell.imageView removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [[NewsModel alloc]init];
    model = [_textArray objectAtIndex:indexPath.row];
    //    NSLog(@"model.share_url  %@",model.share_url);
    
    
    DetailViewController *detaila = [[DetailViewController alloc]init];
    detaila.strURl = model.share_url;
    detaila.receivcMoedel = model;
    [self presentModalViewController:detaila animated:YES];
    
    
    
}
@end

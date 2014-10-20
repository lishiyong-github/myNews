//
//  SaveViewController.m
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SaveViewController.h"
#import "CoreManager.h"
#import "EssayCoreManager.h"
#import "MyImageCell.h"
#import "UIImageView+WebCach.h"
#import "DetailViewController.h"
#import "JokeDetailViewController.h"
#import "SaveEssayCell.h"
@implementation SaveViewController

{
    NSInteger markTag;
    UITableView *tableView1;
    UITableView *tableView3;
    UIView *view2;
    NSArray *articleArray;
    NSArray *essayArray;
    UIButton *editingButton;
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
- (void)viewWillAppear:(BOOL)animated
{
    CoreManager *coreManager = [[CoreManager alloc]init];
    articleArray = [coreManager findAllArticle];
    [tableView1 reloadData];
}//视图重新加载的时候  重新刷新表示图

- (void)viewDidLoad
{
    [super viewDidLoad];
    markTag = 11;
    
    [self layoutHeaderView];
    [self addTableView1];
    self.view.backgroundColor = [UIColor whiteColor];
        
    CoreManager *coremanager = [[CoreManager alloc]init];
    articleArray = [coremanager findAllArticle];
    NSLog(@"textArray.count is %i",articleArray.count);
    
    if (articleArray.count == 0) {
        [self.view addSubview:view2];
    }
    
    
    
}
/*****************自定义导航栏******************/
-(void)layoutHeaderView
{
    self.view.frame = CGRectMake(0, 0, 320, 460);
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1];
    [self.view addSubview:headerView];
    
    /*******************************************************/
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [button setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissModal) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, 12, 100, 20)];
    label.text = @"我的收藏";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [headerView addSubview:label];
    
    editingButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 14, 40, 16)];
    [editingButton setTitle: @"编辑" forState:UIControlStateNormal];
    [editingButton setTitle: @"取消" forState:UIControlStateSelected];
    [editingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editingButton.titleLabel.textAlignment = UITextAlignmentLeft;
    editingButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [editingButton addTarget:self action:@selector(editingTable:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:editingButton];
    
    /*******************************************************/

    UIButton *article = [[UIButton alloc]initWithFrame:CGRectMake(0, 44, 106, 29)];
    article.tag= 11;
    article.selected = YES;
    [article setTitle:@"文章" forState:UIControlStateNormal];
    [article setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//     [article setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
      [article setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [article addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:article];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(106, 49, 1, 20)];
    lable1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lable1];
    
    
    /*******************************************************/
    UIButton *photo = [[UIButton alloc]initWithFrame:CGRectMake(107, 44, 106, 29)];
    photo.tag = 12;
    [photo setTitle:@"图片" forState:UIControlStateNormal];
    [photo setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [photo setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
       [photo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [photo addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photo];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(213, 49, 1, 20)];
    lable2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lable2];
    
    /*******************************************************/
    UIButton *essay = [[UIButton alloc]initWithFrame:CGRectMake(214, 44, 106, 29)];
    essay.tag = 13;
//    [essay setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [essay setTitle:@"短文" forState:UIControlStateNormal];
    [essay setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
      [essay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [essay addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:essay];
   
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 73, 320, 1)];
    lable3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lable3];

}

#pragma mark -- 对表视图的编辑
- (void)editingTable:(UIButton *)sender
{
    sender.selected = !sender.selected;
    tableView1.editing = sender.selected;
    tableView3.editing = sender.selected;
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}

/*******************改变选中状态*********************************/
#pragma mark --改变选中状态
- (void)changeSelected:(UIButton *)sender
{//11--12--13
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:markTag];
    if (!(sender.tag==markTag)) {
        tempButton.selected = !tempButton.selected;
        sender.selected = !sender.selected;
    }
  editingButton.selected = NO;
    switch (sender.tag) {
        case 11:{//文章
            [tableView3 removeFromSuperview];
            
            CoreManager *coremanager = [[CoreManager alloc]init];
            articleArray = [coremanager findAllArticle];
            [self editingTable:nil];

            if (articleArray.count == 0) {
                [self.view addSubview:view2];
            } else {
                [self.view addSubview:tableView1];
                [tableView1 reloadData];
            }
        }  
            break;
        case 12://图片
            [tableView3 removeFromSuperview];
            [tableView1 removeFromSuperview];
            [self editingTable:nil];
            [self.view addSubview:view2];
            break;
        case 13:{//段子
            [tableView1 removeFromSuperview];
            [self editingTable:nil];
            EssayCoreManager *essay = [[EssayCoreManager alloc]init];
            essayArray = [essay findAllEssay];
            if (essayArray.count == 0) {
                [self.view addSubview:view2];
            } else{
                [self.view addSubview:tableView3];
            }
        }
            break;
        default:
            break;
    }
    markTag = sender.tag;
}
/************************加载主视图中间的表*******************************/

#pragma mark --加载主视图中间的表
- (void)addTableView1
{
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, 320, 460-74) style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource  = self;
    
    [self.view addSubview:tableView1];
    
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 74, 320, 460-74)];
//    [self.view addSubview:view2];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_no_favor.png"]];
    imageView2.frame = CGRectMake(120, 150, 80, 70);
    [view2 addSubview:imageView2];
    
    UILabel *saveLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 230, 100, 20)];
    saveLable.text = @"暂无收藏";
    saveLable.textAlignment = UITextAlignmentCenter;
    saveLable.textColor = [UIColor blackColor];
    [view2 addSubview:saveLable];
    
    tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, 320, 460-74) style:UITableViewStylePlain];
    tableView3.delegate = self;
    tableView3.dataSource = self;
    
    
    [self performSelector:@selector(reloadTableData) withObject:self afterDelay:1];

}
  
- (void)reloadTableData
{
    [tableView1 reloadData];
}
#pragma mark - table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableView1) {//文章
        NewsModel *model = [[NewsModel alloc]init];
        model = [articleArray objectAtIndex:indexPath.row];
        
        if ([model.has_image isEqualToString:@"1"]) {
            CGSize size = [model.title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(210, 2000)];
            return (size.height+60)<110?110:size.height+60;
        }else {
            CGSize size = [model.title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(300, 2000)];
            return size.height+40;
        }
    }else {//短文
        JokeModel *model = [[JokeModel alloc]init];
        model = [essayArray objectAtIndex:indexPath.row];
        CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(290, 2000)];
        NSLog(@"size.height is %lf",size.height);
        return size.height+30;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = (tableView ==tableView1?articleArray.count:essayArray.count);
    return number;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableView1) {
        static NSString *CellIdentifier = @"Cell";
        
        MyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MyImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        NewsModel *model = [[NewsModel alloc]init];
        model = [articleArray objectAtIndex:indexPath.row];
        
        
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
   
        }
        else {
            [cell.imageView setHidden:YES];
            [cell.imageView removeFromSuperview];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        
        SaveEssayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SaveEssayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        JokeModel *model = [[JokeModel alloc]init];
        model = [essayArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.content;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor blackColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableView1) {
        NewsModel *model = [articleArray objectAtIndex:indexPath.row];
        DetailViewController *detail = [[DetailViewController alloc]init];
        detail.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        detail.strURl = model.share_url;
        detail.receivcMoedel = model;
        detail.saveSelected = YES;
        [self presentModalViewController:detail animated:YES];

    }else{
        JokeModel *model = [essayArray objectAtIndex:indexPath.row];
        JokeDetailViewController *detail = [[JokeDetailViewController alloc]init];
        detail.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        detail.urlString = model.share_url;
        [self presentModalViewController:detail animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;   
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableView1) {//编辑表示图1（文章的收藏）
        if (editingStyle ==UITableViewCellEditingStyleDelete) {
            NewsModel *model = [articleArray objectAtIndex:indexPath.row];
            CoreManager *coremanager = [[CoreManager alloc]init];
            [coremanager removeArticleModel:model];
            articleArray = [coremanager findAllArticle];
            [tableView1 reloadData];
        }
    }else if (tableView == tableView3) {//编辑表示图3（段子的收藏）
        if(editingStyle == UITableViewCellEditingStyleDelete) {
            JokeModel *model = [essayArray objectAtIndex:indexPath.row];
            EssayCoreManager *essayManager = [[EssayCoreManager alloc]init];
            [essayManager removeEssayModel:model];
            essayArray = [essayManager findAllEssay];
            [tableView3 reloadData];
        }
    } else {
        
    }
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"contentOffset.y,%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -40) {
        CoreManager *coreManager = [[CoreManager alloc]init];
        articleArray = [coreManager findAllArticle];
        [tableView1 reloadData];
    }
    
}

@end

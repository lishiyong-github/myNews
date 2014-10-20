
//  RootViewController.m
//  今日头条
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "WebConnection.h"
#import "NewsModel.h"
#import "DetailViewController.h"
#import "UIImageView+WebCach.h"
#import "MyImageCell.h"
#import "JokeDetailViewController.h"
#import "EssayCoreManager.h"
#import "SaleViewController.h"
#import "LotteryTicketVC.h"
#import "MoveViewController.h"
#import "QuartzCore/QuartzCore.h"
#define allPages 29
#define kUrl [NSURL URLWithString:@"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&count=20&min_behot_time=1411106358&loc_mode=6&loc_time=1404947632&latitude=30.337259&longitude=112.203145&city=%E8%8D%86%E5%B7%9E&iid=2320094434&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=362&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d"]
@implementation RootViewController
{
    NSMutableArray *tagButtonArray;
    UIView *leftView;//左侧视图
    UITableView *_tableView;//表示图
    UIButton *tagButton;
    UIButton *changeButton;
    UIScrollView *mainScrollView;//滚动式图
    UIScrollView *scrollViewHeader;//选择视图
    NSMutableArray *textArray;//加载model数据
    NSInteger scrollViewTag;
    NSMutableArray *imageArray;
    NSInteger j;
    UIControl *control;
    
    
}
@synthesize leftVC = _leftVC;
@synthesize contentView = _contentView;
@synthesize rightVC = _rightVC ;
//@synthesize positive = _positive;
@synthesize jokeVC = _jokeVC;
@synthesize beauty = _beauty;
@synthesize education = _education;
@synthesize funnyVC = _funnyVC;
//@synthesize society = _society;
//@synthesize house = _house;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        WebConnection *web = [[WebConnection alloc]init];
        [web setUrl:kUrl];
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"self.view.y is %@",self.view);
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    _education = [[EducationViewController alloc]init];
//    _education.educationDelegate = self;
//        [mainScrollView addSubview:_education.view];
    
    //注册通知 接受后并处理
    j = 0;
    textArray = [NSMutableArray array];
    imageArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(detailContent:) name:@"detailContent" object:nil];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadImage:) name:@"loadImage" object:nil];
    
    //初始化标记tagButton
    tagButton = [[UIButton alloc]init];
    changeButton = [[UIButton alloc]init];
    UIImageView *imaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [imaView setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:imaView];
    
    /***********************左侧视图***********************************/
    control= [[UIControl alloc]initWithFrame:CGRectMake(280, 40, 320, 460)];
    [control addTarget:self action:@selector(didOpenLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    _leftVC = [[LeftViewController alloc]init];
    _leftVC.view.frame = CGRectMake(-280, 0, 280,0);
    _leftVC.leftDelegate = self;
    _rightVC = [[RightViewController alloc]init];
    [self.view addSubview:_leftVC.view];
    [self.view addSubview:_rightVC.view];
    [_leftVC.view setHidden:YES];
    [_rightVC.view setHidden:YES];
    /**************************contentView视图********************************/
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    /**************************主视图*******************************/
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, 320, 460-74)];
    mainScrollView.contentSize = CGSizeMake(320*allPages, 460-74);
    
    mainScrollView.pagingEnabled  = YES;
    mainScrollView.bounces = NO;
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.delegate = self;
    [_contentView addSubview:mainScrollView];
    
    
    /**********************************************************/
    
    //    _jokeVC = [[JokeViewController alloc]init];
    //    _jokeVC.delegate = self;
    //    _jokeVC.view.frame = CGRectMake(320 *2, 0, 320, 460-74);
    //    [mainScrollView addSubview:_jokeVC.view];
    
//    for (int i = 4; i<= allPages; i++) {
//        NSString *name = [NSString stringWithFormat:@"image0%i.jpg",i];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 460-74)];
//        imageView.image = [UIImage imageNamed:name];
//        [mainScrollView addSubview:imageView];
//    }
    
    
    [self layoutNavigationItem];
    [self layoutTableView];
    

    

}
- (void)reloadTable {

    [_tableView reloadData];
}

- (void)loadImage:(NSNotification *)notification
{
    [imageArray addObject:[notification object]];
    //    [_tableView reloadData];
}
#pragma mark- 自定义导航栏
- (void)layoutNavigationItem
{
    //定义导航栏颜色
    /**********************************************************/
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1]];
//    headerView.backgroundColor = [UIColor ]
    //    tabbar.backgroundImage = [UIImage imageNamed:@"bg_bar_item.jpg"];
    //    [tabbar setBackgroundImage:[UIImage imageNamed:@"bg_bar_item.jpg"]];
    
    [_contentView addSubview:headerView];
    
    /**********************************************************/ 
    //定义导航栏title
    self.title = @"今日头条";
    //定义导航栏左侧按钮
    UIView *lefView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 4, 40, 40)];
    leftButton.tag = 1;
    [leftButton setImage:[UIImage imageNamed:@"left_bar_item.jpg"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(personalCenter:) forControlEvents:UIControlEventTouchUpInside];
    [lefView addSubview:leftButton];
    [headerView addSubview:lefView];
    
    /**********************************************************/
    //标题 今日头条
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, 12, 100, 20)];
    label.text = @"今日头条";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [headerView addSubview:label];
    
    /**********************************************************/
    //右侧
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 0, 44, 44)];
    rightButton.tag = 2;
    [rightButton setImage:[UIImage imageNamed:@"right_bar_item.jpg"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(personalCenter:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightButton];
    
    [self layoutTabbarController];
    
    ;}
/**********************************************************/
#pragma mark- 自定义滚动式图：推荐、热点、军事、科技、财经⋯⋯
- (void)layoutTabbarController
{
    scrollViewHeader = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.origin.y+44, 320, 30)];
        scrollViewHeader.bounces = NO;
    //    scrollViewHeader.delegate = self;
    scrollViewHeader.userInteractionEnabled = YES;
    scrollViewHeader.showsHorizontalScrollIndicator = NO;
    scrollViewHeader.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:scrollViewHeader];
    /**********************************************************/
    NSArray *nameArray = [NSArray arrayWithObjects:@"推荐",@"搞笑",@"奇葩",@"段子",@"教育",@"情感",@"健康",@"美食",@"养生",@"美文",@"旅游",@"星座",@"文化",@"历史",@"房产",@"家居",@"育儿",@"时尚",@"汽车",@"美女",@"军事",@"趣图",@"数码",@"娱乐",@"国际",@"特卖",@"彩票",@"社会",@"游戏",nil];
    
    scrollViewHeader.contentSize = CGSizeMake(allPages*60+50, 30);

    tagButtonArray = [NSMutableArray arrayWithCapacity:nameArray.count];
    for (int i = 0; i< nameArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+i*60, 5, 60, 20)];
        NSString *name = [nameArray objectAtIndex:i];
        
        //        button.titleLabel.text = name;
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.tag = i+101;
        button.showsTouchWhenHighlighted = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"bg_button_selected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        [scrollViewHeader addSubview:button];
        [tagButtonArray addObject:button];
    }
    tagButton = [tagButtonArray objectAtIndex:0];
    tagButton.selected = YES;
    /**********************************************************/
    //右侧得"＋"按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(290, 44, 30, 30)];
    button.backgroundColor = [UIColor whiteColor];
    [button setImage:[UIImage imageNamed:@"channel_glide.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(editingOrder) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:button];
    
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:@"tag" object:nil];
}
#pragma mark- 自定义导航栏按钮的点击事件
- (void)personalCenter:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 1:
            [self didOpenLeftView];
            break;
        case 2:
            [self didOpenRightView];
            
            break;
            
            
        default:
            break;
    }
}

- (void)editingOrder
{
    MoveViewController *move = [[MoveViewController alloc]init];
    move.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:move animated:YES];
}
/**********************************************************/
#pragma mark-打开左侧视图
- (void)didOpenLeftView
{
    CGRect fram = _contentView.frame;
    CGRect fram1 ;

    if (fram.origin.x == 0) {
        fram.origin.x += 280;
        fram.origin.y =0;
        fram.size.height = 460;
        
        fram1 = CGRectMake(0, 0, 280, 460);

        [self.view addSubview:control];
//        [self.view addSubview:_leftVC.view];

    } else {
        fram.origin.x -= 280;
        fram.origin.y = 0;
        fram.size.height = 460;
        
        fram1 = CGRectMake(-280, 0, 280, 0);
//        [_leftVC.view removeFromSuperview];
        [control removeFromSuperview];
    }
    //    [_leftView setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^() {
        [_leftVC.view setHidden:NO];
        [_rightVC.view setHidden:YES];
        _leftVC.view.frame = fram1;
        _contentView.frame = fram;
        
    }];
    
}

#pragma mark- 打开右侧视图
- (void)didOpenRightView
{
    
    //    CGRect fram = _contentView.frame;
    //    CGRect fram1 = _rightVC.view.frame;
    //    
    //    if (fram.origin.x == 0) {
    //        fram.origin.x -= 420;
    //        fram.origin.y = 44;
    //        fram.size.height = 460-88;
    //        
    //        fram1.origin.x = 0;
    //        fram1.size.width = 320;
    //        fram1.size.height = 460;
    //    } else {
    //        fram.origin.x += 420;
    //        fram.origin.y = 0;
    //        fram.size.height = 460;
    //        
    //        fram1.origin.x = 320;
    //        fram1.size.width = 100; 
    //        fram1.size.height = 200;
    //    }
    //    //    [_leftView setHidden:NO];
    //    [UIView animateWithDuration:0.5 animations:^() {
    //        [_rightVC.view setHidden:NO];
    //        _rightVC.view.frame = fram1;
    //        _contentView.frame = fram;
    //        
    //    }];
    RightViewController *right = [[RightViewController alloc]init];
    [self presentModalViewController:right animated:YES];
}
/**********************************************************/

/*#pragma mark- 滚动scrollViewHeader后选择设置哪个button的selected＝yes
 -(void)change:(NSNotification *)notifacation
 {
 UIButton *button = [[UIButton alloc]init];
 NSString *str = [notifacation object];
 NSInteger tag = [str integerValue];
 button = (UIButton *)[self.view viewWithTag:tag];
 NSLog(@"tag-------%i",tag);
 [scrollViewHeader scrollRectToVisible:CGRectMake (-(10+ (tag - 100)*60), 44, 320, 30) animated:YES];
 
 switch (tag) {
 case 101:
 {
 WebConnection *web = [[WebConnection alloc]init];
 [web setUrl:kUrl];
 }
 
 break;
 case 102:
 
 break;
 case 103:
 
 break;
 case 104:
 
 break;
 case 105:
 
 break;
 case 106:
 
 break;
 case 107:
 
 break;
 case 108:
 
 break;
 case 109:
 
 break;
 case 110:
 
 break;
 case 111:
 
 break;
 case 112:
 
 break;
 case 113:
 
 break;
 case 14:
 
 break;
 case 115:
 
 break;
 default:
 break;
 }
 
 for (UIButton *button in tagButtonArray) {
 button.selected = NO;
 }
 button.selected = YES;
 
 }*/
#pragma mark- 点击推荐 热点 军事⋯⋯实现页面的跳转
- (void)changeType:(UIButton *)sender
{
    NSLog(@"sendeer.tag is %i",sender.tag);
    if (!(sender.tag-101>30)) {
            [scrollViewHeader scrollRectToVisible:CGRectMake ((sender.tag - 103)*60, 0, 320, 30) animated:YES];
    } 

    [mainScrollView scrollRectToVisible:CGRectMake((sender.tag-101)*320, 0, 320, 460-74)animated:YES];
    
    switch (sender.tag) {//推荐
        case 101:
        { 
            WebConnection *web = [[WebConnection alloc]init];
            [web setUrl:kUrl];
        }
            break;
        case 102://搞笑
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=funny&count=20&min_behot_time=1412319081&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*1, 0, 320, 460-74);

        }
        case 103://奇葩
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=marvel&count=20&min_behot_time=1412318983&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*2, 0, 320, 460-74);
        }

            
            break;
        case 104:{//段子
            _jokeVC = [[JokeViewController alloc]init];
            _jokeVC.delegate = self;
            _jokeVC.view.frame = CGRectMake(320 *3, 0, 320, 460-74);
            [mainScrollView addSubview:_jokeVC.view];
        }
            
            break;
        case 105://教育－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_edu&count=20&min_behot_time=1412302972&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*4, 0, 320, 460-74);
        }
            
            break;
        case 106://情感－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=emotion&count=20&min_behot_time=1412319409&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*5, 0, 320, 460-74);
        }            
            break;
        case 107://健康－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_health&count=20&min_behot_time=1412319207&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*6, 0, 320, 460-74);
        }
            
            break;
        case 108://美食－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_food&count=20&min_behot_time=1412321770&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*7, 0, 320, 460-74);
//            _education = [[EducationViewController alloc]init];
//            _education.educationDelegate = self;
//            _education.view.frame = CGRectMake(320*6, 0, 320, 460-74);
//            [mainScrollView addSubview:_education.view];
        }
            
            break;
        case 109://养生－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_regimen&count=20&min_behot_time=1412319928&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*8, 0, 320, 460-74);
            //         [mainScrollView addSubview:_education.view];
        }

            
            break;
        case 110://美文－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_essay&count=20&min_behot_time=1412319590&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*9, 0, 320, 460-74);
//         [mainScrollView addSubview:_education.view];
        }
            
            break;
        case 111://旅游－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_travel&count=20&min_behot_time=1412319816&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
             [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*10, 0, 320, 460-74);
//         [mainScrollView addSubview:_education.view];
        }
            
            break;
        case 112://星座－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_astrology&count=20&min_behot_time=1412319323&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*11, 0, 320, 460-74);
//            [mainScrollView addSubview:_education.view];
        }
            break;
        case 113://文化－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_culture&count=20&min_behot_time=1412319973&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];

            _education.view.frame = CGRectMake(320*12, 0, 320, 460-74);

        }
            break;
        case 114://历史－－
        {            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];

            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_history&count=20&min_behot_time=1412319939&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];

            _education.view.frame = CGRectMake(320*13, 0, 320, 460-74);

        }
            break;
        case 115://房产－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_house&count=20&min_behot_time=1412303205&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*14, 0, 320, 460-74);
 
        }
            break;
        case 116://家居－－
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_home&count=20&min_behot_time=1412319369&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*15, 0, 320, 460-74);
            [mainScrollView addSubview:_education.view];
            break;
        case 117://育儿－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_baby&count=20&min_behot_time=1412322278&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            
            _education.view.frame = CGRectMake(320*16, 0, 320, 460-74);
            
        }
            break;
        case 118://时尚－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_fashion&count=20&min_behot_time=1412319903&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*17, 0, 320, 460-74);
            
        }
            break;
        case 119://汽车－－
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_car&count=20&min_behot_time=1412317757&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*18, 0, 320, 460-74);
            [mainScrollView addSubview:_education.view];
            break;
        case 120://美女－－
        {
            _funnyVC = [[FunnyPictureVC alloc]init];
            _funnyVC.funnyDelegate = self;
            _funnyVC.urlString = @"http://ic.snssdk.com/2/all/recent/?category=image_ppmm&min_behot_time=1411953127&count=20&item_type=1&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_funnyVC startUrlRequest:_funnyVC.urlString];
            _funnyVC.view.frame = CGRectMake(320*19, 0, 320, 460-74);
            [mainScrollView addSubview:_funnyVC.view];
            
        }
            break;
        case 121://军事－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_military&count=20&min_behot_time=1412327816&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*20, 0, 320, 460-74);
            
        }
            break;
        case 122://趣图－－
            
            _funnyVC = [[FunnyPictureVC alloc]init];
            _funnyVC.funnyDelegate = self;
            _funnyVC.urlString = @"http://ic.snssdk.com/2/all/recent/?category=image_funny&min_behot_time=1412335412&count=20&item_type=1&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_funnyVC startUrlRequest:_funnyVC.urlString];
            _funnyVC.view.frame = CGRectMake(320*21, 0, 320, 460-74);
            [mainScrollView addSubview:_funnyVC.view];
            break;
            
        case 123://数码
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=digital&count=20&min_behot_time=1412306700&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            
            _education.view.frame = CGRectMake(320*22, 0, 320, 460-74);
            
        }

            break;
        case 124://娱乐
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_entertainment&count=20&min_behot_time=1412306908&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*23, 0, 320, 460-74);
            
        }

            break;
        case 125://国际
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_world&count=20&min_behot_time=1412306779&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*24, 0, 320, 460-74);
            [mainScrollView addSubview:_education.view];            break;
        case 126://特卖
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            SaleViewController *sale = [[SaleViewController alloc]init];
            sale.view.frame = CGRectMake(320 *25, 0, 320, 460-74);
            [mainScrollView addSubview:sale.view];
        }
            break;
        case 127://彩票
        {
            LotteryTicketVC *lottery = [[LotteryTicketVC alloc]init];
            lottery.view.frame = CGRectMake(320 *26, 0, 320, 460-74);
            [mainScrollView addSubview:lottery.view];
        }
            break;
        case 128://社会
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_society&count=20&min_behot_time=1412299961&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*27, 0, 320, 460-74);
        }            break;
        case 129://游戏－－
        {
            _education = [[EducationViewController alloc]init];
            _education.educationDelegate = self;
            [mainScrollView addSubview:_education.view];
            _education.urlString = @"http://ic.snssdk.com/2/article/v19/stream/?detail=1&image=1&category=news_game&count=20&min_behot_time=1412320008&loc_mode=6&loc_time=1411383790&latitude=31.21717473392063&longitude=120.58912427380201&city=%E8%8B%8F%E5%B7%9E%E5%B8%82&iid=2329810807&device_id=2521430203&ac=wifi&channel=xiaomi&aid=13&app_name=news_article&version_code=363&device_platform=android&device_type=MI%203&os_api=19&os_version=4.4.2&uuid=860311024465601&openudid=88f5ef1529cd116d";
            [_education startUrlRequest:_education.urlString];
            _education.view.frame = CGRectMake(320*28, 0, 320, 460-74);
            
        }
            break;

        default:
            break;
    }
    
    
    for (UIButton *button in tagButtonArray) {
        button.selected = NO;
    }
    sender.selected = YES;
    
}

/**********************************************************/
#pragma mark- 加载表示图
- (void)layoutTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, 320,460-74) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:_tableView];
}

#pragma mark- 接受网络请求后并处理传回来的数据
-(void)detailContent:(NSNotification *)notification
{
    NSArray *tempArray = [notification object];
    for (int i=tempArray.count-1; i>=0; i--) {
        [textArray insertObject:[tempArray objectAtIndex:i] atIndex:0];
    }
    
    NewsModel *model = [textArray objectAtIndex:0];
    [_tableView reloadData];
    
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showInfo:) userInfo:model.display_info repeats:NO];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];

    
}
- (void)showInfo:(NSTimer *)timer
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 280, 20)];
    label.backgroundColor = [UIColor colorWithRed:0.3765 green:0.7373 blue:0.9725 alpha:0.8];
    label.tag = 1000;
    label.text = timer.userInfo;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    [self performSelector:@selector(delay) withObject:self afterDelay:2.1];
    [self reloadTable];
    
}
- (void)delay
{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:1000];
    [label removeFromSuperview];
//        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTable) userInfo:nil repeats:NO];

}
- (void)delayJoke:(NSTimer *)timer
{
    //    _jokeVC = [[JokeViewController alloc]init];
    //    _jokeVC.view.frame = CGRectMake(320 *2, 0, 320, 460-74);
    //    [mainScrollView addSubview:_jokeVC.view];
}

#pragma mark － UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [[NewsModel alloc]init];
    model = [textArray objectAtIndex:indexPath.row];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    return currentDate;
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArray.count;
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
    model = [textArray objectAtIndex:indexPath.row];
    
    
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
//    NSLog(@"model.has_image  is  %@",model.has_image);
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
    model = [textArray objectAtIndex:indexPath.row];
    //    NSLog(@"model.share_url  %@",model.share_url);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detaila = [[DetailViewController alloc]init];
    
    detaila.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    detaila.strURl = model.share_url;
    detaila.receivcMoedel = model;
    [self presentModalViewController:detaila animated:YES];
    
    
    
}
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    if (scrollView.contentOffset.y <= -40) {
        NSString *str = [NSString stringWithFormat:@"%i",(NSInteger)(scrollView.contentOffset.x/320+101)];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tag" object:str];
        UIButton *button = [[UIButton alloc]init];
        button = (UIButton *)[self.view viewWithTag:[str integerValue]];
        [self changeType:button];
    }
    //MyClassDemo/网络数据定位/头条副本/头条/controller/joke/JokeViewController.m/    NSLog(@"==========================================");
//    NSLog(@"fram is %i",(NSInteger)scrollView.contentOffset.x/320);
//    NSString *str = [NSString stringWithFormat:@"%i",(NSInteger)(scrollView.contentOffset.x/320+101)];
//    NSLog(@"str is %@",str);
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"tag" object:str];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"contentOffset.y,%f",scrollView.contentOffset.y);
//    NSLog(@"contentOffset.x,%f",scrollView.contentOffset.x);
    NSInteger number = (NSInteger)(scrollView.contentOffset.x/320);
    
    if (number != scrollViewTag) {
        
        NSString *str = [NSString stringWithFormat:@"%i",(NSInteger)(scrollView.contentOffset.x/320+101)];
        UIButton *button = [[UIButton alloc]init];
        button = (UIButton *)[self.view viewWithTag:[str integerValue]];
        [self changeType:button];
        //            [[NSNotificationCenter defaultCenter]postNotificationName:@"tag" object:str];
    }
    scrollViewTag = number;
}


#pragma mark -JokeViewControllerDelegate

- (void)openJokeDetailModelView:(NSString *)urlString
{
    JokeDetailViewController *detaila = [[JokeDetailViewController alloc]init];
    detaila.urlString = urlString;

    [self presentModalViewController:detaila animated:YES];
}
- (void)popUpShareMessage
{
    UIControl *myController = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    myController.backgroundColor = [UIColor blackColor];
    myController.alpha = 0.5;
    myController.tag = 678;
    [myController addTarget:self action:@selector(closeShareMessage) forControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"self.view ---%@",self.view.superview);
    [self.view addSubview:myController];
    
        [UIView animateWithDuration:2 animations:^() {
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
            label.layer.cornerRadius = 15;
            [view4 addSubview:label];
            
            UIButton *button12 = [[UIButton alloc]initWithFrame:CGRectMake(11, 221, 298, 28)];
            button12.tag = 312;
            button12.layer.cornerRadius = 6;
            [button12 setTitle:@"取消分享" forState:UIControlStateNormal];
            [button12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button12.backgroundColor = [UIColor whiteColor];
            [button12 addTarget:self action:@selector(closeShareMessage) forControlEvents:UIControlEventTouchUpInside];
            [view4 addSubview:button12];

        }];
}
- (void)saveEssay:(JokeModel *)model selected:(BOOL)selected
{
    //弹出提示框
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(120, 190, 80, 80)];
    view1.backgroundColor = [UIColor blackColor];
    view1.tag = 316;
    view1.layer.cornerRadius = 6;
    [self.view addSubview:view1];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
    [view1 addSubview:imageView1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 60, 20)];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:label];
    EssayCoreManager *essay = [[EssayCoreManager alloc]init];
    
    if (selected == YES) {
        
        imageView1.image = [UIImage imageNamed:@"ic_toast_fav"];
        label.text = @"收藏成功";
        [essay addEssayModel:model];
    } else{
        
        imageView1.image = [UIImage imageNamed:@"ic_toast_unfav"];
        label.text = @"取消收藏";
        [essay removeEssayModel:model];
    }
    [self performSelector:@selector(closePromptMessage) withObject:self afterDelay:1];
}

//自动关闭提示成功与否的消息
-(void)closePromptMessage
{
    
    UIView *view = [self.view viewWithTag:316];
    [view removeFromSuperview];
    
}
//关闭提示框
- (void)closeShareMessage{
    
    UIControl *myController = (UIControl *)[self.view viewWithTag:678];
    UIView *view = [self.view viewWithTag:400];
    [view removeFromSuperview];
    [myController removeFromSuperview];
}
//关闭分享界面
-(void)shareClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 312:
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


#pragma mark - LeftViewControllerDelegate
-(void)leftTableView:(UIViewController *)leftController detailView:(NSString *)nameString
{
    Class c = NSClassFromString(nameString);
    UIViewController *myViewController = [[c alloc]init];
    [_contentView addSubview:myViewController.view];
    myViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:myViewController animated:YES];
}
- (void)didOpenLeftTableView
{
    
}
#pragma mark-EducationViewControllerDelegate
- (void)openDetailModelView:(NewsModel *)model URl:(NSString *)urlStrig
{
    DetailViewController *detaila = [[DetailViewController alloc]init];
    
    detaila.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    detaila.strURl = urlStrig;
    detaila.receivcMoedel = model; 
    [self presentModalViewController:detaila animated:YES];
}
@end

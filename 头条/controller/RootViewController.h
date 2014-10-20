//
//  RootViewController.h
//  今日头条
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftViewController.h"
#import "RightViewController.h"
//#import "PositiveEnergyVC.h"
#import "JokeViewController.h"
#import "BeautyGirlViewController.h"
//#import "SocietyViewController.h"
#import "EducationViewController.h"
//#import "HousePropertyVC.h"
#import "FunnyPictureVC.h"


@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,JokeViewControllerDelegate,LeftViewControllerDelegate,EducationViewControllerDelegate,FunnyPictureVCDelegate>

@property (nonatomic,strong) LeftViewController *leftVC;
@property (nonatomic,strong) RightViewController *rightVC;
//@property (nonatomic,strong) PositiveEnergyVC *positive;
@property (nonatomic,strong) JokeViewController *jokeVC;
@property (nonatomic,strong) BeautyGirlViewController *beauty;
@property (nonatomic,strong) EducationViewController *education;
//@property (nonatomic,strong) SocietyViewController *society;
//@property (nonatomic,strong) HousePropertyVC *house;
@property (nonatomic,strong) FunnyPictureVC *funnyVC;
@property (nonatomic,strong) UIView *contentView;

- (void)layoutNavigationItem;//加载自定义导航栏视图
- (void)layoutTabbarController;
- (void)personalCenter:(UIButton *)sender;
- (void)didOpenLeftView;//打开左侧视图（动态）
- (void)didOpenLeftTableView;//打开左侧视图
- (void)didOpenRightView;
- (void)changeType:(UIButton *)sender;
- (void)layoutTableView;
//- (void)change:(NSNotification *)notifacation;
- (void)detailContent:(NSNotification *)notification;
- (void)showInfo:(NSTimer *)timer;
- (void)delay;
@end

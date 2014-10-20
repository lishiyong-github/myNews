//
//  FunnyPictureVC.h
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeModel.h"
@protocol FunnyPictureVCDelegate <NSObject,UIAlertViewDelegate,UIScrollViewDelegate>

- (void)openJokeDetailModelView:(NSString *)urlString;
- (void)popUpShareMessage;
@end

@interface FunnyPictureVC : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) id<FunnyPictureVCDelegate>funnyDelegate;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSString *urlString;
- (void)startUrlRequest:(NSString *)urlStr;

@end

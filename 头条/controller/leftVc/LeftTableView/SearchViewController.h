//
//  SearchViewController.h
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (nonatomic,strong) NSMutableArray *textArray;
@property (nonatomic,strong) NSMutableData *data;
@property (nonatomic,strong) UITableView *tableView;

- (void)layoutHeaderView;
- (void)dismissModal;
- (void)layoutSearchNews;
- (void)layoutTableView;

//网络请求
- (void)setUrl:(NSURL *)url;
@end

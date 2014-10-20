//
//  LeftViewController.h
//  今日头条
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

@protocol LeftViewControllerDelegate <NSObject>

- (void)leftTableView:(UIViewController *)leftController detailView:(NSString *)nameString;

@end


#import <UIKit/UIKit.h>


@interface LeftViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *tableView ;
    NSString *h;
}

@property (nonatomic,weak) id <LeftViewControllerDelegate> leftDelegate;
- (void)layoutTableView;
- (void)layoutLogin;

@end

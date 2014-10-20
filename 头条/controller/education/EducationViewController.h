//
//  EducationViewController.h
//  头条
//
//  Created by  on 14-10-2.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NewsModel.h"
@protocol EducationViewControllerDelegate <NSObject>

- (void)openDetailModelView:(NewsModel *)model URl:(NSString *)urlStrig;
@end



@interface EducationViewController : UITableViewController

@property (nonatomic,strong) id<EducationViewControllerDelegate>educationDelegate;
@property (nonatomic,strong) NSMutableArray *textArray;
@property (nonatomic,strong) NSString *urlString;

- (void)startUrlRequest:(NSString *)urlStr;
- (void)reloadTable;
@end

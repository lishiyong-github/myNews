//
//  SocietyViewController.h
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocietyViewControllerDelegate <NSObject>

- (void)openDetailModelView:(NSString *)urlString;
@end

@interface SocietyViewController : UITableViewController


@property (nonatomic,strong) id<SocietyViewControllerDelegate>societyDelegate;
@property (nonatomic,strong) NSMutableArray *textArray;

- (void)startUrlRequest:(NSString *)urlStr;
- (void)reloadTable;
@end

//
//  HousePropertyVC.h
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

@protocol HousePropertyVCDelegate <NSObject>

- (void)openDetailModelView:(NSString *)urlString;
@end

#import <UIKit/UIKit.h>

@interface HousePropertyVC : UITableViewController

@property (nonatomic,strong) id<HousePropertyVCDelegate>houseDelegate;
@property (nonatomic,strong) NSMutableArray *textArray;

- (void)startUrlRequest:(NSString *)urlStr;
- (void)reloadTable;
@end

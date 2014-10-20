//
//  PositiveEnergyVC.h
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

@protocol PositiveEnergyVCDelegate <NSObject>

- (void)openDetailModelView:(NSString *)urlString;
@end

#import <UIKit/UIKit.h>

@interface PositiveEnergyVC : UITableViewController

@property (nonatomic,strong) id<PositiveEnergyVCDelegate>positiveEnergyDelegate;
@property (nonatomic,strong) NSMutableArray *textArray;

- (void)startUrlRequest:(NSString *)urlStr;
- (void)reloadTable;
@end

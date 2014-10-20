//
//  JokeViewController.h
//  今日头条
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeModel.h"
@protocol JokeViewControllerDelegate <NSObject>

- (void)openJokeDetailModelView:(NSString *)urlString;
- (void)popUpShareMessage;
- (void)saveEssay:(JokeModel *)model selected:(BOOL)selected;
@end

@interface JokeViewController : UITableViewController<UIAlertViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) id<JokeViewControllerDelegate>delegate;
@end

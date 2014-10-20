//
//  SaveViewController.h
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (void)layoutHeaderView;
- (void)addTableView1;
- (void)dismissModal;
- (void)editingTable:(UIButton *)sender;
@end

//
//  ActivityViewController.h
//  今日头条
//
//  Created by  on 14-9-27.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>

- (void)layoutHeaderView;
- (void)dismissModal;
- (void)layoutWebView;
@end

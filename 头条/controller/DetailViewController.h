//
//  DetailViewController.h
//  今日头条
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface DetailViewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>


@property (nonatomic,strong) NSString *strURl;
@property (nonatomic,strong) NewsModel *receivcMoedel;
@property (nonatomic,assign) BOOL saveSelected;
- (void)layoutNavigationItem;
- (void)layoutTabbarController;

@end

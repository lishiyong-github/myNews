//
//  BeautyCell.h
//  今日头条
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyCell : UITableViewCell
@property (nonatomic,strong) UILabel *diggLabel;
@property (nonatomic,strong) UIButton *digg_button;
@property (nonatomic,strong) UILabel *buryLabel;
@property (nonatomic,strong) UIButton *bury_button;
@property (nonatomic,strong) UILabel *saveLabel;
@property (nonatomic,strong) UIButton *save_button;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UIButton *comment_button;
@property (nonatomic,strong) UILabel *shareLabel;
@property (nonatomic,strong) UIButton *share_button;
@end

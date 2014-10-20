//
//  FunnyCell.h
//  头条
//
//  Created by  on 14-10-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunnyCell : UITableViewCell
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,strong) UIImageView *imageView1;
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


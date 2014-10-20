//
//  BeautyCell.m
//  今日头条
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BeautyCell.h"

@implementation BeautyCell

@synthesize digg_button = _digg_button,bury_button = _bury_button,save_button = _save_button,comment_button  = _comment_button,share_button = _share_button,diggLabel = _diggLabel,buryLabel = _buryLabel,saveLabel = _saveLabel,commentLabel = _commentLabel,shareLabel = _shareLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _diggLabel = [[UILabel alloc]init];
        _digg_button = [[UIButton alloc]init];
        _buryLabel = [[UILabel alloc]init];
        _bury_button = [[UIButton alloc]init];
        _save_button = [[UIButton alloc]init];
        _comment_button = [[UIButton alloc]init];
        _share_button = [[UIButton alloc]init];
        _commentLabel = [[UILabel alloc]init];
        _saveLabel = [[UILabel alloc]init];
        _shareLabel = _saveLabel;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(10, 10, 300, self.frame.size.height-20);
    self.imageView.frame = CGRectMake(5, 5, 290, self.contentView.frame.size.height-75);
    _diggLabel.frame = CGRectMake(5, self.imageView.frame.size.height+10, 60, 15);
    _digg_button.frame = CGRectMake(6, self.imageView.frame.size.height+11, 58, 13);
    _buryLabel.frame = CGRectMake(_diggLabel.frame.size.width + 5+15, _digg_button.frame.origin.y,60, 15);
    _bury_button.frame = CGRectMake(_diggLabel.frame.size.width + 5+15+1, _digg_button.frame.origin.y+1,60-2, 15-2);
    _saveLabel.frame = CGRectMake(_buryLabel.frame.size.width+15+_buryLabel.frame.origin.x, _diggLabel.frame.origin.y, 20, 15);
    _save_button.frame = CGRectMake(_buryLabel.frame.size.width+_buryLabel.frame.origin.x+16, _buryLabel.frame.origin.y+1, 18, 13);
    _comment_button.frame = CGRectMake(_save_button.frame.origin.x + _save_button.frame.size.width+11, _buryLabel.frame.origin.y+1, 68, 13);
    _commentLabel.frame = CGRectMake(_save_button.frame.origin.x + _save_button.frame.size.width+10, _buryLabel.frame.origin.y, 70, 15);
    _shareLabel.frame = CGRectMake(_commentLabel.frame.origin.x+_commentLabel.frame.size.width+10, _diggLabel.frame.origin.y, 35, 15);
    _share_button.frame = CGRectMake(_commentLabel.frame.origin.x+_commentLabel.frame.size.width+11, _diggLabel.frame.origin.y+1, 33, 13);
    
    
    self.contentView.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1];
    //    self.contentView.backgroundColor = [UIColor blackColor];
    _diggLabel .backgroundColor = [UIColor grayColor]; 
    _digg_button.backgroundColor = [UIColor whiteColor];
    _buryLabel.backgroundColor = [UIColor grayColor];
    _bury_button.backgroundColor = [UIColor whiteColor];
    _saveLabel.backgroundColor = [UIColor grayColor];
    _save_button.backgroundColor = [UIColor whiteColor];
    _commentLabel.backgroundColor = [UIColor grayColor];
    _comment_button.backgroundColor = [UIColor whiteColor];
    _shareLabel.backgroundColor = [UIColor grayColor];
    _share_button.backgroundColor = [UIColor whiteColor];
    
    [_digg_button setImage:[UIImage imageNamed:@"essay_image_list_digg_icon_normal"] forState:UIControlStateNormal];
    [_digg_button setImage:[UIImage imageNamed:@"essay_image_list_digg_icon_selected"] forState:UIControlStateSelected];
    
    [self.bury_button setImage:[UIImage imageNamed:@"essay_image_list_bury_icon_normal"] forState:UIControlStateNormal];
    [self.bury_button setImage:[UIImage imageNamed:@"essay_image_list_bury_icon_selected"] forState:UIControlStateSelected];
    
    [_save_button setImage:[UIImage imageNamed:@"essay_image_list_favor_icon_normal"] forState:UIControlStateNormal]; 
    //    [_save_button setImage:[UIImage imageNamed:@"essay_image_list_favor_icon_selected"] forState:UIControlStateSelected];
    [_save_button setImage:[UIImage imageNamed:@"ic_action_favor_on_normal"] forState:UIControlStateSelected];
    [_comment_button setImage:[UIImage imageNamed:@"essay_image_list_comment_btn_normal.9"] forState:UIControlStateNormal];
    
    [_share_button setTitle:@"分享" forState:UIControlStateNormal];
    _share_button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_share_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    //    [_digg_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    //    [_bury_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    //    [_save_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    //    [_comment_button addTarget:self action:@selector(selectedEssayImageFavor:) forControlEvents:UIControlEventTouchUpInside];
    //    
    

    [self.contentView addSubview:_diggLabel];
    [self.contentView addSubview:_digg_button];
    [self.contentView addSubview:_buryLabel];
    [self.contentView addSubview:_bury_button];
    [self.contentView addSubview:_saveLabel];
    [self.contentView addSubview:_save_button];
    [self.contentView addSubview:_commentLabel];
    [self.contentView addSubview:_comment_button];
    [self.contentView addSubview:_shareLabel];
    [self.contentView addSubview:_share_button];
    
} 

@end

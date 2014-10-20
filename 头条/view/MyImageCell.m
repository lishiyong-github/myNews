//
//  MyImageCell.m
//  今日头条
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MyImageCell.h"

@implementation MyImageCell

@synthesize label = _label;
@synthesize button = _button;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _label = [[UILabel alloc]init];
        _button = [[UIButton alloc]init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.contentView.frame.size.height >= 100) {
        self.imageView.frame = CGRectMake(230, 10, 80, 70);
        
        self.textLabel.frame = CGRectMake(10, 10, 210, self.contentView.frame.size.height-60);
        
        self.detailTextLabel.frame = CGRectMake(10, self.contentView.frame.size.height-20, 150, 10);
    }else{
        self.textLabel.frame = CGRectMake(10, 10, 300, self.contentView.frame.size.height-30);
        
        self.detailTextLabel.frame = CGRectMake(10, self.contentView.frame.size.height-20, 150, 10);
    }
    
    _label.frame = CGRectMake(170, self.contentView.frame.size.height-20, 120, 10);
    [self.contentView addSubview:_label];
    
    
    _button.frame = CGRectMake(300, self.contentView.frame.size.height-20, 10, 10);
    _button.backgroundColor = [UIColor whiteColor];
    [_button setImage:[UIImage imageNamed:@"popicon_listpage_normal"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(showInfoLikeability) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];

}

//显示黑条 对该文章的兴趣程度
- (void)showInfoLikeability;
{
    UIControl *myController = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    myController.backgroundColor = [UIColor blackColor];
    myController.alpha = 0.2;
    myController.tag = 678;
    [myController addTarget:self action:@selector(closeHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.superview.superview.superview.superview.superview.superview addSubview:myController];
    
    
    UIView *likeView = [[UIView alloc]initWithFrame:CGRectMake(40, self.contentView.frame.size.height-30, 280, 30)];
    likeView.tag = 100;
    likeView.layer.cornerRadius = 5;
    [likeView setHidden:NO];
    likeView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:likeView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 14, 14)];
    imageView1.image = [UIImage imageNamed:@"listpage_more_speak_normal"];
    [likeView addSubview:imageView1];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 80, 10)];
    button1.contentMode = UIViewContentModeScaleAspectFit;
    [button1 setTitle:@"读文章" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:12];
    [likeView addSubview:button1];
    
    

    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(90, 8, 14, 14)];
    imageView2.image = [UIImage imageNamed:@"listpage_more_like_normal"];
    [likeView addSubview:imageView2];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(80, 10, 80, 10)];    
    [button2 setTitle:@"收藏" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [button2 addTarget:self action:@selector(saveArticle:) forControlEvents:UIControlEventTouchUpInside];
    [likeView addSubview:button2];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(168, 8, 14, 14)];
    imageView3.image = [UIImage imageNamed:@"listpage_more_dislike_normal"];
    [likeView addSubview:imageView3];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(160, 10, 80, 10)];
    [button3 setTitle:@"感兴趣" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:12];
    [likeView addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(250 , 10, 10, 10)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"ic_close_history_normal"]forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(closeHistory) forControlEvents:UIControlEventTouchUpInside];
    [likeView addSubview:button4];
   
}
 
- (void)closeHistory
{ 
    UIControl *myController = (UIControl *)[self.superview.superview.superview.superview.superview viewWithTag:678];
    UIView *likeView = [self.contentView viewWithTag:100];
    [likeView removeFromSuperview];
    [myController removeFromSuperview];
   
}


@end

//
//  JokeModel.h
//  今日头条
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject

@property (nonatomic,strong) NSString *share_url;//网址
@property (nonatomic,strong) NSString *content;//内容
@property (nonatomic,strong) NSString *imageUrl;//图片网址
@property (nonatomic,strong) NSNumber *imageHeight;
@property (nonatomic,strong) NSNumber *imageWidth;
@property (nonatomic,strong) NSNumber *digg_count;//好评数
@property (nonatomic,strong) NSNumber *bury_count;//差评数
@property (nonatomic,strong) NSNumber *comment_count;//用户评论
@property (nonatomic,strong) NSNumber *display_info;



@end

//
//  NewsModel.h
//  今日头条
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *share_url;
@property(nonatomic,strong) NSString *source;
@property(nonatomic,strong) NSString *group_id;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *has_image;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) NSString *display_info;
@property(nonatomic,strong) NSString *imageUrl;
@end

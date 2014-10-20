//
//  ImageConnection.h
//  今日头条
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageConnection : UIImageView<NSURLConnectionDelegate,NSURLConnectionDataDelegate>


@property(nonatomic,retain)NSMutableData *data;

- (void)setURL:(NSURL *)url;

@end

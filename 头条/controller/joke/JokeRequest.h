//
//  JokeRequest.h
//  今日头条
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeRequest : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

- (void)startRequest:(NSURL *)url;


@end

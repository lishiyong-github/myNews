//
//  WebConnection.h
//  今日头条
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebConnection : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>


- (void)setUrl:(NSURL *)url;



@end

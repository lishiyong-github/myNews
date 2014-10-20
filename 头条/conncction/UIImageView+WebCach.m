//
//  UIImageView+WebCach.m
//  今日头条
//
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+WebCach.h"

@implementation UIImageView (WebCach)
- (void)setImageWithURL:(NSURL *)url {
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse* respone, NSData* data, NSError* error){
                               //该block是多线程调用的
                               UIImage *image = [UIImage imageWithData:data];
                               //回到主线程
                               dispatch_async(dispatch_get_main_queue() , ^ {
                                   self.image = image;

                            
                               });

                           }];
 
}
@end

//
//  ImageConnection.m
//  今日头条
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ImageConnection.h"

@implementation ImageConnection

{
    NSMutableArray *imageArray;
}

@synthesize data = _data;
- (void)setURL:(NSURL *)url {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    
    //发送一个异步请求
   NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        self.data = [NSMutableData data];
    
        imageArray = [NSMutableArray array];
    }
    
    
}

#pragma mark - NSURLConnection delegate
//数据加载过程中调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

//数据加载完成后调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"加载完成");
    UIImage *image = [UIImage imageWithData:self.data];
    self.image = image;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadImage" object:self.image];
}
@end

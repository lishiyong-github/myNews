//
//  WebConnection.m
//  今日头条
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "WebConnection.h"
#import "CFNetwork/CFNetwork.h"
#import "NewsModel.h"
#import "UIImageView+WebCach.h"
#import "ImageConnection.h"
@implementation WebConnection
{
    NSMutableData *_data;
    NSMutableArray *textArray;
//    NSMutableArray *imageArray;
}

- (void)setUrl:(NSURL *)url
{

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        _data = [NSMutableData new];
        textArray = [NSMutableArray array];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    NSArray *data = [JSONDictionary objectForKey:@"data"];
    NSDictionary *tips = [JSONDictionary objectForKey:@"tips"];
    
//    NSLog(@"请求完成%@",array);
    for (NSDictionary *dic in data) {
        NewsModel *model = [[NewsModel alloc]init];
        model.title = [dic objectForKey:@"title"];
        model.share_url = [dic objectForKey:@"share_url"];
        model.source = [dic objectForKey:@"source"];
        model.url = [dic objectForKey:@"url"];
        model.has_image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"has_image"]];
        model.display_info = [tips objectForKey:@"display_info"];
//        NSLog(@"model.title  %@",model.title);
            
        if ([model.has_image isEqualToString:@"1"]) {
            NSDictionary *dic1 = [dic objectForKey:@"middle_image"];
//            ImageConnection *imageConnection = [[ImageConnection alloc]init];
//            NSURL *url = [NSURL URLWithString:[dic1 objectForKey:@"url"]];
//            [imageConnection setURL:url];
//            model.imageView.image = imageConnection.image;
            model.imageUrl = [dic1 objectForKey:@"url"];
            
        } else {
            model.imageView = nil;
        }
        [textArray addObject:model];
//        NSString *str  = model.url;
//        NSLog(@" str  %@",str);


    }       
    [[NSNotificationCenter defaultCenter]postNotificationName:@"detailContent" object:textArray];

}
@end

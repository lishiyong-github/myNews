//
//  JokeRequest.m
//  今日头条
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "JokeRequest.h"
#import "JokeModel.h"
@implementation JokeRequest

{
    NSMutableData *datas;
    NSMutableArray *textArray;
}
- (void)startRequest:(NSURL *)url
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        datas = [NSMutableData new];
        textArray = [NSMutableArray array];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datas appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"请求完成！！！！");
    NSDictionary *jSONDictionary = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = [jSONDictionary objectForKey:@"data"];
    
//    NSLog(@"array is %@",array);
    for (NSDictionary *dict in array) {
        JokeModel *jmodel = [[JokeModel alloc]init];
        jmodel.share_url = [dict objectForKey:@"share_url"];
        jmodel.content = [dict objectForKey:@"content"];
        jmodel.digg_count = [dict objectForKey:@"digg_count"];
        jmodel.bury_count = [dict objectForKey:@"bury_count"];
        jmodel.comment_count = [dict objectForKey:@"comment_count"];
        jmodel.display_info = [jSONDictionary objectForKey:@"total_number"];
//        NSLog(@"jmodel.commentCount,%@",jmodel.comment_count);
        [textArray addObject:jmodel];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JokeTextArray" object:textArray];
}

@end

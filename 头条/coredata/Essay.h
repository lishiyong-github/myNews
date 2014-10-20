//
//  Essay.h
//  头条
//
//  Created by  on 14-10-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Essay : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * shareUrl;

@end

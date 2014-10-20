//
//  Article.h
//  头条
//
//  Created by  on 14-10-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * shareUrl;
@property (nonatomic, retain) NSString * hasImage;
@property (nonatomic, retain) NSString * imageUrl;

@end

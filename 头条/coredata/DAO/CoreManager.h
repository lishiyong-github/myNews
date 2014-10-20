//
//  CoreManager.h
//  头条
//
//  Created by  on 14-10-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "JokeModel.h"
#import "CoreData/CoreData.h"
@interface CoreManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)addArticleModel:(NewsModel *)model;
- (void)removeArticleModel:(NewsModel *)model;
- (BOOL)findArtivleModel:(NewsModel *)model;
- (NSMutableArray *)findAllArticle;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

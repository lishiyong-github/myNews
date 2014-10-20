//
//  EssayCoreManager.h
//  头条
//
//  Created by  on 14-10-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JokeModel.h"
#import "CoreData/CoreData.h"
@interface EssayCoreManager : NSObject



@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)addEssayModel:(JokeModel *)model;
- (void)removeEssayModel:(JokeModel *)model;
- (BOOL)findEssayModel:(JokeModel *)model;
- (NSMutableArray *)findAllEssay;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
